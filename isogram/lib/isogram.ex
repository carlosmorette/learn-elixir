defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.split("", trim: false)
    |> Enum.filter(fn c -> Regex.match?(~r/[a-zA-Z]/, c) end)
    |> Enum.reduce_while([], &reduce_fun/2)
    |> Enum.all?()
  end

  def reduce_fun(l, acc) do
    if l in acc, do: {:halt, [false]}, else: {:cont, acc ++ [l]}
  end
end
