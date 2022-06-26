require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "POST /create" do
    let(:photo_with_valid_attributes) { ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)}
    let(:user_with_valid_attributes) { User.new(first_name: 'Alex', birth: Date.new(1990,01,01), sex: 'Man', 
                                       latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                       email: 'Timom@mail.ru', password: 'dsdfss') }
    let(:user2_with_valid_attributes) { User.new(first_name: 'Alexa', birth: Date.new(1995,01,01), sex: 'Female', 
                                        latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                        email: 'Tinn@mail.ru', password: 'dsdfss') }
    before(:each) do
      create_user(user_with_valid_attributes, photo_with_valid_attributes)
      create_user(user2_with_valid_attributes, photo_with_valid_attributes)
      login_as(user_with_valid_attributes, run_callbacks: false)
    end

    it "creates new message" do
      users = [user_with_valid_attributes, user2_with_valid_attributes]
      room = Room.create_private_room(users, "private_#{users.sort[0].id}_#{users.sort[1].id}")
      expect {
        post room_messages_path(room.id), params: { message: { user_id: user_with_valid_attributes.id, room_id: room.id, body: 'dfsddfg' }}
      }.to change(user_with_valid_attributes.messages, :count).by(1)
    end
  end
end
