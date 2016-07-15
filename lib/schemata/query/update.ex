defmodule Schemata.Query.Update do
  @moduledoc ""

  import Schemata.Query.Helper
  alias Schemata.Query

  @type t :: %__MODULE__{
    table:  Query.table,
    in:     Query.keyspace,
    set:    Query.values,
    where:  Query.values,
    with:   Query.consistency_level
  }

  @enforce_keys [:table, :set]
  defstruct [
    table:  nil,
    in:     nil,
    set:    nil,
    where:  %{},
    with:   :quorum
  ]

  @behaviour Schemata.Query

  @doc ""
  @spec from_map(map) :: __MODULE__.t
  def from_map(map) do
    query_from_map map,
      take: [:table, :in, :set, :where, :with],
      required: [:table, :set],
      return: %__MODULE__{table: "bogus", set: %{}}
  end

  defimpl Schemata.Queryable do
    def statement(struct) do
      """
      UPDATE #{struct.table} SET #{struct.set |> Map.keys |> update_columns} \
      #{conditions(struct.where |> Map.keys)}
      """
      |> String.trim
    end

    def values(struct), do: Map.merge(struct.set, struct.where)
    def keyspace(struct), do: struct.in
    def consistency(struct), do: struct.with
  end
end