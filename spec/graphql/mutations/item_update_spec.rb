require 'rails_helper'

RSpec.describe 'Item update', type: :request do
  let!(:todo_list) { create(:todo_list) }
  let!(:item) { create(:item, todo_list: todo_list)}

  it 'updates existing item' do
    post '/graphql', params: { query: query(id: item.id) }

    json_item = JSON.parse(response.body).dig('data', 'updateItem', 'item')
    expect(json_item).to include(
      'id' => item.id.to_s,
      'done' => true,
      'name' => item.name
    )
  end

  it 'with invalid params returns an error' do
    post '/graphql', params: { query: query(id: 0) }

    json = JSON.parse(response.body).dig('data', 'updateItem')
    expect(json).to include(
      'error' => 'Item not exists'
    )
  end

  def query(id:)
    <<~GRAPHQL
      mutation {
        updateItem(
          input: {
            itemId: #{id}
            done: true
          }
        ) {
          item {
            id
            name
            done
          }
          error
        } 
      }
    GRAPHQL
  end
end
