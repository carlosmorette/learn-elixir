defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(str) do
    str
    |> normalize() 
    |> compute() 
  end

  def compute(str) do
    padding_str = padding_fun(str)
    length = String.length(padding_str)

    rows = 
      1..10
      |> Enum.into([])
      |> Enum.filter(fn n -> filter(n, length) end)
      |> Enum.at(0)

    columns = calculate_column(length, rows)

    if rows do
      padding_str
      |> String.graphemes()
      |> Enum.chunk_every(columns)
      |> reduce_fun(rows, columns, 0, [])
      #|> Enum.join(" ")
      #|> String.trim()
    else
      compute(str <> "  ")
    end
  end

  def reduce_fun(enum, rows, column, curr_column, res) do
    if curr_column == (column - 1) do
      res
    else
      result =
        0..(rows - 1)
        |> Enum.reduce([], fn i, acc ->
          character =
            enum
            |> Enum.at(i)
            |> Enum.at(curr_column)

          acc ++ [character]
        end)
        |> Enum.join()

      IO.inspect(enum, label: "enum...")
      IO.inspect(result, label: "result...")
      IO.inspect(res, label: "res...")

      reduce_fun(enum, 
        rows, 
        column, 
        curr_column + 1, 
        res ++ [result]
      )
    end
  end
  
  def padding_fun(str) do
    length = String.length(str)
    is_pair = rem(length, 2) != 0
    if is_pair, do: str, else: str <> "  "
  end

  def calculate_column(length, rows) do
    round(length / rows)
  end

  def normalize(str) do
    str
    |> String.downcase()
    |> String.replace(["!", ",", " "], "")
  end

  def filter(number, length) do
    column = (length / number)
    diff = (column - number)
    int_column = round(column)

    int_column == column and diff <= 1 and diff > 0
  end
end

