defmodule CodeParserState.InterfaceMethod do
  alias CodeParserState.Method, as: Method
  alias CodeParserState.Interface, as: Interface

  @type state :: CodeParserState.state
  @type method :: Method.method

  @spec set_accessibility(state, String.t) :: state
  def set_accessibility(state, accessibility), do: Interface.update_method state, &Method.set_accessibility(&1, accessibility)

  @spec set_type(state, String.t) :: state
  def set_type(state, type), do: Interface.update_method state, &Method.set_type(&1, type)

  @spec set_name(state, String.t) :: state
  def set_name(state, name), do: Interface.update_method state, &Method.set_name(&1, name)

  @spec set_description(state, String.t) :: state
  def set_description(state, description), do: Interface.update_method state, &Method.set_description(&1, description)

  @spec add_parameter(state, CodeParserState.Property.property) :: state
  def add_parameter(state, parameter), do: Interface.update_method state, &Method.add_parameter(&1, parameter)

  @spec update_parameter(state, fun) :: state
  def update_parameter(state, update), do: Interface.update_method state, &Method.update_parameter(&1, update)
end
