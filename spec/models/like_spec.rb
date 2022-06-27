require 'rails_helper'

RSpec.describe Like, type: :model do
  it { should belong_to(:liker).class_name 'User' }
  it { should belong_to(:likee).class_name 'User' }
end