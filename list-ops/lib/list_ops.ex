defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec length(list) :: non_neg_integer
  def length(l), do: do_length(l, 0)

  def do_length([], acc), do: acc
  
  def do_length([_head | tail], acc), do: do_length(tail, acc + 1)

  @spec reverse(list) :: list
  def reverse(l), do: do_reverse(l, [])

  def do_reverse([], acc), do: acc

  def do_reverse([head | tail], acc), do: do_reverse(tail, [head | acc])
    
  @spec map(list, (any -> any)) :: list
  def map(l, f), do: do_map(l, f, [])

  def do_map([], _f, acc), do: acc

  def do_map([head | tail], f, acc), do: do_map(tail, f, acc ++ [f.(head)])

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: do_filter(l, f, [])

  def do_filter([], _f, acc), do: acc

  def do_filter([head | tail], f, acc) do
    if f.(head) do 
      do_filter(tail, f, acc ++ [head]) 
    else 
      do_filter(tail, f, acc)
    end
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl(l, acc, f), do: do_foldl(l, f, acc)

  def do_foldl([], _f, acc), do: acc

  def do_foldl([head | tail], f, acc), do: do_foldl(tail, f, f.(acc, head))

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f) do
  end

  @spec append(list, list) :: list
  def append(a, b), do: do_append(a, b)

  def do_append(acc, []), do: acc

  def do_append(a, [head | tail]), do: do_append(a ++ [head], tail)

  @spec concat([[any]]) :: [any]
  def concat([]), do: []

  def concat(ll), do: do_concat(ll, [])

  def do_concat([head | tail], acc), do: do_concat(tail, acc ++ [List.flatten(head)])
end
