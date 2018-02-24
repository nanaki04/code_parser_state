defmodule CodeParserState do

  @type namespace :: CodeParserState.Namespace.namespace
  @type property :: CodeParserState.Property.property
  @type method :: CodeParserState.Method.method
  @type file :: CodeParserState.File.file
  @type state :: %CodeParserState{
    files: [file]
  }

  defstruct files: []

  @spec files(state) :: [CodeParserState.File.file]
  def files(%{files: files}), do: files

  @spec file(state) :: CodeParserState.File.file
  def file(%{files: []}), do: %CodeParserState.File{}
  def file(%{files: [file | _]}), do: file

  @spec add_file(state, file) :: state
  def add_file(state, file) do
    state
    |> Map.update!(:files, &[file | &1])
  end

  @spec update_file(state, fun) :: state
  def update_file(state, update) do
    state
    |> Map.update!(:files, fn
      [] -> []
      [head | tail] -> [update.(head) | tail]
    end)
  end
end
