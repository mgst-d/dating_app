require 'rails_helper'

RSpec.describe "Rooms", type: :request do
  describe "GET /index" do
    context 'when the user is logged in' do
      it "returns http success" do
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
