defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    [3, 5, 7]
    |> Enum.reduce("", fn n, acc -> 
      if rem(number, n) == 0, do: calc(n, acc), else: acc
    end)
    |> finish(number)
  end

  def finish("", number), do: Integer.to_string(number)

  def finish(result, _num), do: result

  def calc(3, _str), do: "Pling"

  def calc(5, str), do: str <> "Plang"

  def calc(7, str), do: str <> "Plong"
end
