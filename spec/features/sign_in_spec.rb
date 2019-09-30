require 'rails_helper'

feature 'sign_in', type: :feature do
  background do
    User.create!(email: 'foo@example.com', password: '12345678',password_confirmation:'12345678',nickname:"たとえばさん")
  end

  scenario 'login' do
visit new_user_session_path
    fill_in 'user_email', with: "foo@example.com"
    fill_in 'user_password', with:"12345678"
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
  end

  
end