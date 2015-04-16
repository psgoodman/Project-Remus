require 'rails_helper'

feature "create new galaxy" do
  scenario "galaxy created successfully" do
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
    visit galaxy_path(galaxy)
    click_button "Delete This Galaxy"
    expect(page).to have_content("Create New Galaxy")
  end
end
