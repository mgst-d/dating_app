require 'rails_helper'

RSpec.describe Message, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:room) }
  it { should validate_length_of(:body).is_at_most(255) }


end
