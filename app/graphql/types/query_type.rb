module Types
  class QueryType < Types::BaseObject
    field :todos, [Types::TodoListType], null: true
    def todos
      TodoList.includes(:items).all
    end

    field :todo, Types::TodoListType, null: false do
      argument :id, Int, required: true
    end
    def todo(id:)
      TodoList.find(id)
    end

    field :items, [Types::ItemType], null: false
    def items
      Item.all
    end

  end
end
