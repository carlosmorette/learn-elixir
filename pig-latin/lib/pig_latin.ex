defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """

  @vowels ["a", "e", "i", "o", "u"]

  @exceptions ["x", "y"]

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(<<char::utf8, rest::binary>>) when <<char>> in @vowels do
    <<char>> <> rest <> "ay"
  end

  defguard is_exception?(char, pos) when <<char>> in @exceptions and <<pos>> not in @vowels

  def translate(<<char::utf8, pos::utf8, rest::binary>>) when is_exception?(char, pos) do
    <<char>> <> rest <> "ay"
  end

  def translate(<<char::utf8, rest::binary>>) do
    reduce_translate("", <<char>> <> rest)
  end

  def reduce_translate(acc, <<char::utf8, rest::binary>>) when <<char>> in @vowels do
    <<char>> <> rest <> acc <> "ay"
  end

  def reduce_translate(acc, <<char::utf8, rest::binary>>) do
    reduce_translate(acc <> <<char>>, rest)
  end
end
