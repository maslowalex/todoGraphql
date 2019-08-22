require 'rails_helper'

RSpec.describe 'TodoList creation', type: :request do
  describe '.resolve' do
    it 'creates new todo list with right params' do
      post '/graphql', params: { query: query(title: 'New list') }
      data = JSON.parse(response.body).dig('data', 'createTodoList', 'todoList')
      result = JSON.parse(response.body).dig('data', 'createTodoList', 'result')

      expect(data).to include(
        'id' => be_present,
        'title' => 'New list'
      )
      expect(result).to be_truthy
    end

    it 'returns false as result with wrong params' do
      post '/graphql', params: { query: query(title: 'New list') }
      result = JSON.parse(response.body).dig('data', 'createTodoList', 'todoList', 'result')

      expect(result).to be_falsy
    end
  end

  def query(title:)
    <<~GRAPHQL
      mutation {
        createTodoList (
          input: {
            title: "#{title}"
           }
        )
        {
          todoList {
            id
            title
          }
          result
        }
      }
    GRAPHQL
  end
end
