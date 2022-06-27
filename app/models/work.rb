class Work < ApplicationRecord
  has_many :users, dependent: :nullify
end
