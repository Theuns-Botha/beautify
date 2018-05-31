defmodule Beautify.BlindPriceSheetController do
  use Beautify.Web, :controller

  alias Beautify.BlindPriceSheet

  def index(conn, _params) do
    blind_price_sheets = Repo.all(BlindPriceSheet)
    render(conn, "index.html", blind_price_sheets: blind_price_sheets)
  end

  def new(conn, _params) do
    changeset = BlindPriceSheet.changeset(%BlindPriceSheet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"blind_price_sheet" => blind_price_sheet_params, "price_array_json" => price_array_json}) do

    blind_price_sheet_params = for {key, val} <- blind_price_sheet_params, into: %{}, do: {String.to_atom(key), val}

    new_prices = decode_array(price_array_json)
    |> deconstruct_array()

    #|> Enum.map(fn(price) -> %{id: price.id} end)

    blind_price_sheet_params = Map.put(blind_price_sheet_params, :blind_prices, new_prices)

    changeset = BlindPriceSheet.changeset(%BlindPriceSheet{}, blind_price_sheet_params) |> IO.inspect()

    case Repo.insert(changeset) do
      {:ok, _blind_price_sheet} ->
        conn
        |> put_flash(:info, "Blind price sheet created successfully.")
        |> redirect(to: blind_price_sheet_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    blind_price_sheet = Repo.get!(BlindPriceSheet, id) |> Repo.preload(:blind_prices)
    render(conn, "show.html", blind_price_sheet: blind_price_sheet, price_array_json: encode_array(reconstruct_array(blind_price_sheet.blind_prices)))
  end

  def edit(conn, %{"id" => id}) do
    blind_price_sheet = Repo.get!(BlindPriceSheet, id)
    changeset = BlindPriceSheet.changeset(blind_price_sheet)
    render(conn, "edit.html", blind_price_sheet: blind_price_sheet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "blind_price_sheet" => blind_price_sheet_params}) do
    blind_price_sheet = Repo.get!(BlindPriceSheet, id)
    changeset = BlindPriceSheet.changeset(blind_price_sheet, blind_price_sheet_params)

    case Repo.update(changeset) do
      {:ok, blind_price_sheet} ->
        conn
        |> put_flash(:info, "Blind price sheet updated successfully.")
        |> redirect(to: blind_price_sheet_path(conn, :show, blind_price_sheet))
      {:error, changeset} ->
        render(conn, "edit.html", blind_price_sheet: blind_price_sheet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    blind_price_sheet = Repo.get!(BlindPriceSheet, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(blind_price_sheet)

    conn
    |> put_flash(:info, "Blind price sheet deleted successfully.")
    |> redirect(to: blind_price_sheet_path(conn, :index))
  end

  def deconstruct_array(array) do
    prices = array
    |> Enum.with_index()
    |> Enum.reduce([], fn({row, row_index}, acc) ->
      row_prices = row
      |> Enum.with_index()
      |> Enum.reduce([], fn({entry, column_index}, acc2) ->
        if column_index > 0 and row_index > 0 do
          string_val = nil

          entry = case Integer.parse(entry) do
            {integer, _remainder} -> integer
            :error ->
              string_val = entry
              nil
          end

          matching_height = case Integer.parse(Enum.fetch!(Enum.fetch!(array, row_index), 0)) do
            {integer, _remainder} -> integer
            :error -> nil
          end
          matching_width = case Integer.parse(Enum.fetch!(Enum.fetch!(array, 0), column_index)) do
            {integer, _remainder} -> integer
            :error -> nil
          end

          row_price = #Beautify.BlindPrice.changeset(%Beautify.BlindPrice{},
          %{
            price: entry,
            text_val: string_val,
            row_index: row_index,
            column_index: column_index,
            matching_height: matching_height,
            matching_width: matching_width
          }#)
          #|> Repo.insert!()

          acc2 = acc2 ++ [row_price]
        else
          acc2
        end
      end)
      acc ++ row_prices
    end)
  end

  def reconstruct_array(blind_prices) do
    blind_prices = blind_prices |> Enum.shuffle() |> IO.inspect(label: "shuffled")
    |> Enum.sort(fn(x,y) -> x.row_index <= y.row_index end) |> IO.inspect(label: "sorted")
    |> Enum.chunk_by(fn(x) -> x.row_index end) |> IO.inspect(label: "sorted")
    |> Enum.reduce([], fn(row, acc) ->
      acc = acc ++ [Enum.sort(row, fn(x,y) -> x.column_index <= y.column_index end)]
    end) |> IO.inspect(label: "sorted array")

    array = [[" "] ++ (Enum.fetch!(blind_prices, 0)
    |> Enum.reduce([], fn(x, acc) -> acc ++ [x.matching_width] end))] ++ Enum.reduce(blind_prices, [], fn(row, acc) ->
      converted_row = [Enum.fetch!(row, 0).matching_height] ++ Enum.reduce(row, [], fn(blind_price, col_acc) ->
        col_acc = col_acc ++ [blind_price.price || " "]
      end)
      acc = acc ++ [converted_row]
    end)
  end

  def decode_array(array_string) do
    Jason.decode!(array_string)
  end

  def encode_array(array) do
    Jason.encode!(array)
  end
end
