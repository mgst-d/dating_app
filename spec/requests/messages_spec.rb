require 'rails_helper'

RSpec.describe "Messages", type: :request do
  describe "POST /create" do

    let(:photo_with_valid_attributes) { ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)}
    let(:user_with_valid_attributes) { User.new(first_name: 'Alex', birth: Date.new(1990,01,01), sex: 'Man', 
                                       latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                       email: 'Timom@mail.ru', password: 'dsdfss') }
    let(:room) { Room.create( name: 'private_123', is_private: true)}
    
    before(:each) do
      create_user(user_with_valid_attributes, photo_with_valid_attributes)
    end

    it "creates new message" do
      expect {
        post room_messages_path(room), params: { message: { user_id: user_with_valid_attributes, room_id: room, body: 'dfsddfg' }}
      }.to change(Message, :count).by(1)
    end
  end
end
