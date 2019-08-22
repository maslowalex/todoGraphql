module Mutations
  class CreateTodoList < GraphQL::Schema::RelayClassicMutation
    graphql_name 'createTodoList'

    field :todo_list, Types::TodoListType, null: true
    field :result, Boolean, null: false

    argument :title, String, required: false

    def resolve(**args)
      todo = TodoList.create(title: args[:title])
      {
        todo_list: todo,
        result: todo.errors.blank?
      }
    end
  end
end
