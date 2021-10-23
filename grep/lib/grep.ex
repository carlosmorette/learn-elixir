defmodule Grep do
  # DICA: dar o resultado completo, depois avaliar os parametros e filtrar o resultado

  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    Enum.reduce(files, "", fn file, acc -> 
      result = 
        file
        |> read_file!()
        |> search(pattern, flags, "", 1)

     # if "-l" in flags and result != "" do
     #   if acc == "" do
     #     "#{file}\n"
     #   else
     #     "#{acc}\n#{file}"
     #   end
     # else
     #   if result != "" do
     #     acc <> "#{result}\n"
     #   else
     #     acc
     #   end
     # end
    end)
  end

  def read_file!(file) do
    file
    |> File.read!()
    |> String.split("\n")
  end

  # refactor
  def insensitive(line, flags, pattern) do
    if "-i" in flags do
      line
      |> String.downcase()
      |> String.contains?(String.downcase(pattern)) 
    else
      String.contains?(line, pattern)
    end
  end

  def match_all_line() do

  end

  def lines(), do: :ok

  def no_match(), do: :ok

  def search([head | tail], pattern, flags, acc, turns) do
    head
    |> insensitive(flags, pattern)
  end

 # def search([], _patterns, _flags, acc, _turns), do: acc

 # def search([head | tail], pattern, flags, acc , turns) do
 #   match = 
 #     if "-i" in flags do
 #       head
 #       |> String.downcase()
 #       |> String.contains?(String.downcase(pattern))
 #     else
 #       String.contains?(head, pattern)
 #     end
 #   
 #   safe_match = 
 #     if "-x" in flags do
 #       String.downcase(pattern) == String.downcase(head)
 #     else
 #       match
 #     end

 #   if safe_match do
 #     safe_acc = 
 #       if acc == "" do
 #         if "-n" in flags, do: "#{turns}:#{head}", else: "#{head}"
 #       else
 #         if "-n" in flags, do: "#{acc}\n#{turns}:#{head}", else: "#{acc}\n#{head}"
 #       end
 #     search(tail, pattern, flags, safe_acc, turns + 1)
 #   else
 #     if "-v" in flags do
 #       # refactor
 #       safe_acc = 
 #         if acc == "" do
 #           "#{head}"
 #         else
 #           "#{acc}\n#{head}"
 #         end

 #       search(tail, pattern, flags, safe_acc, turns + 1)
 #     else
 #       search(tail, pattern, flags, acc, turns + 1)
 #     end
 #   end
 # end
end
