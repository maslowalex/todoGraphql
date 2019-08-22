require 'rails_helper'

RSpec.describe Types::ItemType do
  set_graphql_type

  it 'has a correct field types' do
    expect(subject.fields["id"].type.to_type_signature).to eq("ID!")
    expect(subject.fields["name"].type.to_type_signature).to eq("String!")
    expect(subject.fields["done"].type.to_type_signature).to eq("Boolean!")
  end
end
