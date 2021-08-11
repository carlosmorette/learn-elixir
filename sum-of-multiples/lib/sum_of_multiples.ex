defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Enum.reduce([], fn f, acc ->
      range = 1..(limit - 1)
      acc ++ filter(range, f, acc)
    end)
    |> Enum.sum()
  end

  def filter(range, f, acc) do
    Enum.filter(range, &if(rem(&1, f) == 0 and &1 not in acc, do: &1))
  end
end
