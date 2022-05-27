class HobbyUser < ApplicationRecord
  belongs_to :user
  belongs_to :hobby

  validates :user_id, presence: true
  validates :hobby_id, presence: true
end
