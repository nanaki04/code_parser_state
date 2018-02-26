defmodule CodeParserState.Enum do
  alias CodeParserState, as: State
  alias CodeParserState.Namespace, as: Namespace
  alias CodeParserState.Class, as: Class
  alias CodeParserState.EnumProperty, as: Property

  @type enum :: %CodeParserState.Enum{
    name: String.t,
    description: String.t,
    properties: [Property.property],
  }
  @type state :: State.state
  @type namespace :: Namespace.namespace

  defstruct name: "",
    description: "TODO",
    properties: []

  @spec name(state) :: String.t
  def name(%State{} = state), do: from_state state, &Class.name/1

  @spec description(state) :: String.t
  def description(%State{} = state), do: from_state state, &Class.description/1

  @spec properties(state) :: [Property.property]
  def properties(%State{} = state), do: from_state state, &Class.properties/1

  @spec set_name(state, String.t) :: state
  def set_name(%State{} = state, name), do: Namespace.update_enum(state, &Class.set_name(&1, name))

  @spec set_description(state, String.t) :: state
  def set_description(%State{} = state, description), do: Namespace.update_enum(state, &Class.set_description(&1, description))

  @spec add_property(state, Property.property) :: state
  def add_property(%State{} = state, property), do: Namespace.update_enum(state, &Class.add_property(&1, property))

  @spec update_property(state, fun) :: state
  def update_property(%State{} = state, update), do: Namespace.update_enum(state, &Class.update_property(&1, update))

  @spec from_state(state, fun) :: term
  defp from_state(state, delegate) do
    state
    |> Namespace.enums
    |> hd
    |> delegate.()
  end
end
