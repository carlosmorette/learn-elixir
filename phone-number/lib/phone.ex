defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(:invalid), do: "0000000000"

  def number(number) do
    if Regex.match?(~r/[a-zA-Z]/, number) do
      number(:invalid)
    else
      number
      |> normalize()
      |> then(fn number ->
        number
        |> String.length()
        |> do_number(number)
      end)
    end
  end

  def do_number(10, phone_number) do
    first = String.at(phone_number, 0)
    exchange = String.at(phone_number, 3)

    if first in ["1", "0"] or exchange in ["1", "0"] do
      number(:invalid)
    else
      phone_number
    end
  end

  def do_number(11, <<first::utf8, _rest::binary>>) when first != ?1 do
    number(:invalid)
  end

  def do_number(11, <<_t::utf8, rest::binary>>) do
    rest
  end

  def do_number(_, _number), do: number(:invalid)

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    raw
    |> number()
    |> then(fn
      "0000000000" -> "000"
      pn -> String.slice(pn, 0, 3)
    end)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    raw
    |> number()
    |> then(fn
      "0000000000" -> "(000) 000-0000"
      pn -> do_pretty(pn)
    end)
  end

  def do_pretty(raw) do
    first = String.slice(raw, 0, 3)
    second = String.slice(raw, 3, 3)
    three = String.slice(raw, 6, 10)

    "(#{first}) #{second}-#{three}"
  end

  def normalize(phone_number) do
    String.replace(phone_number, ["(", ")", " ", "-", ".", "+"], "")
  end
end
