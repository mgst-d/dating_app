class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many_attached :foto
  has_many :hobbies,  through: :hobby_users
  has_many :hobby_users, dependent: :destroy
  belongs_to :work
end
