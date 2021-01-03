defmodule Howmanycanplay.Helpers do
  defmacro tsquery(field, text) do
    quote do
      fragment("?::tsvector @@ to_tsquery('english', ?)", unquote(field), unquote(text))
    end
  end

  def split_names_for_tsquery(text) do
    String.split(text, " ", trim: true)
    |> Enum.map(&(&1 <> ":*"))
    |> Enum.intersperse(" & ")
    |> Enum.join()
  end
end
