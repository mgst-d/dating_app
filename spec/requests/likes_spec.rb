require 'rails_helper'

RSpec.describe "/likes", type: :request do

  let(:photo_with_valid_attributes) { ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)}
  let(:user_with_valid_attributes) { User.new(first_name: 'Alex', birth: Date.new(1990,01,01), sex: 'Man', 
                                     latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                     email: 'Timom@mail.ru', password: 'dsdfss') }
	let(:user2_with_valid_attributes) { User.new(first_name: 'Dasha', birth: Date.new(1990,01,01), sex: 'Female', 
																			latitude: 27.53037290421605, longitude: 53.905427341494146, 
																			email: 'Timomyy@mail.ru', password: 'dsdfss') }
  before(:each) do
    create_user(user_with_valid_attributes, photo_with_valid_attributes)
    create_user(user2_with_valid_attributes, photo_with_valid_attributes)
  end

  describe "POST /create" do

    it "creates new like" do
      expect {
        post create_like_path, params: { like: { liker_id: user_with_valid_attributes, likee_id: user2_with_valid_attributes } }
      }.to change(Like, :count).by(1)
    end

    it "redirects to the root page" do
      post create_like_path, params: { like: { liker_id: user_with_valid_attributes, likee_id: user2_with_valid_attributes } }
      expect(response).to redirect_to(root_path)
    end
  end
	
  describe "DELETE /destroy" do

    it "destroys like" do
      expect {
        delete destroy_like_path(liker_id: user_with_valid_attributes, likee_id: user2_with_valid_attributes)
      }.to change(Like, :count).by(-1)
    end

    it "redirects to the root page" do
      delete destroy_like_path(liker_id: user_with_valid_attributes, likee_id: user2_with_valid_attributes)
      expect(response).to redirect_to(root_path)
    end
  end
end