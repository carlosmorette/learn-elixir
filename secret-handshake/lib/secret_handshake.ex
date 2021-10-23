defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(1), do: ["wink"]

  def commands(code) do
    code
    # 11000
    |> Integer.to_string(2)
    |> String.split("", trim: true)
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(&interpret_bit/1)
    |> Enum.reject(fn
      nil -> true
      _ -> false
    end)
    |> then(&check(code, &1))
  end

  def check(code, actions) when code > 16, do: Enum.reverse(actions)

  def check(_, actions), do: actions

  def interpret_bit({"1", 0}), do: "wink"

  def interpret_bit({"1", 1}), do: "double blink"

  def interpret_bit({"1", 2}), do: "close your eyes"

  def interpret_bit({"1", 3}), do: "jump"

  def interpret_bit(_), do: nil
end
