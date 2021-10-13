defmodule Matrix do
  defstruct matrix: nil

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(<<char::utf8, ""::binary>>) do 
    %Matrix{matrix: [[String.to_integer(<<char>>)]]}
  end

  def from_string(input) do
    result = 
      input
      |> String.split("\n")
      |> Enum.map(fn spl ->
        spl
        |> String.split(" ")
        |> Enum.map(&String.to_integer/1)
      end)

    %Matrix{matrix: result}
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(%Matrix{matrix: matrix}) do
    Enum.reduce(matrix, [], fn m, acc -> 
      join = Enum.join(m, " ")
      acc ++ ["#{join}\n"]
    end)
    |> Enum.join()
    |> String.slice(0..-2)
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(%Matrix{matrix: matrix}) do
    matrix
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(%Matrix{matrix: matrix}, index) do
    Enum.at(matrix, index - 1)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(%Matrix{matrix: matrix}) do
    do_columns(matrix, 0, [])
  end

  def do_columns(matrix, turns, result) do
    if turns == Enum.count(matrix) do
      result
    else
      do_columns(
        matrix, 
        turns + 1, 
        result ++ [Enum.map(matrix, &Enum.at(&1, turns))]
      )
    end
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(%Matrix{matrix: matrix}, index) do
    Enum.map(matrix, &Enum.at(&1, index - 1))
  end
end
