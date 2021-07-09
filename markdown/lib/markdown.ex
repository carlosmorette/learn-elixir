defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    String.split(markdown, "\n")
    |> Enum.map(&process/1)
    |> Enum.join()
    |> patch()
  end

  defp process(item) do
    item
    |> String.first()
    |> case do
      "#" ->
        item
        |> parse_header_md_level()
        |> enclose_with_header_tag()

      "*" ->
        parse_list_md_level(item)

      _ ->
        item
        |> String.split()
        |> enclose_with_paragraph_tag()
    end

    # if String.starts_with?(t, "#") || String.starts_with?(t, "*") do
    #   if String.starts_with?(t, "#") do
    #     enclose_with_header_tag(parse_header_md_level(t))
    #   else
    #     parse_list_md_level(t)
    #   end
    # else
    #   enclose_with_paragraph_tag(String.split(t))
    # end
  end

  defp parse_header_md_level(hwt) do
    [h | t] = String.split(hwt)

    a =
      h
      |> String.length()
      |> to_string()

    b = Enum.join(t, " ")

    {a, b}
  end

  defp parse_list_md_level(level) do
    t =
      level
      |> String.trim_leading("* ")
      |> String.split()

    "<li>" <> join_words_with_tags(t) <> "</li>"
  end

  defp enclose_with_header_tag({hl, htl}) do
    "<h" <> hl <> ">" <> htl <> "</h" <> hl <> ">"
  end

  defp enclose_with_paragraph_tag(t) do
    "<p>#{join_words_with_tags(t)}</p>"
  end

  defp join_words_with_tags(t) do
    t
    |> Enum.map(fn w -> replace_md_with_tag(w) end)
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(word) do
    word
    |> replace_prefix_md()
    |> replace_suffix_md()
  end

  defp replace_prefix_md(w) do
    cond do
      w =~ ~r/^#{"__"}{1}/ -> String.replace(w, ~r/^#{"__"}{1}/, "<strong>", global: false)
      w =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(w, ~r/_/, "<em>", global: false)
      true -> w
    end
  end

  defp replace_suffix_md(word) do
    cond do
      word =~ ~r/#{"__"}{1}$/ -> String.replace(word, ~r/#{"__"}{1}$/, "</strong>")
      word =~ ~r/[^#{"_"}{1}]/ -> String.replace(word, ~r/_/, "</em>")
      true -> word
    end
  end

  defp patch(l) do
    l
    |> String.replace("<li>", "<ul>" <> "<li>", global: false)
    |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end
