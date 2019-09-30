require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    context 'is valid' do
      it 'with a name has one character' do
        item = build(:item, name: 1)
        expect(item).to be_valid
      end
      it 'with a name has 40 characters'
      it 'with a price of 300'
      it 'with a price of 9,999,999'
      it 'with a description has one character'
      it 'with a description has 1000 character'
      it 'with any condition'
      it 'with a category which has no children'
      # it 'with a sizing when the category has sizing_id'
      # it 'without a sizing when the category does not have sizing_id'
    end

    context 'is invalid' do
      it 'without a name'
      it 'with a name has more than 40 characters'
      it 'without a price'
      it 'with a price smaller than 300'
      it 'with a price bigger than 9,999,999'
      it 'without a description'
      it 'with a description has more than 1000 characters'
      it 'without a condition'
      # it 'without a category'
      # it 'with a category which has children'
      # it 'without a sizing when the category has sizing_id'
      # it 'with a sizing when the category '
    end
  end
end