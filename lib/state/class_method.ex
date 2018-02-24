defmodule CodeParserState.ClassMethod do
  alias CodeParserState.Method, as: Method
  alias CodeParserState.Class, as: Class

  @type state :: CodeParserState.state

  @spec set_accessibility(state, String.t) :: state
  def set_accessibility(state, accessibility), do: Class.update_method state, &Method.set_accessibility(&1, accessibility)

  @spec set_type(state, String.t) :: state
  def set_type(state, type), do: Class.update_method state, &Method.set_type(&1, type)

  @spec set_name(state, String.t) :: state
  def set_name(state, name), do: Class.update_method state, &Method.set_name(&1, name)

  @spec set_description(state, String.t) :: state
  def set_description(state, description), do: Class.update_method state, &Method.set_description(&1, description)

  @spec add_parameter(state, CodeParserState.Property.property) :: state
  def add_parameter(state, parameter), do: Class.update_method state, &Method.add_parameter(&1, parameter)

  @spec update_parameter(state, fun) :: state
  def update_parameter(state, update), do: Class.update_method state, &Method.update_parameter(&1, update)
end
