defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t(), pos_integer) :: String.t()
  def encode("", _), do: ""

  def encode(str, 1), do: str

  def encode(str, rails) do
    str
    |> to_charlist()
    |> Enum.reduce([%{}, 1, false], fn char, [acc, current_row, can_up] ->
      if current_row < rails do
        if can_up and current_row != 1 do
          [set_row(acc, current_row, char), current_row - 1, true]
        else
          [set_row(acc, current_row, char), current_row + 1, false]
        end
      else
        [set_row(acc, current_row, char), current_row - 1, true]
      end
    end)
    |> Enum.at(0)
    |> Enum.reduce("", fn {_row, str}, acc -> acc <> str end)
  end

  def set_row(acc, current_row, char) do
    Map.merge(acc, %{current_row => <<char>>}, &concat_str/3)
  end

  def concat_str(_, v1, v2), do: v1 <> v2

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t(), pos_integer) :: String.t()
  def decode("", _), do: ""

  def decode(str, 1), do: str

  def decode(str, rails) do
    if String.length(str) == rails - 1 do
      str
    else
    end
  end
end
