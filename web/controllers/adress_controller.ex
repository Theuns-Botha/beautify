defmodule Beautify.AdressController do
  use Beautify.Web, :controller

  alias Beautify.Adress

  def index(conn, _params) do
    adresses = Repo.all(Adress)
    render(conn, "index.html", adresses: adresses)
  end

  def new(conn, %{"client" => client_id}) do
    changeset = Adress.changeset(%Adress{client_id: client_id})
    conn
    |> render("new.html", changeset: changeset)
  end

  def new(conn, %{"supplier" => supplier_id}) do
    changeset = Adress.changeset(%Adress{supplier_id: supplier_id})
    conn
    |> render("new.html", changeset: changeset)
  end

  def create(conn, %{"adress" => adress_params}) do
    changeset = Adress.changeset(%Adress{}, adress_params)
    case Repo.insert(changeset) do
      {:ok, adress} ->
        redirect_url = cond do
          adress.client_id != nil -> client_path(conn, :edit, adress.client_id)
          adress.supplier_id != nil -> supplier_path(conn, :edit, adress.supplier_id)
        end

        conn
        |> put_flash(:info, "Adress created successfully.")
        |> redirect(to: redirect_url)
      {:error, changeset} ->
        IO.inspect("not successfully stored")
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    adress = Repo.get!(Adress, id)
    render(conn, "show.html", adress: adress)
  end

  def edit(conn, %{"id" => id}) do
    adress = Repo.get!(Adress, id)
    changeset = Adress.changeset(adress) |> IO.inspect()
    render(conn, "edit.html", adress: adress, changeset: changeset)
  end

  def update(conn, %{"id" => id, "adress" => adress_params}) do
    adress = Repo.get!(Adress, id)
    changeset = Adress.changeset(adress, adress_params)

    case Repo.update(changeset) do
      {:ok, adress} ->
        redirect_url = cond do
          adress.client_id != nil -> client_path(conn, :edit, adress.client_id)
          adress.supplier_id != nil -> supplier_path(conn, :edit, adress.supplier_id)
        end

        conn
        |> put_flash(:info, "Adress updated successfully.")
        |> redirect(to: redirect_url)
      {:error, changeset} ->
        render(conn, "edit.html", adress: adress, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    adress = Repo.get!(Adress, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(adress)

    conn
    |> put_flash(:info, "Adress deleted successfully.")
    |> redirect_to_back()
  end

  def redirect_to_back(conn) do
    path =
      conn
      |> Plug.Conn.get_req_header("referer")
      |> Enum.fetch!(0)
      |> URI.parse
      |> Map.get(:path)

    conn
    #|> assign(:refer_path, path)
    |> redirect(to: path)
  end

end
