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
    |> capture_row()
  end

  def capture_row(str) do
    {padding_str, length} = padding_str(str)

    1..10
    |> Enum.into([])
    |> Enum.find(&is_valid_row?(&1, length))
    |> case do
      nil ->
        if String.ends_with?(padding_str, "  ") do
          padding_str
          |> String.trim()
          |> Kernel.<>(" ")
          |> capture_row()
        else
          capture_row(padding_str <> "  ")
        end

      rows ->
        columns = calculate_column(length, rows)
        make_square(padding_str, rows, columns)
    end
  end

  def make_square(str, rows, columns) do
    str
    |> String.graphemes()
    |> Enum.chunk_every(columns)
    |> scroll_columns(rows, columns, 0, [])
    |> Enum.join(" ")
  end

  def scroll_columns(_enum, _rows, columns, columns, res), do: res

  def scroll_columns(enum, rows, columns, curr_column, res) do
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

    scroll_columns(
      enum,
      rows,
      columns,
      curr_column + 1,
      res ++ [result]
    )
  end

  def padding_str(str) do
    length = String.length(str)
    is_pair = rem(length, 2) == 0

    if is_pair do
      {str, length}
    else
      {str <> " ", length}
    end
  end

  def calculate_column(length, rows) do
    round(length / rows)
  end

  def normalize(str) do
    str
    |> String.downcase()
    |> String.replace(["!", ",", " ", "'", ".", "@", "%"], "")
  end

  def is_valid_row?(number, length) do
    column = length / number
    diff = column - number

    round(column) == column and diff <= 1 and diff >= 0
  end
end
