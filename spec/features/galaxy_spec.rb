require 'rails_helper'
require 'helpers'

feature "create new galaxy" do
    let(:user) { FactoryGirl.create(:user) }
  scenario "galaxy created successfully" do
    sign_in_as(user)
    visit new_galaxy_path
    fill_in 'Name', with: "Test Galaxy Please Ignore"
    fill_in 'Rings', with: 2
    click_button "Create Galaxy"
    expect(page).to have_content("Test Galaxy Please Ignore")
  end
end

feature "Delete a galaxy" do
  let(:galaxy) { FactoryGirl.create(:galaxy) }
  scenario "successfully delete" do
    sign_in_as(galaxy.gm)
    visit galaxy_path(galaxy)
    click_button "Delete This Galaxy"
    expect(page).to have_content("Create New Galaxy")
  end
end
