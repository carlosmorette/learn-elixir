defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"aardvark" => "a", "ability" => "a", "ballast" => "b", "beauty" => "b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.map(fn {k, values} -> compute(k, values) end)
    |> Enum.reduce(%{}, &Map.merge(&2, &1))
  end

  def compute(key, values) do
    values
    |> Enum.map(fn value -> %{String.downcase(value) => key} end)
    |> Enum.reduce(%{}, &Map.merge(&2, &1))
  end
end
