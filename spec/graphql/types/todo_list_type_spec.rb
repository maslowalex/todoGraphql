require 'rails_helper'

RSpec.describe Types::TodoListType do
  set_graphql_type

  it 'has a correct field types' do
    expect(subject.fields["id"].type.to_type_signature).to eq("ID!")
    expect(subject.fields["title"].type.to_type_signature).to eq("String!")
  end
end
