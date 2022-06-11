# This is Message model
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  after_create_commit { broadcast_append_to room }

  before_create :confirm_participant

  def confirm_participant
    is_participant = Participant.find_by(user_id: user.id, room_id: room.id)
    throw :abort unless is_participant
  end
end
