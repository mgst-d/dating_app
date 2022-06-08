require "rails_helper"

RSpec.describe MessagesController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(post: "/rooms/1/messages").to route_to("messages#create", room_id: "1")
    end
  end
end