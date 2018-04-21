defmodule Beautify.AdressController do
  use Beautify.Web, :controller

  alias Beautify.Adress

  def index(conn, _params) do
    adresses = Repo.all(Adress)
    render(conn, "index.html", adresses: adresses)
  end

  def new(conn, %{"client_id" => client_id}) do
    changeset = Adress.changeset(%Adress{client_id: client_id})
    conn
    |> put_resp_header("x-ic-trigger", "show-overlay")
    |> render(Beautify.AdressView, "new.html", changeset: changeset, conn: conn)

    #<a ic-get-from="edit/adresses/new" ic-target='#popup_placeholder' class="btn btn-default btn-xs" ic-success-action="style.visibility = visible">Add Adress</a>
    #<tr>
    #  <td></td>
    #  <td class="text-right">
    #    <a ic-get-from="edit/adresses/new" ic-target='#popup_placeholder' class="btn btn-default btn-xs" ic-success-action="style.visibility = visible">Add Adress</a>
    #  </td>
    #</tr>

  end

  def new(conn, %Beautify.Supplier{} = supplier) do
    changeset = Adress.changeset(%Adress{supplier_id: supplier.id})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{adress: %{client_id: client_id} = adress_params}) do
    changeset = Adress.changeset(%Adress{}, adress_params)

    case Repo.insert(changeset) do
      {:ok, adress} ->
        conn
        |> put_flash(:info, "Adress created successfully.")
        |> redirect(to: client_path(conn, :edit, %{id: client_id}))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
  def create(conn, %{adress: %{supplier_id: supplier_id} = adress_params}) do
    changeset = Adress.changeset(%Adress{}, adress_params)

    case Repo.insert(changeset) do
      {:ok, adress} ->
        conn
        |> put_flash(:info, "Adress created successfully.")
        |> redirect(to: client_path(conn, :edit, %{id: supplier_id}))
      {:error, changeset} ->
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
        conn
        |> put_flash(:info, "Adress updated successfully.")
        |> redirect(to: adress_path(conn, :show, adress))
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
    |> redirect(to: adress_path(conn, :index))
  end
end
