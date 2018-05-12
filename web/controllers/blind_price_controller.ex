defmodule Beautify.BlindPriceController do
  use Beautify.Web, :controller

  alias Beautify.BlindPrice

  def index(conn, _params) do
    blind_prices = Repo.all(BlindPrice)
    render(conn, "index.html", blind_prices: blind_prices)
  end

  def new(conn, _params) do
    changeset = BlindPrice.changeset(%BlindPrice{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"blind_price" => blind_price_params}) do
    changeset = BlindPrice.changeset(%BlindPrice{}, blind_price_params)

    case Repo.insert(changeset) do
      {:ok, _blind_price} ->
        conn
        |> put_flash(:info, "Blind price created successfully.")
        |> redirect(to: blind_price_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    blind_price = Repo.get!(BlindPrice, id)
    render(conn, "show.html", blind_price: blind_price)
  end

  def edit(conn, %{"id" => id}) do
    blind_price = Repo.get!(BlindPrice, id)
    changeset = BlindPrice.changeset(blind_price)
    render(conn, "edit.html", blind_price: blind_price, changeset: changeset)
  end

  def update(conn, %{"id" => id, "blind_price" => blind_price_params}) do
    blind_price = Repo.get!(BlindPrice, id)
    changeset = BlindPrice.changeset(blind_price, blind_price_params)

    case Repo.update(changeset) do
      {:ok, blind_price} ->
        conn
        |> put_flash(:info, "Blind price updated successfully.")
        |> redirect(to: blind_price_path(conn, :show, blind_price))
      {:error, changeset} ->
        render(conn, "edit.html", blind_price: blind_price, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    blind_price = Repo.get!(BlindPrice, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(blind_price)

    conn
    |> put_flash(:info, "Blind price deleted successfully.")
    |> redirect(to: blind_price_path(conn, :index))
  end
end
