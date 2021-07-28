defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  @lower ?a..?z

  @upper ?A..?Z

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(<<char::utf8, rest::binary>>, shift) do
    rotate_reduce(process(char, shift), rest, shift)
  end

  def rotate_reduce(acc, "", _), do: acc

  def rotate_reduce(acc, <<char::utf8, rest::binary>>, shift) do
    rotate_reduce(acc <> process(char, shift), rest, shift)
  end

  def process(char, shift) do
    <<char::utf8>>
    |> Integer.parse()
    |> case do
      {_, ""} ->
        <<char::utf8>>

      _ ->
        compute(char, shift)
    end
  end

  def compute(n, shift) when n in @lower do
    compute(n + shift, ?a, ?z)
  end

  def compute(n, shift) when n in @upper do
    compute(n + shift, ?A, ?Z)
  end

  def compute(n, _shift), do: <<n>>

  def compute(n, startn, endn) do
    if n > endn do
      <<startn + (n - endn - 1)>>
    else
      <<n>>
    end
  end

  def is_uppercase(l), do: l == String.upcase(l)
end
