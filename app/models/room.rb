class Room < ApplicationRecord
  validates_uniqueness_of :name
  scope :public_rooms, -> {wher(is_private: false)}
end
