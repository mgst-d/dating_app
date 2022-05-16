require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
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

#   it "renders the edit user form" do
#     render

#     assert_select "form[action=?][method=?]", user_path(@user), "post" do

#       assert_select "input[name=?]", "user[first_name]"

#       assert_select "input[name=?]", "user[last_name]"

#       assert_select "input[name=?]", "user[sex]"

#       assert_select "input[name=?]", "user[work_id]"

#       assert_select "textarea[name=?]", "user[yourself]"

#       assert_select "input[name=?]", "user[latitude]"

#       assert_select "input[name=?]", "user[longitude]"

#       assert_select "input[name=?]", "user[foto]"
#     end
#   end
end
