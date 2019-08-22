module Types
  class ItemType < Types::BaseObject
    graphql_name 'ItemType'

    field :id, ID, null: false
    field :name, String, null: false
    field :done, Boolean, null: false
    field :todo_list_id, ID, null: false
  end
end
