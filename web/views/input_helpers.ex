defmodule Beautify.InputHelpers do
  use Phoenix.HTML

def hidden_table_input(form, field, id) do
    value = Phoenix.HTML.Form.input_value(form, field) || [[]]
    id = Phoenix.HTML.Form.input_id(form,field)
    type = Phoenix.HTML.Form.input_type(form, field)

    content_tag(:ol, value, id: id, hidden: true, value: value, name: "price_array")

  end

end
