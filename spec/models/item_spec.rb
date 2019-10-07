require 'rails_helper'

RSpec.describe Item, type: :model do
  context '#create' do
    context 'valid' do
      it 'with a name has one character' do
        item = build(:item, name: "a")
        expect(item).to be_valid
      end
      it 'with a name has 40 characters' do
        item = build(:item, name: "a"*40)
        expect(item).to be_valid
      end
      it 'with a price of 300' do
        item = build(:item, price: 300)
        expect(item).to be_valid
      end
      it 'with a price of 9,999,999' do
        item = build(:item, price: 9999999)
        expect(item).to be_valid
      end
      it 'with a description has one character' do
        item = build(:item, description: "a")
        expect(item).to be_valid
      end
      it 'with a description has 1000 character' do
        item = build(:item, description: "a"*1000)
        expect(item).to be_valid
      end
      it 'with a condition has assigned number' do
        Item.conditions.values.each do |i|
          item = build(:item, condition: i)
          expect(item).to be_valid
        end
      end
      it 'with a category which has no children' do
        item = build(:item)
        item.category = Category.where("ancestry Like '%/%'").sample
        expect(item).to be_valid
      end
      it 'with an assigned sizing in case the category has sizing_id' do
        item = build(:item)
        item.category = Category.where('sizing_id is not null').sample
        item.sizing = item.category.sizing.children.sample
        expect(item).to be_valid
      end
      it 'without a sizing when the category does not have sizing_id' do
        item = build(:item, sizing_id: nil)
        item.category = Category.where('sizing_id is null').where("ancestry Like '%/%'").sample
        expect(item).to be_valid
      end
    end

    context 'invalid' do
      it 'without a name' do
        item = build(:item, name: nil)
        item.valid?
        expect(item.errors[:name]).to include('は1文字以上で入力してください')
      end
      it 'with a blank name' do
        item = build(:item, name: '')
        item.valid?
        expect(item.errors[:name]).to include('は1文字以上で入力してください')
      end
      it 'with a name has more than 40 characters' do
        item = build(:item, name: "a"*41)
        item.valid?
        expect(item.errors[:name]).to include('は40文字以内で入力してください')
      end
      it 'without a price' do
        item = build(:item, price: nil)
        item.valid?
        expect(item.errors[:price]).to include('は数値で入力してください')
      end
      it 'with a blank price' do
        item = build(:item, price: '')
        item.valid?
        expect(item.errors[:price]).to include('は数値で入力してください')
      end
      it 'with a price smaller than 300' do
        item = build(:item, price: 299)
        item.valid?
        expect(item.errors[:price]).to include('は300以上の値にしてください')
      end
      it 'with a price bigger than 9,999,999' do
        item = build(:item, price: 10000000)
        item.valid?
        expect(item.errors[:price]).to include('は10000000より小さい値にしてください')
      end
      it 'without a description' do
        item = build(:item, description: nil)
        item.valid?
        expect(item.errors[:description]).to include('は1文字以上で入力してください')
      end
      it 'with a blank description' do
        item = build(:item, description: '')
        item.valid?
        expect(item.errors[:description]).to include('は1文字以上で入力してください')
      end
      it 'with a description has more than 1000 characters' do
        item = build(:item, description: "a"*1001)
        item.valid?
        expect(item.errors[:description]).to include('は1000文字以内で入力してください')
      end
      it 'without a condition' do
        item = build(:item, condition: nil)
        item.valid?
        expect(item.errors[:condition]).to include('を入力してください')
      end
      it 'with a condition has value other than 0 to 5' do
        expect{ build(:item, condition: 6) }
        .to raise_error(ArgumentError)
        .with_message(/is not a valid condition/)
      end
      it 'without a category' do
        item = build(:item, category_id: nil)
        item.valid?
        expect(item.errors[:category_id]).to include('を入力してください')
      end
      it 'with a category which has children' do
        item = build(:item)
        item.category = Category.where.not("ancestry Like '%/%'").where.not("name Like 'その他' or 'オートバイ車体'").sample
        item.valid?
        expect(item.errors[:category_id]).to include('は不正な値です')
      end
      it 'without a sizing when the category has sizing_id' do
        item = build(:item, sizing_id: nil)
        item.category = Category.where.not("sizing_id is null").sample
        item.valid?
        expect(item.errors[:sizing_id]).to include('は不正な値です')
      end
      it 'with an unassigned sizing in case the category has sizing_id' do
        item = build(:item)
        item.category = Category.where.not("sizing_id is null").sample
        item.sizing = Sizing.find(Sizing.roots.map{|ele| ele.id}.select{|ele| ele != item.category.sizing.id}.sample)
        item.valid?
        expect(item.errors[:sizing_id]).to include('は不正な値です')
      end
      it 'without transact' do
        item = build(:item)
        item.transact = nil
        item.valid?
        expect(item.errors[:transact]).to include('を入力してください')
      end
      it 'without images' do
        item = build(:item)
        item.images = []
        item.valid?
        expect(item.errors[:images]).to include('画像が投稿されていません')
      end
    end
  end
end