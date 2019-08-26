module Mutations
  class UpdateItem < GraphQL::Schema::RelayClassicMutation
    graphql_name 'updateItem'

    field :item, Types::ItemType, null: true
    field :error, String, null: true

    argument :item_id, ID, required: true
    argument :done, Boolean, required: false
    argument :name, String, required: false

    def resolve(**args)
      item = Item.find_by(id: args[:item_id])
      return item_not_exists unless item

      item.update(args.delete_if { |k,v| k == :item_id })
      {
        item: item,
        error: ''
      }
    end

    def item_not_exists
      {
        item: nil,
        error: 'Item not exists'
      }
    end
  end
end
