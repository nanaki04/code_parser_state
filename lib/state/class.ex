defmodule CodeParserState.Class do
  alias CodeParserState, as: State
  alias CodeParserState.Namespace, as: Namespace

  @type class :: %CodeParserState.Class{
    name: String.t,
    description: String.t,
    properties: [CodeParserState.Property.property],
    methods: [CodeParserState.Method.method],
    relations: [String.t]
  }
  @type state :: State.state
  @type namespace :: Namespace.namespace
  @type class_like :: class | CodeParserState.Enum.enum | CodeParserState.Interface.interface

  defstruct name: "",
    description: "TODO",
    properties: [],
    methods: [],
    relations: []

  @spec name(state) :: String.t
  def name(%State{} = state), do: from_state state, &name/1

  @spec name(class_like) :: String.t
  def name(%{name: name}), do: name

  @spec description(state) :: String.t
  def description(%State{} = state), do: from_state state, &description/1

  @spec description(class_like) :: String.t
  def description(%{description: description}), do: description

  @spec properties(state) :: [CodeParserState.Property.property]
  def properties(%State{} = state), do: from_state state, &properties/1

  @spec properties(class_like) :: [CodeParserState.Property.property]
  def properties(%{properties: properties}), do: properties

  @spec methods(state) :: [CodeParserState.Method.method]
  def methods(%State{} = state), do: from_state state, &methods/1

  @spec methods(class_like) :: [CodeParserState.Method.method]
  def methods(%{methods: methods}), do: methods

  @spec relations(state) :: [String.t]
  def relations(%State{} = state), do: from_state state, &relations/1

  @spec relations(class_like) :: [String.t]
  def relations(%{relations: relations}), do: relations

  @spec set_name(state, String.t) :: state
  def set_name(%State{} = state, name), do: Namespace.update_class(state, &set_name(&1, name))

  @spec set_name(class_like, String.t) :: class_like
  def set_name(class, name) do
    class
    |> Map.put(:name, name)
  end
 
  @spec set_description(state, String.t) :: state
  def set_description(%State{} = state, description), do: Namespace.update_class(state, &set_description(&1, description))

  @spec set_description(class_like, String.t) :: class_like
  def set_description(class, description) do
    class
    |> Map.put(:description, description)
  end

  @spec add_property(state, CodeParserState.Property.property) :: state
  def add_property(%State{} = state, property), do: Namespace.update_class(state, &add_property(&1, property))

  @spec add_property(class_like, CodeParserState.Property.property) :: class_like
  def add_property(class, property) do
    class
    |> Map.update!(:properties, &[property | &1])
  end

  @spec update_property(state, fun) :: state
  def update_property(%State{} = state, update), do: Namespace.update_class(state, &update_property(&1, update))

  @spec update_property(class_like, fun) :: class_like
  def update_property(class, update) do
    class
    |> Map.update!(:properties, fn
      [] -> []
      [head | tail] -> [update.(head) | tail]
    end)
  end

  @spec update_all_properties(state, fun) :: state
  def update_all_properties(%State{} = state, update) do
    state
    |> Namespace.update_all_classes(&update_all_properties(&1, update))
  end

  @spec update_all_properties(class_like, fun) :: class_like
  def update_all_properties(class, update) do
    class
    |> Map.update!(:properties, &Enum.map(&1, update))
  end

  @spec add_method(state, CodeParserState.Method.method) :: state
  def add_method(%State{} = state, method), do: Namespace.update_class(state, &add_method(&1, method))

  @spec add_method(class_like, CodeParserState.Method.method) :: class_like
  def add_method(class, method) do
    class
    |> Map.update!(:methods, &[method | &1])
  end

  @spec update_method(state, fun) :: state
  def update_method(%State{} = state, update), do: Namespace.update_class(state, &update_method(&1, update))

  @spec update_method(class_like, fun) :: class_like
  def update_method(class, update) do
    class
    |> Map.update!(:methods, fn
      [] -> []
      [head | tail] -> [update.(head) | tail]
    end)
  end

  @spec update_all_methods(state, fun) :: state
  def update_all_methods(%State{} = state, update) do
    state
    |> Namespace.update_all_classes(&update_all_methods(&1, update))
  end

  @spec update_all_methods(class_like, fun) :: class_like
  def update_all_methods(class, update) do
    class
    |> Map.update!(:methods, &Enum.map(&1, update))
  end

  @spec add_relation(state, String.t) :: state
  def add_relation(%State{} = state, relation), do: Namespace.update_class(state, &add_relation(&1, relation))

  @spec add_relation(class_like, String.t) :: class_like
  def add_relation(class, relation) do
    class
    |> Map.update!(:relations, &[relation | &1])
  end

  @spec from_state(state, fun) :: term
  defp from_state(state, delegate) do
    state
    |> Namespace.classes
    |> hd
    |> delegate.()
  end
end
