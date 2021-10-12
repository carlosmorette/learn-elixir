defmodule PhoneNumber do

  @doc """
  Remove formatting from a phone number if the given number is valid. Return an error otherwise.
  """
  @spec clean(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def clean(raw) do
    raw
    |> normalize()
    |> number()
  end
  
  def normalize(phone_number) do
    String.replace(phone_number, ["(", ")", " ", "-", ".", "+"], "")
  end

  def number(:invalid_area_code, "0"), do: {:error, "area code cannot start with zero"}

  def number(:invalid_area_code, "1"), do: {:error, "area code cannot start with one"}
  
  def number(:invalid_exchange, "0"), do: {:error, "exchange code cannot start with zero"}

  def number(:invalid_exchange, "1"), do: {:error, "exchange code cannot start with one"}

  def number(:invalid_length), do: {:error, "incorrect number of digits"}

  def number(:only_digits), do: {:error, "must contain digits only"}

  def number(:must_start_one), do: {:error, "11 digits must start with 1"}

  def number(number) do
    if Regex.match?(~r/[a-zA-Z|@:!]/, number) do
      number(:only_digits)
    else
      number
      |> then(fn number ->
          number
          |> String.length()
          |> do_number(number)
      end)
    end
  end

  def do_number(10, phone_number) do
    area_code = String.at(phone_number, 0)
    exchange = String.at(phone_number, 3)

    case area_code do
      "0" -> number(:invalid_area_code, "0")
      "1" -> number(:invalid_area_code, "1")
      _ ->
        case exchange do
          "0" -> number(:invalid_exchange, "0")
          "1" -> number(:invalid_exchange, "1")
          _ -> {:ok, phone_number}
        end
    end
  end

  def do_number(11, <<first::utf8, _rest::binary>>) when first != ?1 do
    number(:must_start_one)
  end

  def do_number(11, <<_t::utf8, rest::binary>>) do
    do_number(10, rest)
  end

  def do_number(_, _number), do: number(:invalid_length)
end
