defmodule Lasagna do
  def expected_minutes_in_oven, do: 40

  def remaining_minutes_in_oven(x), do: expected_minutes_in_oven() - x

  def preparation_time_in_minutes(x), do: x * 2

  def total_time_in_minutes(x, y) do
    preparation_time_in_minutes(x) + y
  end

  def alarm, do: "Ding!"
end
