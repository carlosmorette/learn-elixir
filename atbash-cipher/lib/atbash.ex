defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """

  @numbers 48..57

  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> normalize()
    |> to_charlist()
    |> do_encode("", 0)
  end

  def do_encode([], acc, _turns), do: acc

  def do_encode([head | tail], acc, 5) when head in @numbers do
    do_encode(tail, acc <> " " <> <<head>>, 0)
  end

  def do_encode([head | tail], acc, turns) when head in @numbers do
    do_encode(tail, acc <> <<head>>, turns + 1)
  end

  def do_encode([head | tail], acc, 5) do
    result = <<122 + (97 - head) >>
    do_encode(tail, acc <> " " <> result, 1)
  end

  def do_encode([head | tail], acc, turns) do
    result = <<122 + (97 - head) >>
    do_encode(tail, acc <> result, turns + 1)
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> normalize()
    |> to_charlist()
    |> do_decode("")
  end

  def do_decode([], acc), do: acc

  def do_decode([head | tail], acc) when head in @numbers do
    do_decode(tail, acc <> <<head>>)
  end

  def do_decode([head | tail], acc) do
    result = <<97 + (122 - head) >>
    do_decode(tail, acc <> result)
  end

  def normalize(str) do
    str
    |> String.replace([" ", ",", "."], "")
    |> String.downcase()
  end
end
