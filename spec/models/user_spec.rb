require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {described_class.new(first_name: "Kristy", last_name: "ZZZ", birth: "1990-01-01", sex: "Female", yourself: "fuck", latitude: 27.53037290421605, longitude: 53.905427341494146, email: "11@11", work_id: 17)}

  it 'returns correct name' do
    expect(user.first_name).to eq('Kristy')
  end

  it 'returns type string' do
    expect(user.first_name).to be_an_instance_of(String)
  end

  it 'returns error' do
    expect(user.yourself).to eq('?')
  end

end
