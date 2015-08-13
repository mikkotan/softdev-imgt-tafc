require 'rails_helper'
require 'database_cleaner'

# visit('page_url') # navigate to page
# click_link('id_of_link') # click link by id
# click_link('link_text') # click link by link text
# click_button('button_name') # fill text field
# fill_in('First Name', :with => 'John') # choose radio button
# choose('radio_button') # choose radio button
# check('checkbox') # check in checkbox
# uncheck('checkbox') # uncheck in checkbox
# select('option', :from=>'select_box') # select from dropdown
# attach_file('image', 'path_to_image') # upload file

RSpec.feature 'User CRUD thingy', type: :feature do
  before(:all) do
    User.create(password: 'pulitzer',
                username: 'starjirachi1',
                password_confirmation: 'pulitzer',
                first_name: 'Anfernee',
                last_name: 'Ng',
                role: 'owner')
    visit '/login'

    fill_in 'username', with: 'starjirachi1'
    fill_in 'password', with: 'pulitzer'

    click_button 'Log In'
  end

  scenario 'Owner creates an Employee' do
    visit '/users/new'

    fill_in 'user_first_name', with: 'Keia Joy'
    fill_in 'user_last_name', with: 'Harder'
    fill_in 'user_username', with: 'keia123'
    fill_in 'user_password', with: 'aaaa'
    fill_in 'user_password_confirmation', with: 'aaaa'
    choose 'user_role_owner'
    click_button 'Create User'

    sleep(5.minutes)
    expect(page).to have_text 'User successfully created.'
  end
end
