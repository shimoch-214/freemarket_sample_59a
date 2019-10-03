require 'rails_helper'

RSpec.describe Transact, type: :model do
  context '#create' do
    context 'valid' do
      it "with a bearing of 'seller_side' and an assigned delivery_method" do
        transact = build(:transact, bearing: 'seller_side')
        transact.delivery_method = Transact.delivery_methods.values.sample
        expect(transact).to be_valid
      end
      it "with a bearing of 'buyer_side' and an assigned delivery_method" do
        transact = build(:transact, bearing: 'buyer_side')
        transact.delivery_method = Transact.delivery_methods_for_buyer_side.values.sample
        expect(transact).to be_valid
      end
      it 'with a prefecture_id 1 to 47' do
        transact = build(:transact, prefecture_id: rand(1..47))
        expect(transact).to be_valid
      end
      it 'with a ship_days has assigned number' do
        Transact.ship_days.length.times do |i|
          transact = build(:transact, ship_days: i)
          expect(transact).to be_valid
        end
      end
      it 'with a status 0 as default' do
        transact = build(:transact)
        expect(transact.status_before_type_cast.to_i).to eq(0)
      end
    end
    
    context 'is invalid' do
      it 'without a bearing' do
        transact = build(:transact, bearing: nil)
        transact.valid?
        expect(transact.errors[:bearing]).to include('を入力してください')
      end
      it 'without a delivery_method' do
        transact = build(:transact, delivery_method: nil)
        transact.valid?
        expect(transact.errors[:delivery_method]).to include('を入力してください')
      end
      it 'with unassigned delivery_method' do
        transact = build(:transact, bearing: 'buyer_side')
        transact.delivery_method = (Transact.delivery_methods.values-Transact.delivery_methods_for_buyer_side.values).sample
        transact.valid?
        expect(transact.errors[:delivery_method]).to include('は不正な値です')
      end
      it 'without a prefecture_id' do
        transact = build(:transact, prefecture_id: nil)
        transact.valid?
        expect(transact.errors[:prefecture]).to include('を入力してください')
      end
      it 'with a prefecture_id equal to 0' do
        transact = build(:transact, prefecture_id: 0)
        transact.valid?
        expect(transact.errors[:prefecture]).to include('を入力してください')
      end
      it 'with a prefecture_id bigger than 48' do
        transact = build(:transact, prefecture_id: 48)
        transact.valid?
        expect(transact.errors[:prefecture]).to include('を入力してください')       
      end
      it 'without a ship_days' do
        transact = build(:transact, ship_days: nil)
        transact.valid?
        expect(transact.errors[:ship_days]).to include('を入力してください')
      end
      it 'with a ship_days has value other than 0 to 2' do
        expect{ build(:transact, ship_days: 3) }
        .to raise_error(ArgumentError)
        .with_message(/is not a valid ship_days/)
      end
      it 'with status has value other than 0' do
        transact = build(:transact, status: 2)
        transact.valid?
        expect(transact.errors[:status]).to include('は不正な値です')
      end
    end
  end
end