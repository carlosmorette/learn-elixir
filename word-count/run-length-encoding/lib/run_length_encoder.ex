defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  def encode(""), do: ""

  @spec encode(String.t()) :: String.t()
  def encode(<<char::utf8, rest::binary>>) do
    encode_reduce(1, char, rest) 
  end

  def encode_count(1), do: ""

  def encode_count(n), do: Integer.to_string(n)

  def encode_reduce(count, last_char, "") do 
    encode_count(count) <> <<last_char::utf8>>
  end

  def encode_reduce(count, char, <<char::utf8, rest::binary>>) do
    encode_reduce(count + 1, char, rest) 
  end

  def encode_reduce(count, last_char, <<char::utf8, rest::binary>>) do
    encode_count(count) <> <<last_char::utf8>> <> encode_reduce(1, char, rest)
  end

  @spec decode(String.t()) :: String.t()
  def decode(""), do: ""

  def decode(<<char::utf8, rest::binary>>) do
    if Regex.match?(~r/[a-zA-Z\s]/, <<char::utf8>>) do
      <<char::utf8>> <> decode(rest)
    else
      read_number(<<char::utf8>>, rest)
    end
  end

  def read_number(acc, <<char::utf8, rest::binary>>) do
    if Regex.match?(~r/[a-zA-Z\s]/, <<char::utf8>>) do
      acc
      |> String.to_integer()
      |> decode_count(<<char::utf8>>, rest)
    else
      read_number(acc <> <<char::utf8>>, rest)
    end
  end

  def decode_count(number, char, rest) do
    String.duplicate(char, number) <> decode(rest)
  end
end
