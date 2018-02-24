defmodule CodeParserState.Parser do
  @type state :: CodeParserState.state
  @type file_path :: String.t

  @callback parse(file_path) :: state
end
