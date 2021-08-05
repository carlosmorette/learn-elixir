defmodule Scrabble do
  # """
  #   Rules:
  #   Letter                           Value
  #   A, E, I, O, U, L, N, R, S, T       1
  #   D, G                               2
  #   B, C, M, P                         3
  #   F, H, V, W, Y                      4
  #   K                                  5
  #   J, X                               8
  #   Q, Z                               10
  # """

  @groups %{
    1 => ["a", "e", "i", "o", "u", "l", "n", "r", "s", "t"],
    2 => ["d", "g"],
    3 => ["b", "c", "m", "p"],
    4 => ["f", "h", "v", "w", "y"],
    5 => ["k"],
    8 => ["j", "x"],
    10 => ["q", "z"]
  }

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    if Regex.match?(~r/\s/, word) do
      0
    else
      word
      |> to_charlist()
      |> Enum.map(&String.downcase(<<&1>>))
      |> Enum.reduce(0, &compute(&1) + &2)
    end
  end

  def compute(char) do
    cond do
      char in @groups[1] -> 1
      char in @groups[2] -> 2
      char in @groups[3] -> 3
      char in @groups[4] -> 4
      char in @groups[5] -> 5
      char in @groups[8] -> 8
      char in @groups[10] -> 10
    end
  end
end
