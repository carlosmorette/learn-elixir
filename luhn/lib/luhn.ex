defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """

  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    polished = String.replace(number, " ", "")

    if Regex.match?(~r/\D/, polished) do
      false
    else
      polished
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> process()
    end
  end

  def process(number) do
    case Enum.count(number) do
      l when l <= 1 ->
        false

      2 ->
        total = Enum.reduce(number, 0, &(&2 + calculate(&1, 2)))

        if rem(total, 10) == 0, do: true, else: false

      _ ->
        [_mult, total] = Enum.reduce(number, [1, 0], &reduce_fun/2)
        if rem(total, 10) == 0, do: true, else: false
    end
  end

  defp reduce_fun(number, acc) do
    [mult, total] = acc

    if mult == 1 do
      [2, total + calculate(number, 1)]
    else
      [1, total + calculate(number, 2)]
    end
  end

  defp calculate(number, 1), do: number

  defp calculate(number, 2) do
    result = number * 2

    if result >= 10 do
      result
      |> Integer.digits()
      |> Enum.sum()
    else
      result
    end
  end
end
