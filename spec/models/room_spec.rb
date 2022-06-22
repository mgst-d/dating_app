require 'rails_helper'

RSpec.describe Room, type: :model do
  it { should have_many(:messages) }
  it { should have_many(:participants) }
  it { should have_many(:users) }
end
