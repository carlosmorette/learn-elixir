defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.filter(&check(put(base), put(&1)))
  end

  def check(base, candidate) do
    Enum.sort(base) == Enum.sort(candidate) and base != candidate
  end

  def put(string) do
    string
    |> :string.lowercase()
    |> String.graphemes()
  end

  # def check(base, candidate) do
  #   if String.length(base) == String.length(candidate) and base != candidate do
  #     base
  #     |> String.split("", trim: true)
  #     |> Enum.reduce_while([false, ""], fn l, [can, str] -> 
  #       if String.contains?(candidate, l) do
  #         {:cont, [true, str <> l]}
  #       else
  #         {:halt, false}
  #       end
  #     end)
  #   else
  #     false
  #   end
  # end
end
