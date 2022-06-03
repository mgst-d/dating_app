Rails.application.config.active_record.belongs_to_required_by_default = false

# this is User model
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
           inverse_of: :likee
  has_many :likees, through: :liker_likes
  has_many :likee_likes,
           class_name: 'Like',
           foreign_key: 'likee_id',
           dependent: :destroy,
           inverse_of: :liker
  has_many :likers, through: :likee_likes

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, length: { maximum: 50 }
  validates :sex, presence: true
  validates :latitude, presence: true
  validates :birth, presence: true, comparison: { greater_than: Time.gm(1900), less_than: Time.zone.now }
  validates :yourself, length: { maximum: 255 }
  validates :foto, attached: true, size: { less_than: 2.megabytes }, content_type: %i[png jpg jpeg bmp],
                   limit: { min: 1, max: 5 }
  validate :yourself_forbidden_words
  scope :all_except, ->(user) { where.not(id: user) }

  def yourself_forbidden_words(filter_text = ProfanityFilter.new)
    errors.add(:yourself, 'includes forbidden words') if filter_text.profane?(yourself)
  end
end
