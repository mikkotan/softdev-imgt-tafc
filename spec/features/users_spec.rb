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

RSpec.feature 'User CRUD', js: true do
  before(:each) do
    User.create(password: 'pulitzer',
                email: 'starjirachi1@yahoo.com',
                password_confirmation: 'pulitzer',
                first_name: 'Anfernee',
                last_name: 'Ng',
                role: 'owner')
    User.create(password: 'aaaaaaaa',
                email: 'tawoako@hooray.com',
                password_confirmation: 'aaaaaaaa',
                first_name: 'John',
                last_name: 'Peterson',
                role: 'manager')
  end

  scenario 'Create User' do
    visit '/login'
    fill_in 'email', with: 'starjirachi1@yahoo.com'
    fill_in 'password', with: 'pulitzer'

    click_button 'Log in'
    visit '/users/new'

    fill_in 'user_first_name', with: 'Keia Joy'
    fill_in 'user_last_name', with: 'Harder'
    fill_in 'user_email', with: 'keia123@gmail.com'
    fill_in 'user_password', with: 'aaaaaaaa'
    fill_in 'user_password_confirmation', with: 'aaaaaaaa'
    choose 'user_role_owner'
    click_button 'Create User'

    expect(page).to have_text 'User successfully created.'
  end

  scenario 'Read User' do
    visit '/login'
    fill_in 'email', with: 'starjirachi1@yahoo.com'
    fill_in 'password', with: 'pulitzer'

    click_button 'Log in'

    click_link 'Peterson, John'
    expect(page).to have_text 'Email: tawoako@hooray.com'
  end

  scenario 'Delete User' do
    visit '/login'
    fill_in 'email', with: 'starjirachi1@yahoo.com'
    fill_in 'password', with: 'pulitzer'

    click_button 'Log in'
    within('#btns_2') do
      click_button 'Destroy'
    end
    page.driver.browser.switch_to.alert.accept

    expect(page).to_not have_text 'Email: tawoako'
  end

  scenario 'Edit User' do
    visit '/login'
    fill_in 'email', with: 'starjirachi1@yahoo.com'
    fill_in 'password', with: 'pulitzer'

    click_button 'Log in'
    within('#btns_2') do
      click_button 'Edit Profile'
    end

    fill_in 'user_first_name', with: 'Keia Joy'
    fill_in 'user_last_name', with: 'Harder'
    fill_in 'user_email', with: 'keia123@gmail.com'
    choose 'user_role_employee'
    click_button 'Update User'

    expect(page).to have_text 'Email: keia123@gmail.com'
    expect(page).to have_text 'Harder, Keia Joy'
    expect(page).to have_text 'Successfully updated profile.'
    expect(page).to have_text 'employee'
  end
end

RSpec.feature 'User CRUD thingy', js: true do
  # Dear Albert, paki-edit lg hahaha. Ang minimum length sg password 8 characters.
  # Kg ang minimum length sg username 6 characters.

  before(:each) do
    User.create(password: 'pulitzer',
                email: 'starjirachi1@yahoo.com',
                password_confirmation: 'pulitzer',
                first_name: 'Anfernee',
                last_name: 'Ng',
                role: 'owner')

    User.create(password: 'wow1234567',
                email: 'aafuensalida@yahoo.com',
                password_confirmation: 'wow1234567',
                first_name: 'Albert',
                last_name: 'Fuensalida',
                role: 'employee')
  end

  scenario 'Owner creates an Employee' do
    visit '/login'
    fill_in 'email', with: 'starjirachi1@yahoo.com'
    fill_in 'password', with: 'pulitzer'

    click_button 'Log in'
    visit '/users/new'

    fill_in 'user_first_name', with: 'Keia Joy'
    fill_in 'user_last_name', with: 'Harder'
    fill_in 'user_email', with: 'keia123@yahoo.com'
    fill_in 'user_password', with: 'IloveNongArms'
    fill_in 'user_password_confirmation', with: 'IloveNongArms'
    choose 'user_role_employee'
    click_button 'Create User'

    expect(page).to have_text 'User successfully created.'
  end

  scenario 'Owner edits Employee' do
    visit '/login'
    fill_in 'email', with: 'starjirachi1@yahoo.com'
    fill_in 'password', with: 'pulitzer'

    click_button 'Log in'
    visit '/users/2/edit'

    fill_in 'user_first_name', with: 'Albert'
    fill_in 'user_last_name', with: 'Fuensalida'
    fill_in 'user_email', with: 'ambet_123@yahoo.com'
    choose 'user_role_employee'
    click_button 'Update User'
    expect(page).to have_text 'Successfully updated profile.'
  end

  scenario 'Owner uses logout' do
    visit '/login'
    fill_in 'email', with: 'starjirachi1@yahoo.com'
    fill_in 'password', with: 'pulitzer'
    click_button 'Log in'
    visit '/logout'
    expect(page).to have_text 'Successfully Logged Out!'
  end


  scenario 'User inputs wrong password' do
    visit '/logout'
    visit '/login'
    fill_in 'email', with: 'aafuensalida@yahoo.com'
    fill_in 'password', with: 'wrongpassword'
    click_button 'Log in'
    expect(page).to have_text 'Invalid Email or Password!'
  end

  scenario 'Owner edits an employee with wrong password confirmation' do
    visit '/login'
    fill_in 'email', with: 'starjirachi1@yahoo.com'
    fill_in 'password', with: 'pulitzer'

    click_button 'Log in'
    visit '/users/2/change_password'
    fill_in 'user_password', with: 'ambet_1234567'
    fill_in 'user_password_confirmation', with: 'wrongpassword'
    click_button 'Update User'

    expect(page).to have_text 'Password confirmation'
  end
end
