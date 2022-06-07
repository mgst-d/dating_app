require "rails_helper"

RSpec.describe UsersController, type: :routing do
  describe "routing" do
    it "routes to users#index" do
      expect(get: "/users").to route_to("users#index")
    end

    it "routes to users#mathes" do
      expect(get: "/users/1/matches").to route_to("users#matches", id: "1")
    end
    
    it "routes to users#new" do
      expect(get: "/users/sign_up").to route_to("users/registrations#new")
    end

    it "routes to users#show" do
      expect(get: "/users/1").to route_to("users#show", id: "1")
    end

    it "routes to users#edit" do
      expect(get: "/users/edit/").to route_to("users/registrations#edit")
    end

    it "routes to users#create" do
      expect(post: "/users").to route_to("users/registrations#create")
    end

    it "routes to users#update via PUT" do
      expect(put: "/users").to route_to("users/registrations#update")
    end

    it "routes to users#update via PATCH" do
      expect(patch: "/users").to route_to("users/registrations#update")
    end

    it "routes to users#destroy" do
      expect(delete: "/users/1").to route_to("users#destroy", id: "1")
    end

    it "routes to likes#create" do
      expect(post: "/like").to route_to("likes#create")
    end

    it "routes to likes#destroy" do
      expect(delete: "/dislike/1/2").to route_to("likes#destroy", liker_id: "1", likee_id: "2")
    end

    it "routes to attachments#purge" do
      expect(delete: "/attachments/1/purge").to route_to("attachments#purge", id: "1")
    end
    
    it "routes to sessions#create" do
      expect(post: "/users/sign_in").to route_to("devise/sessions#create")
    end

    it "routes to sessions#destroy" do
      expect(delete: "/users/sign_out").to route_to("devise/sessions#destroy")
    end
    
    it "routes to passwords#new" do
      expect(get: "/users/password/new").to route_to("devise/passwords#new")
    end
    
    it "routes to passwords#edit" do
      expect(get: "/users/password/edit").to route_to("devise/passwords#edit")
    end
    
    it "routes to passwords#update via PUT" do
      expect(put: "/users/password").to route_to("devise/passwords#update")
    end

    it "routes to passwords#update via PATCH" do
      expect(patch: "/users/password").to route_to("devise/passwords#update")
    end
    it "routes to passwords#create" do
      expect(post: "/users/password").to route_to("devise/passwords#create")
    end
  end
end
