require 'rails_helper'
RSpec.describe Address do
  describe '#create' do
    it "is valid with a first_name, last_name, first_name_kana, last_name_kana, zip_code, city, street, building, phone_number_sub, prefecture_id" do
      address =build(:address)
      address.valid?
      expect(address).to be_valid
    end
    it "is invalid without a first_name" do
      address = build(:address, first_name:nil)
      address.valid?
      expect(address.errors[:first_name]).to include("を入力してください")
    end
    it "is invalid without a last_name" do
      address = build(:address, last_name:nil)
      address.valid?
      expect(address.errors[:last_name]).to include("を入力してください")
    end
    it "is invalid without a first_name_kana" do
      address = build(:address, first_name_kana:nil)
      address.valid?
      expect(address.errors[:first_name_kana]).to include("を入力してください")
    end
    it "is invalid without a last_name_kana" do
      address = build(:address, last_name_kana:nil)
      address.valid?
      expect(address.errors[:last_name_kana]).to include("を入力してください")
    end
    it "is invalid with a first_name_kana that is kana" do
      address = build(:address, first_name_kana:"ユウカ")
      address.valid?
      expect(address).to be_valid
    end
    it "is invalid with a last_name_kana that is kana" do
      address = build(:address, last_name_kana:"タカハシ")
      address.valid?
      expect(address).to be_valid
    end
    it "is invalid without a first_name_kana that is Hiragana" do
      address = build(:address, first_name_kana:"ゆうか")
      address.valid?
      expect(address.errors[:first_name_kana]).to include("は不正な値です")
    end
    it "is invalid without a last_name_kana that is Hiragana" do
      address = build(:address, last_name_kana:"たかはし")
      address.valid?
      expect(address.errors[:last_name_kana]).to include("は不正な値です")
    end
    it "is invalid with format of zip-code is accurate" do
      address = build(:address, zip_code:"123-4567")
      address.valid?
      expect(address).to be_valid
    end
    it "is invalid without format of zip_code is not accurate" do
      address = build(:address, zip_code:"123-456789000000")
      address.valid?
      expect(address.errors[:zip_code]).to include("は不正な値です")
    end
    it "is invalid without a zip_code" do
      address = build(:address, zip_code:nil)
      address.valid?
      expect(address.errors[:zip_code]).to include("を入力してください")
    end
    it "is invalid without a prefecture_id" do
      address = build(:address, prefecture_id:nil)
      address.valid?
      expect(address.errors[:prefecture_id]).to include("を入力してください")
    end
    it "is invalid without a city" do
      address = build(:address, city:nil)
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end
    it "is invalid without a street" do
      address = build(:address, street:nil)
      address.valid?
      expect(address.errors[:street]).to include("を入力してください")
    end
  end
end