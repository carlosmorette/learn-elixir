defmodule Bob do
  
  # Bob é um adolescente indiferente. Na conversa, suas respostas são muito limitadas.
  # Bob responde 'Claro'. se você perguntar a ele.
  # Ele responde 'Whoa, chill out!' se você gritar com ele.
  # Ele responde 'Calma, eu sei o que estou fazendo!' se você gritar uma pergunta para ele.
  # Ele diz 'Tudo bem. Seja desse jeito!' se você se dirigir a ele sem realmente dizer nada.
  # Ele responde 'tanto faz'. para qualquer outra coisa.

  def is_question?(input) do
    input 
    |> String.trim()
    |> String.last()
    |> case do
      "?" -> true
      _ -> false
    end
  end

  def is_scream?(input) do
    input == String.upcase(input) and (input =~ ~r/[a-zA-Z]/ or input =~ ~r/\p{Lu}{2,}/u)
  end

  def is_silence?(input) do
    is_question = input =~ ~r/\?/ 
    if is_question do
      false
    else
      input =~ ~r/\s{2}/ or input =~ ~r/^$/
    end
  end

  def hey(input) do
    cond do
      is_silence?(String.trim(input)) -> "Fine. Be that way!"
      is_question?(input) and is_scream?(input) -> "Calm down, I know what I'm doing!"
      is_question?(input) -> "Sure."
      is_scream?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end
end
