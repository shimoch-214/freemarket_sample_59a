require 'rails_helper'
RSpec.describe Adress do
  describe '#create' do
    it "is valid with a first_name, last_name, first_name_kana, last_name_kana, zip_code, city, street, building, phone_number_sub, prefecture_id" do
      adress =build(:adress)
      adress.valid?
      expect(adress).to be_valid
    end
    it "is invalid without a first_name" do
      adress = build(:adress, first_name:nil)
      adress.valid?
      expect(adress.errors[:first_name]).to include("を入力してください")
    end
    it "is invalid without a last_name" do
      adress = build(:adress, last_name:nil)
      adress.valid?
      expect(adress.errors[:last_name]).to include("を入力してください")
    end
    it "is invalid without a first_name_kana" do
      adress = build(:adress, first_name_kana:nil)
      adress.valid?
      expect(adress.errors[:first_name_kana]).to include("を入力してください")
    end
    it "is invalid without a last_name_kana" do
      adress = build(:adress, last_name_kana:nil)
      adress.valid?
      expect(adress.errors[:last_name_kana]).to include("を入力してください")
    end
    it "is invalid with a first_name_kana that is kana" do
      adress = build(:adress, first_name_kana:"ユウカ")
      adress.valid?
      expect(adress).to be_valid
    end
    it "is invalid with a last_name_kana that is kana" do
      adress = build(:adress, last_name_kana:"タカハシ")
      adress.valid?
      expect(adress).to be_valid
    end
    it "is invalid without a first_name_kana that is Hiragana" do
      adress = build(:adress, first_name_kana:"ゆうか")
      adress.valid?
      expect(adress.errors[:first_name_kana]).to include("は不正な値です")
    end
    it "is invalid without a last_name_kana that is Hiragana" do
      adress = build(:adress, last_name_kana:"たかはし")
      adress.valid?
      expect(adress.errors[:last_name_kana]).to include("は不正な値です")
    end
    it "is invalid with format of zip-code is accurate" do
      adress = build(:adress, zip_code:"123-4567")
      adress.valid?
      expect(adress).to be_valid
    end
    it "is invalid without format of zip_code is not accurate" do
      adress = build(:adress, zip_code:"123-456789000000")
      adress.valid?
      expect(adress.errors[:zip_code]).to include("は不正な値です")
    end
    it "is invalid without a zip_code" do
      adress = build(:adress, zip_code:nil)
      adress.valid?
      expect(adress.errors[:zip_code]).to include("を入力してください")
    end
    it "is invalid without a prefecture_id" do
      adress = build(:adress, prefecture_id:nil)
      adress.valid?
      expect(adress.errors[:prefecture_id]).to include("を入力してください")
    end
    it "is invalid without a city" do
      adress = build(:adress, city:nil)
      adress.valid?
      expect(adress.errors[:city]).to include("を入力してください")
    end
    it "is invalid without a street" do
      adress = build(:adress, street:nil)
      adress.valid?
      expect(adress.errors[:street]).to include("を入力してください")
    end
  end
end