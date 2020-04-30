require 'rails_helper'

RSpec.feature 'Friendship Interactions:' do
  let(:user_one) { User.create(email: 'user_one@email', name: 'user_one', password: 'dafnadnao') }
  let(:user_two) { User.create(email: 'user_two@email', name: 'user_two', password: 'advavvvava') }

  describe 'when user add friend' do
    it 'is able to send friendship requests' do
      sign_in(user_one.email, user_one.password)
      expect(page).to have_content('Sign out')
      send_friend_request(user_one, user_two)

      expect(user_one.is_friend?(user_two)).to be true
      expect(user_two.is_friended?(user_one)).to be true
      expect(user_one.friend_is_confirmed?(user_two)).to be nil
      expect(user_two.user_is_confirmed?(user_one)).to be nil
    end
  end

  def sign_in(email, password)
    visit new_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end

  def send_friend_request(user_one, user_two)
    click_on 'All users'
    user_one.request_friend(user_two)
  end
end
