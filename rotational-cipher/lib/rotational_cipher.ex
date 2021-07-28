defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(" ", _shift), do: " "

  def rotate(<<char::utf8, rest::binary>>, shift) do
    rotate_reduce(process(char, shift), rest, shift)
  end

  def rotate_reduce(acc, "", _), do: acc

  def rotate_reduce(acc, <<char::utf8, rest::binary>>, shift) do
    rotate_reduce(acc <> process(char, shift), rest, shift)
  end

  def process(32, _), do: " "

  def process(char, shift) do
    case Integer.parse(<<char::utf8>>) do
      {_, ""} ->
        <<char::utf8>>

      _ ->
        if char in ?A..?Z or char in ?a..?z do
          sum = char + shift
          if is_uppercase(<<char::utf8>>) do
            compute(sum, ?A, ?Z)
          else
            compute(sum, ?a, ?z)
          end
        else
          <<char::utf8>>
        end
      end
  end

  def compute(n, startn, endn) do
    if n > endn do
      diff = n - endn
      <<startn + (diff - 1)>>
    else
      <<n>>
    end
  end

  def is_uppercase(l), do: l == String.upcase(l)
end
