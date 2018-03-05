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

  def lookup(file) do
    terms =
      file
      |> String.split(" ")
      |> Enum.into(MapSet.new)
      |> MapSet.intersection(Enum.into(@keywords, MapSet.new))
      |> MapSet.to_list

    case @api.search(terms) do
      {:ok, results} -> results
      {:error, _error} -> []
    end
  end
end
