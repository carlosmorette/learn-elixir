defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    do_flatten(list, [])
  end

  def do_flatten(item, acc_param) do
    Enum.reduce(item, acc_param, fn item, acc ->
      case item do
        nil -> acc
        x when is_list(x) -> do_flatten(item, acc)
        x -> acc ++ [x]
      end
    end)
  end
end
