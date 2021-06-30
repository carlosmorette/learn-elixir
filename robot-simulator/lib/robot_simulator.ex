defmodule RobotSimulator do
  defstruct position: {0, 0}, direction: :north

  @directions [:north, :east, :west, :south, nil]
  @invalid_direction {:error, "invalid direction"}
  @invalid_position {:error, "invalid position"}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  def create() do
    %__MODULE__{}
  end

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ nil, position \\ nil) do
    cond do
      not(direction in @directions) -> @invalid_direction
      not(is_valid_position?(position)) -> @invalid_position
      true -> 
        %__MODULE__{
          direction: direction,
          position: position
        }
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.codepoints()
    |> Enum.reduce(robot, fn i, r ->
      exec_instruction(r, i)
    end)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end

  def exec_instruction(robot, "A") do
    [x, y] = Tuple.to_list(robot.position)

    robot
    |> struct(%{position: {x, y + 1}})
  end

  def exec_instruction(robot, "L") do
    [x, y] = Tuple.to_list(robot.position)

    set_direction(robot, "L")
    |> set_position({y, x})
  end

  def exec_instruction(robot, "R") do
    [x, y] = Tuple.to_list(robot.position)
    set_direction(robot, "R")
    |> set_position({y, x})
  end

  def set_direction(robot, direction) do
    robot
    |> struct(%{direction: rotate(robot.direction, direction)})
  end

  # Verificar o X e Y do robo
  # Exemplo:
  # Se Y(Direção) = West (Oeste) = (-x, y)
  def set_position(robot, position) do
    robot
    |> struct(%{position: position})
  end

  def rotate(:north, direction) do
    case direction do
      "L" -> :west
      "R" -> :east
    end
  end
  
  def rotate(:east, direction) do
    case direction do
      "L" -> :north
      "R" -> :south
    end
  end

  def rotate(:south, direction) do
    case direction do
      "L" -> :east
      "R" -> :west
    end
  end

  def rotate(:west, direction) do
    case direction do
      "L" -> :south 
      "R" -> :north
    end
  end

  def is_valid_position?(position) do  
    cond do
      is_tuple(position) -> 
        all_numbers =
          position
          |> Tuple.to_list()
          |> Enum.map(&is_integer/1)
          |> Enum.all?()
  
      length = 
        position
        |> Tuple.to_list()
        |> Enum.count()
  
      length == 2 and all_numbers
  
     true -> 
      false
    end
  end
end
