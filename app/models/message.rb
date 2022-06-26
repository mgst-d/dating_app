# This is Message model
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :body, length: { maximum: 255 }
  before_create :confirm_participant

  after_create_commit do
    notify_recipient
    broadcast_append_to room
  end

  def confirm_participant
    is_participant = Participant.find_by(user_id: user.id, room_id: room.id)
    throw :abort unless is_participant
  end

  private
  def notify_recipient
      notification = MessageNotification.with(message: self, room: self.room)
      notification.deliver_later(user)
  end
end
