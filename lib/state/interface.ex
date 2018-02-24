defmodule CodeParserState.Interface do
  alias CodeParserState, as: State
  alias CodeParserState.Namespace, as: Namespace
  alias CodeParserState.Class, as: Class
  alias CodeParserState.InterfaceProperty, as: Property
  alias CodeParserState.InterfaceMethod, as: Method

  @type interface :: %CodeParserState.Interface{
    name: String.t,
    properties: [Property.property],
    methods: [Method.method]
  }
  @type state :: State.state
  @type namespace :: Namespace.namespace

  defstruct name: "",
    properties: [],
    methods: []

  @spec name(state) :: String.t
  def name(%State{} = state), do: from_state state, &Class.name/1

  @spec properties(state) :: [Property.property]
  def properties(%State{} = state), do: from_state state, &Class.properties/1

  @spec methods(state) :: [Method.method]
  def methods(%State{} = state), do: from_state state, &Class.methods/1

  @spec set_name(state, String.t) :: state
  def set_name(%State{} = state, name), do: Namespace.update_interface(state, &Class.set_name(&1, name))

  @spec add_property(state, Property.property) :: state
  def add_property(%State{} = state, property), do: Namespace.update_interface(state, &Class.add_property(&1, property))

  @spec update_property(state, fun) :: state
  def update_property(%State{} = state, update), do: Namespace.update_interface(state, &Class.update_property(&1, update))

  @spec add_method(state, Method.method) :: state
  def add_method(%State{} = state, method), do: Namespace.update_interface(state, &Class.add_method(&1, method))

  @spec update_method(state, fun) :: state
  def update_method(%State{} = state, update), do: Namespace.update_interface(state, &Class.update_method(&1, update))

  @spec from_state(state, fun) :: term
  defp from_state(state, delegate) do
    state
    |> Namespace.interfaces
    |> hd
    |> delegate.()
  end
end
