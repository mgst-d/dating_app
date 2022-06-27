require "rails_helper"

RSpec.describe RoomsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/rooms").to route_to("rooms#index")
    end
  end
end