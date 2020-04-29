require 'rails_helper'

RSpec.feature 'Guest Signs up' do

  describe "when guest visits the sign_up page" do

    it 'has the correct content' do
      visit new_user_registration_path
      expect(page).to have_content('Name')
      expect(page).to have_content('Email')
      expect(page).to have_content('Password (6 characters minimum)')
      expect(page).to have_content('Password confirmation')
      expect(page).to have_content('Sign up')
    end

    it 'sign up successfully' do
      sign_up 'asdf','a@sdf','asdfgh','asdfgh'
      expect(page).to have_content('Welcome! You have signed up successfully.')
      expect(page).to have_content('Recent posts')
      expect(page).to have_content('Sign out')
    end
    it 'returns error when blank' do
      sign_up '','','',''
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Password can't be blank")
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("3 errors prohibited this user from being saved:")
    end
    it 'returns error when invalid password' do
      sign_up 'asdf', 'a@sdf','asdf','asdf'
      expect(page).to have_content('Password is too short (minimum is 6 characters)')
    end
    it 'returns error if passwords dont match' do
      sign_up 'asdf','a@sdf','asdfgh','asdfhg'
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end

def sign_up (name, email,password,password_confirmation)
  visit new_user_registration_path
  fill_in 'Name', with: name
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password_confirmation
  click_button 'Sign up'
end
