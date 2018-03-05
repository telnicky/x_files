defmodule XFilesTest do
  use ExUnit.Case

  import Mockery
  import Mockery.Assertions

  describe "XFiles.case?" do
    test "it returns true when case deals with aliens" do
      file = "Duane Berry claims he was abducted by aliens"

      result = XFiles.case?(file)

      assert result
    end

    test "it returns false when case is not an x file" do
      file = "Bank Robbery"

      result = XFiles.case?(file)

      refute result
    end
  end

  describe "XFiles.lookup" do
    test "it returns a list with the case files in it, when given an existing file" do
      file = "Samantha Ann Mulder was abducted by aliens from her home"
      mock XFiles.Api, :search, {:ok, [file]}

      files = XFiles.lookup(file)

      assert Enum.find(files, fn (f) -> f == file end)
    end


    test "it calls the search api with the parsed terms" do
      file = "Samantha Ann Mulder was abducted by aliens from her home"
      mock XFiles.Api, :search, {:ok, [file]}

      XFiles.lookup(file)

      assert_called XFiles.Api, :search, [["abducted", "aliens"]]
    end

    test "it returns an empty list, when the file is not an x file" do
      file = "Stolen car"
      mock XFiles.Api, :search, {:ok, []}

      files = XFiles.lookup(file)

      assert Enum.empty?(files)
    end

    test "it returns an empty list, when the api returns an error" do
      file = "Stolen car"
      mock XFiles.Api, :search, {:error, []}

      files = XFiles.lookup(file)

      assert Enum.empty?(files)
    end
  end
end
