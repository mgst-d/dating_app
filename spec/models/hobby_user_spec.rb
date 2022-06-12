require 'rails_helper'

RSpec.describe HobbyUser, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:hobby) }
end