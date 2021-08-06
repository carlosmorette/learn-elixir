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
    |> Enum.reduce([%{}, 1, false], fn char, [acc, current_row, bool] -> 
      if current_row < rails do
        if bool and current_row != 1 do
          new = Map.merge(acc, %{current_row => <<char>>}, fn _k, v1, v2 -> v1 <> v2 end)
          [new, current_row - 1, true]
        else
          new = Map.merge(acc, %{current_row => <<char>>}, fn _k, v1, v2 -> v1 <> v2 end)
          [new, current_row + 1, false]
        end
      else
        new = Map.merge(acc, %{current_row => <<char>>}, fn _k, v1, v2 -> v1 <> v2 end)
        [new, current_row - 1, true]
      end
    end)
    |> Enum.at(0)
    |> Enum.reduce("", fn {_row, str}, acc -> acc <> str end)
  end

  # [{"asd"}, {"asd"}, {"sdffsd"}]

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t(), pos_integer) :: String.t()
  def decode(_str, _rails) do
  end
end
