defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    """
    #{start(number)} of beer on the wall,#{parse(number, :space_start)} #{bottles(number)} of beer.
    #{phrase(number)}, #{if number == 0, do: "99 ", else: parse(number - 1, :space_end)}#{bottles(number - 1)} of beer on the wall.
    """
  end

  def start(number) do
    case number do
      0 -> "No more bottles"
      1 -> "1 bottle"
      _ -> "#{number} bottles"
    end
  end

  def phrase(0), do: "Go to the store and buy some more"

  def phrase(n), do: "Take #{pronoun(n)} down and pass it around"


  def pronoun(1), do: "it"

  def pronoun(_), do: "one"


  def parse(0, _), do: nil

  def parse(n, :space_start), do: " #{n}"

  def parse(0, _), do: nil

  def parse(n, :space_end), do: "#{n} "


  def bottles(1), do: "bottle"

  def bottles(0), do: "no more bottles"
  
  def bottles(_), do: "bottles"

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    range
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end
end
