defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """

  @spec count(String.t()) :: map
  def count(sentence) do
    characters_for_remove = [":", "!!&@$%^&", ","]

    sentence
    |> String.replace(characters_for_remove, "")
    |> String.replace("_", " ")
    |> String.downcase()
    |> String.split()
    |> Enum.frequencies()
  end
end
