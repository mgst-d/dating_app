class Hobby < ApplicationRecord
  has_many :users,  through: :hobby_users
  has_many :hobby_users
end