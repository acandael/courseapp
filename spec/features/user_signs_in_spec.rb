require 'spec_helper'

feature 'User signs in' do
  background do
    Fabricate(:course)
  end
  scenario "with valid email and password" do
    alice = Fabricate(:user)
    visit sign_in_path
    fill_in "Email Address", with: alice.email
    fill_in "Password", with: alice.password
    click_button "Sign In"
    page.should have_content alice.full_name
  end

end
