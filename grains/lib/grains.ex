defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """

  def square(number) when number >= 65 or number <= 0 do
    {:error, "The requested square must be between 1 and 64 (inclusive)"}
  end

  @spec square(pos_integer) :: pos_integer
  def square(number), do: {:ok, Integer.pow(2, number - 1)}

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    {:ok, Integer.pow(2, 64) - 1}
  end
end
