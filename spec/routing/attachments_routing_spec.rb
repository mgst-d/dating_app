require "rails_helper"

RSpec.describe AttachmentsController, type: :routing do
  describe "routing" do
    it "routes to #purge" do
      expect(delete: "/attachments/1/purge").to route_to("attachments#purge", id: "1")
    end
  end
end
