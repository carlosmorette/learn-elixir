defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(1) do
    {position, phrase} = specific(1)
    "On the #{position} day of Christmas my true love gave to me: #{phrase}"
  end

  def verse(number) do
    {position, _} = specific(number)
    "On the #{position} day of Christmas my true love gave to me: #{range(number)}"
  end

  def range(number) do
    number..1
    |> Enum.map(&specific/1)
    |> Enum.reduce("", fn {positions, phrase}, acc ->
      case positions do
        "first" -> acc <> "and " <> phrase
        _ -> acc <> phrase <> ", "
      end
    end)
  end

  def specific(number) do
    case number do
      1 -> {"first", "a Partridge in a Pear Tree."}
      2 -> {"second", "two Turtle Doves"}
      3 -> {"third", "three French Hens"}
      4 -> {"fourth", "four Calling Birds"}
      5 -> {"fifth", "five Gold Rings"}
      6 -> {"sixth", "six Geese-a-Laying"}
      7 -> {"seventh", "seven Swans-a-Swimming"}
      8 -> {"eighth", "eight Maids-a-Milking"}
      9 -> {"ninth", "nine Ladies Dancing"}
      10 -> {"tenth", "ten Lords-a-Leaping"}
      11 -> {"eleventh", "eleven Pipers Piping"}
      12 -> {"twelfth", "twelve Drummers Drumming"}
    end
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.reduce("", fn n, acc ->
      case n do
        n when n == ending_verse -> acc <> verse(n)
        _ -> acc <> verse(n) <> "\n"
      end
    end)
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing, do: verses(1, 12)
end
