class Hobby < ApplicationRecord
  has_many :hobby_users, dependent: :destroy
  has_many :users, through: :hobby_users
end
