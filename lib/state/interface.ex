defmodule CodeParserState.Interface do
  alias CodeParserState, as: State
  alias CodeParserState.Namespace, as: Namespace
  alias CodeParserState.Class, as: Class
  alias CodeParserState.InterfaceProperty, as: Property
  alias CodeParserState.InterfaceMethod, as: Method

  @type interface :: %CodeParserState.Interface{
    name: String.t,
    description: String.t,
    properties: [Property.property],
    methods: [Method.method],
    relations: [String.t]
  }
  @type state :: State.state
  @type namespace :: Namespace.namespace

  defstruct name: "",
    description: "TODO",
    properties: [],
    methods: [],
    relations: []

  @spec name(state) :: String.t
  def name(%State{} = state), do: from_state state, &Class.name/1

  @spec description(state) :: String.t
  def description(%State{} = state), do: from_state state, &Class.description/1

  @spec properties(state) :: [Property.property]
  def properties(%State{} = state), do: from_state state, &Class.properties/1

  @spec methods(state) :: [Method.method]
  def methods(%State{} = state), do: from_state state, &Class.methods/1

  @spec relations(state) :: [String.t]
  def relations(%State{} = state), do: from_state state, &Class.relations/1

  @spec set_name(state, String.t) :: state
  def set_name(%State{} = state, name), do: Namespace.update_interface(state, &Class.set_name(&1, name))

  @spec set_description(state, String.t) :: state
  def set_description(%State{} = state, description), do: Namespace.update_interface(state, &Class.set_description(&1, description))

  @spec add_property(state, Property.property) :: state
  def add_property(%State{} = state, property), do: Namespace.update_interface(state, &Class.add_property(&1, property))

  @spec update_property(state, fun) :: state
  def update_property(%State{} = state, update), do: Namespace.update_interface(state, &Class.update_property(&1, update))

  @spec add_method(state, Method.method) :: state
  def add_method(%State{} = state, method), do: Namespace.update_interface(state, &Class.add_method(&1, method))

  @spec update_method(state, fun) :: state
  def update_method(%State{} = state, update), do: Namespace.update_interface(state, &Class.update_method(&1, update))

  @spec add_relation(state, String.t) :: state
  def add_relation(%State{} = state, relation), do: Namespace.update_interface(state, &Class.add_relation(&1, relation))

  @spec from_state(state, fun) :: term
  defp from_state(state, delegate) do
    state
    |> Namespace.interfaces
    |> hd
    |> delegate.()
  end
end
