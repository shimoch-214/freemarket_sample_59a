require 'rails_helper'
RSpec.describe Identification do
  describe '#create' do
    it "is valid with a first_name, last_name, first_name_kana, last_name_kana, birthday" do
      identification =build(:identification)
      identification.valid?
      expect(identification).to be_valid
    end
    it "is invalid without a first_name" do
      identification = build(:identification, first_name:nil)
      identification.valid?
      expect(identification.errors[:first_name]).to include("を入力してください")
    end
    it "is invalid without a last_name" do
      identification = build(:identification, last_name:nil)
      identification.valid?
      expect(identification.errors[:last_name]).to include("を入力してください")
    end
    it "is invalid without a first_name_kana" do
      identification = build(:identification, first_name_kana:nil)
      identification.valid?
      expect(identification.errors[:first_name_kana]).to include("を入力してください")
    end
    it "is invalid without a last_name_kana" do
      identification = build(:identification, last_name_kana:nil)
      identification.valid?
      expect(identification.errors[:last_name_kana]).to include("を入力してください")
    end
    it "is invalid with a first_name_kana that is kana" do
      identification = build(:identification, first_name_kana:"ユウカ")
      identification.valid?
      expect(identification).to be_valid
    end
    it "is invalid with a last_name_kana that is kana" do
      identification = build(:identification, last_name_kana:"タカハシ")
      identification.valid?
      expect(identification).to be_valid
    end
    it "is invalid without a first_name_kana that is Hiragana" do
      identification = build(:identification, first_name_kana:"ゆうか")
      identification.valid?
      expect(identification.errors[:first_name_kana]).to include("は不正な値です")
    end
    it "is invalid without a last_name_kana that is Hiragana" do
      identification = build(:identification, last_name_kana:"たかはし")
      identification.valid?
      expect(identification.errors[:last_name_kana]).to include("は不正な値です")
    end
    it "is invalid with format of zip-code is accurate" do
      identification = build(:identification, zip_code:"123-4567")
      identification.valid?
      expect(identification).to be_valid
    end
    it "is invalid without format of zip_code is not accurate" do
      identification = build(:identification, zip_code:"123-456789000000")
      identification.valid?
      expect(identification.errors[:zip_code]).to include("は不正な値です")
    end
    it "is invalid without a birthday" do
      identification = build(:identification, birthday:nil)
      identification.valid?
      expect(identification.errors[:birthday]).to include("を入力してください")
    end
  end
end
