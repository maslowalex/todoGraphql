module Types  
  class TodoListType < Types::BaseObject
    graphql_name 'TodoList'
    description 'The Todo List type'

    field :id, ID, null: false
    field :title, String, null: false
    field :items, [Types::ItemType], null: true

    field :items_count, Integer, null: true
    def items_count
      object.items.count
    end

  end
end
