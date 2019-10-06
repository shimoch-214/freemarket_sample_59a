require 'rails_helper'
RSpec.describe User do
  describe '#create' do
    it "is valid with a nickname, email, password, password_confirmation,phone_number,profile" do
      user =build(:user)
      user.valid?
      expect(user).to be_valid
    end
    it "is invalid without a nickname" do
      user = build(:user, nickname:nil)
      user.valid?
      expect(user.errors[:nickname]).to include("は1文字以上で入力してください")
    end
    it "is valid with a nickname that has less than 20 characters " do
      user = build(:user, nickname: "aaaaaaaaaaaaaaaaaaaa")
      expect(user).to be_valid
    end
    it "is invalid without a nickname that has more than 21 characters " do
      user = build(:user,nickname:"aaaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user.errors[:nickname][0]).to include("は20文字以内で入力してください")
    end
    it "is valid with a nickname that has more than 1 characters " do
      user= build(:user,nickname:"a")
      user.valid?
      expect(user).to be_valid
    end
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end
    it "is valid with a password that has less than 7 characters " do
      user= build(:user,nickname:"aaaaaaa")
      user.valid?
      expect(user).to be_valid
    end
    it "is invalid without a password that has less than 6 characters " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password][0]).to include("は7文字以上で入力してください")
    end
    it "is valid with a password that has less than 128 characters " do
      user= build(:user,password:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",password_confirmation:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user).to be_valid
    end
    it "is invalid without a password that has more than 129 characters " do
      user = build(:user,password:"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user.errors[:password][0]).to include("は128文字以内で入力してください")
    end
    it "is invalid without a password_confirmation although a password exist" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
    it "is invalid without password_confirmation that is diffenret from password" do
    user = build(:user, password:"aaaaaaa",password_confirmation:"bbbbbbb")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end
    it "is invalid with password_confirmation correspond to password" do
      user = build(:user, password:"aaaaaaa",password_confirmation:"aaaaaaa")
      user.valid?
      expect(user).to be_valid
    end
    it "is invalid without a email" do
      user = build(:user, email:nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end 
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end
    it "is invalid with format of email is accurate" do
      user = build(:user, email:"aaa@gmail.com")
      user.valid?
      expect(user).to be_valid
    end
    it "is invalid without format of email is not accurate" do
      user = build(:user, email:"aaaaaaa")
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end
    it "is valid with a phone_number that has less than 11 characters " do
      user = build(:user, phone_number: "09012345678")
      expect(user).to be_valid
    end
    it "is invalid without a phone_number that has more than 12 characters " do
      user = build(:user,phone_number:"090123456789")
      user.valid?
      expect(user.errors[:phone_number][0]).to include("は不正な値です")
    end
    it "is invalid without a phone_number that has less than 10 characters " do
      user = build(:user, phone_number:"0901234567")
      user.valid?
      expect(user.errors[:phone_number][0]).to include("は不正な値です")
    end
    it "is invalid without a duplicate phone_number " do
      user = create(:user)
      another_user = build(:user, phone_number: user.phone_number)
      another_user.valid?
      expect(another_user.errors[:phone_number]).to include("はすでに存在します")
    end
    it "is invalid with format of phone_number is accurate" do
      user = build(:user, phone_number:"09012345678")
      user.valid?
      expect(user).to be_valid
    end
    it "is invalid without format of phone_number is not accurate" do
      user = build(:user, phone_number:"12345678")
      user.valid?
      expect(user.errors[:phone_number]).to include("は不正な値です")
    end
    
end
end
# RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
