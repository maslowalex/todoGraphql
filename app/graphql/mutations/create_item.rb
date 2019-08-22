module Mutations
  class CreateItem < GraphQL::Schema::RelayClassicMutation
    graphql_name 'createItem'

    field :item, Types::ItemType, null: true
    field :result, Boolean, null: false

    argument :name, String, required: true
    argument :done, Boolean, required: true
    argument :todo_list_id, ID, required: true

    def resolve(**args)
      todo_list = TodoList.where(id: args[:todo_list_id])&.first
      return todo_not_exists unless todo_list

      item = Item.create(name: args[:name], done: args[:done], todo_list: todo_list)
      {
        item: item,
        result: item.errors.blank?
      }
    end

    def todo_not_exists
      {
        item: nil,
        result: false
      }
    end
  end
end
