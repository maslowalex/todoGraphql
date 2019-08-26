module Mutations
  class DestroyItem < GraphQL::Schema::RelayClassicMutation
    graphql_name 'destroyItem'

    field :item, Types::ItemType, null: true
    field :error, Boolean, null: false

    argument :id, ID, required: true

    def resolve(**args)
      item = Item.find_by(id: args[:id])
      return item_not_exists unless item

      if item.destroy 
        {
          item: item,
          error: false
        }
      else
        {
          item: item,
          error: true
        }
      end
    end

    def item_not_exists
      {
        item: nil,
        error: true
      }
    end
  end
end
