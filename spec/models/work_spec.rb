require 'rails_helper'

RSpec.describe Work, type: :model do
  it { should have_many(:users) }
end