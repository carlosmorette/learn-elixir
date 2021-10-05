defmodule BinTree do
  defstruct left: nil, right: nil, value: nil

  @type t :: %{left: nil, right: nil, value: nil}
end

defmodule Zipper do
  alias BinTree, as: BT

  defstruct [:focus, :path]
        
  @type t :: any()
          
  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree), do: %Zipper{focus: bin_tree, path: []}

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(%Zipper{focus: focus, path: []}), do: focus
  def to_tree(zipper), do: zipper |> up() |> to_tree()
  
  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(%Zipper{focus: %BT{value: value}}), do: value

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(%Zipper{focus: %BT{left: nil}}), do: nil

  def left(%Zipper{focus: focus = %BT{left: left}, path: path}) do
    %Zipper{focus: left, path: [{:left, focus} | path]} 
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(%Zipper{focus: %BT{right: nil}}), do: nil

  def right(%Zipper{focus: focus = %BT{right: right}, path: path}) do
    %Zipper{focus: right, path: [{:right, focus} | path]}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%Zipper{path: []}), do: nil
  def up(%Zipper{focus: focus, path: [{:left, node} | path]}),
    do: %Zipper{focus: %{node | left: focus}, path: path}

  def up(%Zipper{focus: focus, path: [{:right, node} | path]}),
    do: %Zipper{focus: %{node | right: focus}, path: path}

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper = %Zipper{focus: focus}, value),
    do: %{zipper | focus: %{focus | value: value}}

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper = %Zipper{focus: focus}, left), do: %{zipper | focus: %{focus | left: left}}

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper = %Zipper{focus: focus}, right),
    do: %{zipper | focus: %{focus | right: right}}
end

