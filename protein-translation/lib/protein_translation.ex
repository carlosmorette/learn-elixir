defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """

  @spec of_rna(String.t()) :: {atom, list(String.t())}

  @max_list_of_proteins 3

  def of_rna(rna) do
    list_proteins =
      rna
      |> String.codepoints()
      |> Enum.chunk_every(3)
      |> Enum.map(&Enum.join/1)
      |> Enum.reduce_while([], &reduce_fun/2)

    case list_proteins do
      ["invalid RNA"] -> {:error, "invalid RNA"}
      _ -> {:ok, list_proteins}
    end
  end

  def reduce_fun(codon, acc) do
    if Enum.count(acc) == @max_list_of_proteins do
      {:cont, acc}
    else
      codon
      |> of_codon()
      |> (&elem(&1, 1)).()
      |> case do
        "STOP" -> {:halt, acc}
        "invalid RNA" -> {:halt, ["invalid RNA"]}
        result -> {:cont, acc ++ [result]}
      end
    end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon("INVALID"), do: {:error, "invalid codon"}

  def of_codon(codon), do: {:ok, aux_of_codon(codon)}

  def aux_of_codon(codon) when codon in ["UGU", "UGC"], do: "Cysteine"

  def aux_of_codon(codon) when codon in ["UUA", "UUG"], do: "Leucine"

  def aux_of_codon(codon) when codon in ["AUG"], do: "Methionine"

  def aux_of_codon(codon) when codon in ["UUU", "UUC"], do: "Phenylalanine"

  def aux_of_codon(codon) when codon in ["UCU", "UCC", "UCA", "UCG"], do: "Serine"

  def aux_of_codon(codon) when codon in ["UGG"], do: "Tryptophan"

  def aux_of_codon(codon) when codon in ["UAU", "UAC"], do: "Tyrosine"

  def aux_of_codon(codon) when codon in ["UAA", "UAG", "UGA"], do: "STOP"

  def aux_of_codon(_codon), do: "invalid RNA"
end
