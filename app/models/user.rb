Rails.application.config.active_record.belongs_to_required_by_default = false

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many_attached :foto
  has_many :hobby_users, dependent: :destroy
  has_many :hobbies, through: :hobby_users
  belongs_to :work
  has_many :liker_likes,
           class_name: 'Like',
           foreign_key: 'liker_id',
           dependent: :destroy,
           inverse_of: :user
  has_many :likees, through: :liker_likes
  has_many :likee_likes,
           class_name: 'Like',
           foreign_key: 'likee_id',
           dependent: :destroy,
           inverse_of: :user
  has_many :likers, through: :likee_likes
end
