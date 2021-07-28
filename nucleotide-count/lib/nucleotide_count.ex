defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a DNA strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """

  def count('', _), do: 0

  @spec count(charlist(), char()) :: non_neg_integer()
  def count(strand, nucleotide) do
    Enum.reduce(strand, 0, fn i, acc -> if i == nucleotide, do: acc + 1, else: acc end)
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  def histogram(''),
    do: Enum.reduce(@nucleotides, %{}, fn n, acc -> Map.merge(acc, %{n => 0}) end)

  @spec histogram(charlist()) :: map()
  def histogram(strand) do
    Enum.reduce(strand, histogram(''), fn n, acc ->
      Map.merge(acc, %{n => 1}, fn _kv, v1, v2 -> v1 + v2 end)
    end)
  end
end
