require 'rails_helper'

RSpec.describe 'Item creation', type: :request do
  describe '.resolve' do
    let(:todo_list) { create(:todo_list) }

    it 'creates new item with right params' do
      expect do
        post '/graphql', params: { query: query(todo_list_id: todo_list.id) }
      end.to change { Item.count }.by(1)
    end

    it 'returns nil item with false result if todo_list not exists' do
      post '/graphql', params: { query: query(todo_list_id: 'fakeId') }

      json = JSON.parse(response.body)['data']['createItem']
      expect(json).to include(
        'item' => nil,
        'result' => false
      )
    end
  end

  def query(todo_list_id:)
    <<~GRAPHQL
      mutation {
        createItem(
          input: {
            name: "New item"
            done: false
            todoListId: #{todo_list_id}
          }
        )
        {
          item {
            id
            name
            done
            todoListId
          }
          result
        }
      }
    GRAPHQL
  end
end
