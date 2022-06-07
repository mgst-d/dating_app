require "rails_helper"

RSpec.describe LikesController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(post: "/like").to route_to("likes#create")
    end

    it "routes to #destroy" do
      expect(delete: "/dislike/1/2").to route_to("likes#destroy", liker_id: "1", likee_id: "2")
    end
  end
end
