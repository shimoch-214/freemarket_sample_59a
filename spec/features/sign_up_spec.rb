require 'rails_helper'

feature 'sign_up', type: :feature do

  scenario 'create user' do
visit user_registration_info_path
    fill_in 'user_nickname',with:"テスト"
    fill_in 'user_email', with: "foo@example.com"
    fill_in 'user_password', with:"12345678"
    fill_in 'user_password_confirmation',with:"12345678"
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
  end

end