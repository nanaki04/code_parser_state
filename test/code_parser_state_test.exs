defmodule CodeParserStateTest do
  use ExUnit.Case
  doctest CodeParserState

  test "tmp" do
    CodeParserState.Example.generate()
    |> CodeParserState.Namespace.add_class(%CodeParserState.Class{})
  end
end
