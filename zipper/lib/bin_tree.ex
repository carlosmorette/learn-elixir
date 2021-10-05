#defimpl Inspect, for: BinTree do
  #import Inspect.Algebra

  # A custom inspect instance purely for the tests, this makes error messages
  # much more readable.
  #
  # %BinTree{value: 3, left: %BinTree{value: 5, right: %BinTree{value: 6}}} becomes (3:(5::(6::)):)
 # def inspect(%BinTree{value: value, left: left, right: right}, opts) do
 #   concat([
 #     "(",
 #     to_doc(value, opts),
 #     ":",
 #     if(left, do: to_doc(left, opts), else: ""),
 #     ":",
 #     if(right, do: to_doc(right, opts), else: ""),
 #     ")"
 #   ])
 # end
# end
