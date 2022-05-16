require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      first_name: "First Name",
      last_name: "Last Name",
      sex: false,
      work_id: 2,
      yourself: "MyText",
      latitude: 3.5,
      longitude: 4.5,
      foto: nil
    ))
  end

#   it "renders attributes in <p>" do
#     render
#     expect(rendered).to match(/First Name/)
#     expect(rendered).to match(/Last Name/)
#     expect(rendered).to match(/false/)
#     expect(rendered).to match(/2/)
#     expect(rendered).to match(/MyText/)
#     expect(rendered).to match(/3.5/)
#     expect(rendered).to match(/4.5/)
#     expect(rendered).to match(//)
#   end
end
