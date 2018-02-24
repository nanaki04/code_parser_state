defmodule CodeParserState.Namespace do
  alias CodeParserState, as: State
  alias CodeParserState.File, as: File

  @type namespace :: %CodeParserState.Namespace{
    name: String.t,
    classes: [CodeParserState.Class.class]
  }
  @type state :: State.state
  @type file :: File.file

  defstruct name: "",
    classes: [],
    interfaces: [],
    enums: []

  @spec name(namespace) :: String.t
  def name(%{name: name}), do: name

  @spec classes(state) :: [CodeParserState.Class.class]
  def classes(%State{} = state), do: from_state state, &classes/1

  @spec classes(namespace) :: [CodeParserState.Class.class]
  def classes(%{classes: classes}), do: classes

  @spec interfaces(state) :: [CodeParserState.Interface.interface]
  def interfaces(%State{} = state), do: from_state state, &interfaces/1

  @spec interfaces(namespace) :: [CodeParserState.Interface.interface]
  def interfaces(%{interfaces: interfaces}), do: interfaces

  @spec enums(state) :: [CodeParserState.Enum.enum]
  def enums(%State{} = state), do: from_state state, &enums/1

  @spec enums(namespace) :: [CodeParserState.Enum.enum]
  def enums(%{enums: enums}), do: enums

  @spec set_name(state, String.t) :: state
  def set_name(%State{} = state, name) do
    state
    |> File.update_namespace(&set_name(&1, name))
  end

  @spec set_name(namespace, String.t) :: namespace
  def set_name(namespace, name) do
    namespace
    |> Map.put(:name, name)
  end

  @spec add_class(state, CodeParserState.Class.class) :: state
  def add_class(%State{} = state, class) do
    state
    |> File.update_namespace(&add_class(&1, class))
  end

  @spec add_class(namespace, CodeParserState.Class.class) :: namespace
  def add_class(namespace, class) do
    namespace
    |> Map.update!(:classes, &[class | &1])
  end

  @spec update_class(state, fun) :: state
  def update_class(%State{} = state, update) do
    state
    |> File.update_namespace(&update_class(&1, update))
  end

  @spec update_class(namespace, fun) :: namespace
  def update_class(namespace, update) do
    namespace
    |> Map.update!(:classes, fn
      [] -> []
      [head | tail] -> [update.(head) | tail]
    end)
  end

  @spec add_interface(state, CodeParserState.Interface.interface) :: state
  def add_interface(%State{} = state, interface) do
    state
    |> File.update_namespace(&add_interface(&1, interface))
  end

  @spec add_interface(namespace, CodeParserState.Interface.interface) :: namespace
  def add_interface(namespace, interface) do
    namespace
    |> Map.update!(:interfaces, &[interface | &1])
  end

  @spec update_interface(state, fun) :: state
  def update_interface(%State{} = state, update) do
    state
    |> File.update_namespace(&update_interface(&1, update))
  end

  @spec update_interface(namespace, fun) :: namespace
  def update_interface(namespace, update) do
    namespace
    |> Map.update!(:interfaces, fn
      [] -> []
      [head | tail] -> [update.(head) | tail]
    end)
  end

  @spec add_enum(state, CodeParserState.Enum.enum) :: state
  def add_enum(%State{} = state, enum) do
    state
    |> File.update_namespace(&add_enum(&1, enum))
  end

  @spec add_enum(namespace, CodeParserState.Enum.enum) :: namespace
  def add_enum(namespace, enum) do
    namespace
    |> Map.update!(:enums, &[enum | &1])
  end

  @spec update_enum(state, fun) :: state
  def update_enum(%State{} = state, update) do
    state
    |> File.update_namespace(&update_enum(&1, update))
  end

  @spec update_enum(namespace, fun) :: namespace
  def update_enum(namespace, update) do
    namespace
    |> Map.update!(:enums, fn
      [] -> []
      [head | tail] -> [update.(head) | tail]
    end)
  end

  @spec from_state(state, fun) :: term
  def from_state(state, delegate) do
    state
    |> CodeParserState.File.namespace
    |> delegate.()
  end

end
