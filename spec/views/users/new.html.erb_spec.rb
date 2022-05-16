require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign(:user, User.new(
      first_name: "MyString",
      last_name: "MyString",
      sex: false,
      work_id: 1,
      yourself: "MyText",
      latitude: 1.5,
      longitude: 1.5,
      foto: nil
    ))
  end

#   it "renders new user form" do
#     render

#     assert_select "form[action=?][method=?]", users_path, "post" do

#       assert_select "input[name=?]", "user[first_name]"

#       assert_select "input[name=?]", "user[last_name]"

#       assert_select "input[name=?]", "user[sex]"

#       assert_select "input[name=?]", "user[work_id]"

#       assert_select "textarea[name=?]", "user[yourself]"

#       assert_select "input[name=?]", "user[latitude]"

#       assert_select "input[name=?]", "user[longitude]"

#       assert_select "input[name=?]", "user[foto]"
#     end
  # end
end
