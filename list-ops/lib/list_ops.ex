defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @doc """
  Suponhamos que seu input seja [1, 2, 3, 4]
  
  O que vai acontecer aqui é:
  Ele vai pegar a cauda da lista que é [2, 3, 4] e chamar a função novamente
  O primeiro input seria +1. Isso vai acontecer até chegar o último elemento da lista.
  Quando isso acontecer será chamada a função count/1 que da match com uma lista vazia.
  Sendo isso será retornad: valor_acumulado + 0
  Totalizando 4
  """
  @spec count(list) :: non_neg_integer
  def count([]), do: 0

  def count([_head | tail]), do: 1 + count(tail)
  
  @doc """
  Input: [1, 2, 3, 4]
  
  Aqui nós sempre pegamos a cabeça da lista e colocamos ela na frente, 
  até a cabeça da lista ser o último item.

  Ordem:
  [1]
  [2, 1]
  [3, 2, 1]
  [4, 3, 2, 1]
  """
  @spec reverse(list) :: list
  def reverse(list), do: reverse_reduce(list, [])

  def reverse_reduce([head | tail], acc), do: reverse_reduce(tail, [head | acc])

  def reverse_reduce([], acc), do: acc

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce(l, acc, f) do
  end

  @spec append(list, list) :: list
  def append(a, b) do
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
  end
end
