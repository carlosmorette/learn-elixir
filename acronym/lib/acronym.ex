defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()

  def abbreviate(string) do
    string
    |> String.split([" ", "-", "_"])
    |> Enum.map(&String.at(&1, 0))
    |> Enum.filter(& &1)
    |> Enum.map(&String.capitalize(&1))
    |> Enum.join("")
  end
end
