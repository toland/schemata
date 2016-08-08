defmodule Schemata.Schemas.Wocky do
  use Schemata.Schema

  keyspace :ks_atom do
    table :ks_atom_table, [
      columns: [
        id: :text
      ],
      primary_key: :id
    ]
  end

  keyspace "ks_binary" do
    table "ks_binary_table", [
      columns: [
        id: :text
      ],
      primary_key: :id
    ]
  end

  keyspace ~r/ks_(test_)?(regex|.*_foo)/ do
    table :ks_regex_table, [
      columns: [
        id: :text
      ],
      primary_key: :id
    ]
  end
end
