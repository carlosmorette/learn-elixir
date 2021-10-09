defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(""), do: true

  def check_brackets(str) do
    str
    |> to_charlist()
    |> check([])
  end

  def check([], []), do: true

  def check([?( | rest], state), do: check(rest, [?( | state])

  def check([?{ | rest], state), do: check(rest, [?{ | state])

  def check([?[ | rest], state), do: check(rest, [?[ | state])

  def check([?) | rest], [?( | tail]), do: check(rest, tail)

  def check([?} | rest], [?{ | tail]), do: check(rest, tail)

  def check([?] | rest], [?[ | tail]), do: check(rest, tail)

  def check([x | rest], state) when x not in [?), ?}, ?]], do: check(rest, state)

  def check(_, _), do: false
end
