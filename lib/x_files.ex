defmodule XFiles do
  @moduledoc """
  Documentation for XFiles.
  """

  @api Mockery.of("XFiles.Api")

  @keywords [
    "aliens",
    "abducted"
  ]

  def case?(file) do
    String.contains?(file, @keywords)
  end

  def search(file) do
    terms =
      file
      |> String.split(" ")
      |> Enum.into(HashSet.new)
      |> Set.intersection(Enum.into(@keywords, HashSet.new))
      |> Set.to_list

    case @api.search(terms) do
      {:ok, results} -> results
      {:error, error} -> []
    end
  end
end
