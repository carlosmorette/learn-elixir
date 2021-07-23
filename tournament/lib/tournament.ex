defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do 
    teams = 
      input
      |> Enum.map(&String.split(&1, ";"))
      |> Enum.reduce([], fn match, acc -> 
        [team1, team2, _] = match
        [initial_team_line(team1), initial_team_line(team2) | acc]
      end)
      |> Enum.reduce([], &reduce_fun/2)
  

    input
    |> Enum.map(&String.split(&1, ";"))
    |> Enum.reduce([], fn match, acc -> 
      [team1, team2, result] = match

      winner = find_team_by_name(team1, teams)
      loser = find_team_by_name(team2, teams)

      {new_winner, new_loser} = set_team_match(winner, loser, result)
      [new_winner, new_loser | acc]
    end)
  end

  def set_team_match(team1, team2, result) do
    {tm1, tm2} = 
      case result do
        "win" -> {:won, :loss}
        "loss" -> {:loss, :won}
        "draw" -> {:drawn, :drawn}
      end

    {increment_property_team(team1, tm1), increment_property_team(team2, tm2)}
  end

  def increment_property_team(team, :points, :won) do
    Map.merge(team, %{points: 3}, fn _kv, v1, v2 -> v1 + v2 end)
  end

  def increment_property_team(team, :points, :draw) do
    Map.merge(team, %{points: 1}, fn _kv, v1, v2 -> v1 + v2 end)
  end

  def increment_property_team(team, :played) do
    Map.merge(team, %{matches_played: 1}, fn _kv, v1, v2 -> v1 + v2 end)
  end

  def increment_property_team(team, :won) do
    team
    |> increment_property_team(:played)
    |> increment_property_team(:points, :won)
    |> Map.merge(%{matches_won: 1}, fn _kv, v1, v2 -> v1 + v2 end)
  end

  def increment_property_team(team, :loss) do
    team
    |> increment_property_team(:played)
    |> Map.merge(%{matches_loss: 1}, fn _kv, v1, v2 -> v1 + v2 end)
  end

  def increment_property_team(team, :drawn) do
    team
    |> increment_property_team(:played)
    |> increment_property_team(:points, :draw)
    |> Map.merge(%{matches_drawn: 1}, fn _kv, v1, v2 -> v1 + v2 end)
  end

  def reduce_fun(team, acc), do: unless team in acc, do: [team | acc], else: acc

  def initial_team_line(team_name) do
    %{
      name: team_name,
      matches_played: 0,
      matches_won: 0,
      matches_drawn: 0,
      matches_lost: 0,
      points: 0
    }
  end

  def find_team_by_name(team_name, teams) do
    Enum.find(teams, fn team -> team.name == team_name end)
  end

  # 1. estão ordenados por pontuação
  # 2. a derrota ou vitória é atribuida ao team1
end
