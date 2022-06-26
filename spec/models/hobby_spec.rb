require 'rails_helper'

RSpec.describe Hobby, type: :model do
  it { should have_many(:hobby_users) }
  it { should have_many(:users) }
end
