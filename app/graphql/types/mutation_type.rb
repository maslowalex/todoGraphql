module Types
  class MutationType < Types::BaseObject
    field :createItem, mutation: Mutations::CreateItem
    field :createTodoList, mutation: Mutations::CreateTodoList
  end
end
