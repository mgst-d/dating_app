require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  describe "GET /index" do
    let(:photo_with_valid_attributes) { ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)}
    let(:user_with_valid_attributes) { User.new(first_name: 'Alex', birth: Date.new(1990,01,01), sex: 'Man', 
                                       latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                       email: 'Timom@mail.ru', password: 'dsdfss') }
    context 'when the user is logged in' do
      it "returns http success" do
        create_user(user_with_valid_attributes, photo_with_valid_attributes)
        login_as(user_with_valid_attributes, run_callbacks: false)
        get rooms_path
        expect(response).to have_http_status(:success)
      end
    end
    
    context 'when the user is not logged in' do
      it "redirects to sign_in page" do
        get rooms_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
