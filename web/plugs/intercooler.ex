defmodule Intercooler do

  def get_params(%Plug.Conn{params: params}) do
    get_params(params)
  end
  def get_params(%{"ic-request" => "true"} = params) do
    params
  end
  def get_params(_) do
    nil
  end

  def get_param(data, id, default \\ nil) when is_binary(id) do
    case get_params(data) do
      nil -> nil
      params -> Map.get(params, id, default)
    end
  end

  def active?(data), do: get_params(data) !== nil
  def get_target_id(data), do: get_param(data, "ic-target-id")

end
