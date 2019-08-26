module Types
  class MutationType < Types::BaseObject
    field :destroyItem, mutation: Mutations::DestroyItem
    field :createItem, mutation: Mutations::CreateItem
    field :createTodoList, mutation: Mutations::CreateTodoList
    field :updateItem, mutation: Mutations::UpdateItem
  end
end
