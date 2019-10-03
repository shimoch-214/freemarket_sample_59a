require 'rails_helper'

feature 'sign_up', type: :feature do
  scenario 'create user' do
visit user_info_path
    fill_in 'user_nickname',with:"テスト"
    fill_in 'user_email', with: "foo@example.com"
    fill_in 'user_password', with:"12345678"
    fill_in 'user_password_confirmation',with:"12345678"
    fill_in 'user_identification_attributes_last_name',with: "高橋"
    fill_in 'user_identification_attributes_first_name',with: "優香"
    fill_in 'user_identification_attributes_last_name_kana',with: "タカハシ"
    fill_in 'user_identification_attributes_first_name_kana',with: "ユウカ"
    select '2000', from: 'birthday_birthday_1i'
    select '3', from: 'birthday_birthday_2i'
    select '21', from: 'birthday_birthday_3i'
    find('input[name="commit"]').click
    expect(current_path).to eq user_phone_number_path
    fill_in 'user_phone_number',with: "09012345672"
    find('input[name="commit"]').click
    expect(current_path).to eq user_adress_path
    fill_in 'user_adress_attributes_last_name',with: "高橋"
    fill_in 'user_adress_attributes_first_name',with: "優香"
    fill_in 'user_adress_attributes_last_name_kana',with: "タカハシ"
    fill_in 'user_adress_attributes_first_name_kana',with: "ユウカ"
    fill_in 'user_adress_attributes_zip_code',with: "123-4567"
    select '秋田県', from: 'user_adress_attributes_prefecture_id'
    fill_in 'user_adress_attributes_city',with: "秋田市広面"
    fill_in 'user_adress_attributes_street',with: "123"
    fill_in 'user_adress_attributes_building',with: "ハイツコスモス"
    fill_in 'user_adress_attributes_phone_number_sub',with: "09012345678"
    find('input[name="commit"]').click
    expect(current_path).to eq user_payment_path
    find('input[name="commit"]').click
    expect(current_path).to eq registration_complete_path
  end
end