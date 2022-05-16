require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        first_name: "First Name",
        last_name: "Last Name",
        sex: false,
        work_id: 2,
        yourself: "MyText",
        latitude: 3.5,
        longitude: 4.5,
        foto: nil
      ),
      User.create!(
        first_name: "First Name",
        last_name: "Last Name",
        sex: false,
        work_id: 2,
        yourself: "MyText",
        latitude: 3.5,
        longitude: 4.5,
        foto: nil
      )
    ])
  end

#   it "renders a list of users" do
#     render
#     assert_select "tr>td", text: "First Name".to_s, count: 2
#     assert_select "tr>td", text: "Last Name".to_s, count: 2
#     assert_select "tr>td", text: false.to_s, count: 2
#     assert_select "tr>td", text: 2.to_s, count: 2
#     assert_select "tr>td", text: "MyText".to_s, count: 2
#     assert_select "tr>td", text: 3.5.to_s, count: 2
#     assert_select "tr>td", text: 4.5.to_s, count: 2
#     assert_select "tr>td", text: nil.to_s, count: 2
#   end
end
