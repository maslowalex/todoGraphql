require 'rails_helper'

RSpec.describe 'Item destroy', type: :request do
  let!(:todo_list) { create(:todo_list) }
  let!(:item) { create(:item, todo_list: todo_list, done: true)}

  it 'destroy item' do
    expect do
      post '/graphql', params: { query: query(id: item.id) }
    end.to change { Item.count }.by(-1)
  end

  it 'returns destroyed item' do
    post '/graphql', params: { query: query(id: item.id) }
    json_item = JSON.parse(response.body).dig('data', 'destroyItem', 'item')
    expect(json_item).to include(
      'id' => item.id.to_s,
      'done' => true,
      'name' => item.name,
      'todoListId' => todo_list.id.to_s
    )
  end

  it "returns an error when item doesn't exists" do
    post '/graphql', params: { query: query(id: 'fake_id') }
    error = JSON.parse(response.body).dig('data', 'destroyItem', 'error')
    expect(error).to eq true
  end

  def query(id:)
    <<~GRAPHQL
      mutation {
        destroyItem(
          input: {
            id: #{id}
          }
        ) {
          item {
            id
            name
            done
            todoListId
          }
          error
        } 
      }
    GRAPHQL
  end
end
