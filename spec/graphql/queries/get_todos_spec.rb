require 'rails_helper'

RSpec.describe 'Get a todo list', type: :request do
  describe '#resolve' do
    it 'returns a list of all todos' do
      todo = create(:todo_list)
      item = create(:item, todo_list: todo)

      post'/graphql', params: { query: query_all_todos }
      todos = JSON.parse(response.body)['data']['todos'].first

      expect(todos).to include(
        'id' => todo.id.to_s,
        'title' => todo.title,
      )
      expect(todos['items'].first).to include(
        'id' => item.id.to_s,
        'name' => item.name,
        'done' => item.done
      )
    end

    it 'returns a single todo with computed field' do
      todo = create(:todo_list)
      post'/graphql', params: { query: query_single_todo(id: todo.id) }

      json = JSON.parse(response.body)['data']
      expect(json['todo']).to include(
        'id' => todo.id.to_s,
        'title' => todo.title,
        'itemsCount' => 0
      )
    end
  end

  def query_single_todo(id:)
    <<~GRAPHQL
      {
        todo(id: #{id}) {
          id
          title
          itemsCount
        }
      }
    GRAPHQL
  end

  def query_all_todos
    <<~GRAPHQL
    {
      todos {
        id
        title
        items {
          id
          name
          done
        }
      }
    }
    GRAPHQL
  end
end
