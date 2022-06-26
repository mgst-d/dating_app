require 'rails_helper'

RSpec.describe "/users", type: :request do

  let(:photo_with_valid_attributes) { ActiveStorage::Blob.new(filename: 'foto', checksum: 'sadasd', content_type: 'image/jpeg', byte_size: 299946)}
  let(:user_with_valid_attributes) { User.new(first_name: 'Alex', birth: Date.new(1990,01,01), sex: 'Man', 
                                     latitude: 27.53037290421605, longitude: 53.905427341494146, 
                                     email: 'Ti@mail.ru', password: 'dsdfss') }
  let(:valid_attributes) { {first_name: 'Alex', birth: Date.new(1990,01,01), sex: 'Man', latitude: 27.53037290421605,
                            longitude: 53.905427341494146, email: 'Ti@mail.ru', password: 'dsdfss'} }
  let(:invalid_attributes) { {first_name: ('Alexa' * 11), birth: Date.new(1990,01,01), sex: 'Man', latitude: 27.53037290421605,
                              longitude: 53.905427341494146, email: 'Ti@mail.ru', password: 'dsdfss'} }
  let(:user) { create_user(user_with_valid_attributes, photo_with_valid_attributes) }
  let(:new_attributes) { {first_name: 'Alexei', birth: Date.new(1995,01,01), sex: 'Man', latitude: 27.53037290421605,
                          longitude: 53.905427341494146, email: 'Ti@mail.ru', current_password: 'dsdfss'} }
  
  context 'when the user is not logged in' do
    describe "GET /index" do
      it "renders a successful response" do
        get users_url(user)
        expect(response).to be_successful
      end
    end

    describe "GET /show" do
      
      it "redirects to sign_in page" do
        get user_path(user)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /new" do
      it "renders a successful response" do
        get new_user_registration_path
        expect(response).to be_successful
      end
    end

    describe "GET /matches" do
      it "redirects to sign_in page" do
        get matches_user_path(user)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET /about" do
      it "renders a successful response" do
        get about_path
        expect(response).to be_successful
      end
    end

    describe "GET /edit" do
      it "gets status 401 Unauthorized" do
        get edit_user_registration_path(user)
        expect(response).to have_http_status(401)
      end
    end

    describe "PATCH /update" do
      context "with valid parameters" do
        let(:new_attributes) { { first_name: 'Oleg', birth: Date.new(1989,01,01), sex: 'Man', latitude: 25.53037290421605,
          longitude: 51.905427341494146, email: 'Titov@mail.ru', password: 'dsfsfsf'} }
  
        it "gets status 401 Unauthorized" do
          patch user_registration_path(user), params: { user: new_attributes }
          user.reload
          expect(response).to have_http_status(401)
        end
      end
  
      context "with invalid parameters" do
        it "gets status 401 Unauthorized" do
          patch user_registration_path(user), params: { user: invalid_attributes }
          expect(response).to have_http_status(401)
          expect(response.body).to include("You need to sign in or sign up before continuing.")
        end
      end
    end

    describe "DELETE /destroy" do
      it "redirects to sign_in page" do
        delete user_url(user)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'when the user is logged in' do
    before do
      login_as(user, run_callbacks: false)
    end

    describe "GET /index" do
      it "renders a successful response" do
        get users_url(user)
        expect(response).to be_successful
      end
    end

    describe "GET /show" do   
      it "renders a successful response" do
        get user_path(user)
        expect(response).to be_successful
      end
    end

    describe "GET /new" do
      it "renders a successful response" do
        get new_user_registration_path
        expect(response).to redirect_to(root_path)
      end
    end

    describe "GET /matches" do
      it "renders a successful response" do
        get matches_user_path(user)
        expect(response).to be_successful
      end
    end

    describe "GET /about" do
      it "renders a successful response" do
        get about_path
        expect(response).to be_successful
      end
    end

    describe "GET /edit" do
      it "renders a successful response" do
        get edit_user_registration_path(user)
        expect(response).to be_successful
      end
    end

    describe "POST /create" do
  
      context "with valid parameters" do
        it "does not create a new User" do
          expect {
            post users_url, params: { user: invalid_attributes }
          }.to change(User, :count).by(0)
        end
        it "redirects to the root page" do
          post users_url, params: { user: valid_attributes }
          expect(response).to redirect_to(root_path)
        end
      end
  
      context "with invalid parameters" do
        it "does not create a new User" do
          expect {
            post users_url, params: { user: invalid_attributes }
          }.to change(User, :count).by(0)
        end
  
        it "redirects to the root page" do
          post users_url, params: { user: invalid_attributes }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    describe "PATCH /update" do
      context "with valid parameters" do
        
  
        it "updates the requested user" do
          patch user_registration_path, params: { user: new_attributes }
          user.reload
          expect(user.first_name).to eq('Alexei')
        end
  
        it "redirects to the user" do
          patch user_registration_path, params: { user: new_attributes }
          user.reload
          expect(response).to redirect_to(user_path(user))
        end
      end
  
      context "with invalid parameters" do
        it "renders a successful response (i.e. to display the 'edit' template)" do
          patch user_registration_path, params: { user: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested user" do
        expect {
          delete user_url(user)
        }.to change(User, :count).by(-1)
      end
  
      it "redirects to the index page" do
        delete user_url(user)
        expect(response).to redirect_to(users_path)
      end
    end
  end
end
