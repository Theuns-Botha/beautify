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

  def create(conn, %{"blind_price_sheet" => blind_price_sheet_params}) do
    changeset = BlindPriceSheet.changeset(%BlindPriceSheet{}, blind_price_sheet_params)

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
    blind_price_sheet = Repo.get!(BlindPriceSheet, id)
    render(conn, "show.html", blind_price_sheet: blind_price_sheet)
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
end
