require 'rails_helper'
RSpec.describe SnsConfirmation do
  describe '#create' do
    context 'is valid' do
      it 'with a provider either facebook or google_oauth2' do
        sns_confirmation = build(:sns_confirmation)
        expect(sns_confirmation).to be_valid
      end
      it 'with a uid' do
        sns_confirmation = build(:sns_confirmation)
        expect(sns_confirmation).to be_valid
      end
      it 'with a email' do
        sns_confirmation = build(:sns_confirmation)
        expect(sns_confirmation).to be_valid
      end
      it 'with same uids if thier providers are different' do
        sns_confirmation = create(:sns_confirmation, provider: 'facebook')
        duplicated_uid = build(:sns_confirmation, uid: sns_confirmation.uid, provider: 'google_oauth2')
        expect(duplicated_uid).to be_valid
      end
      it 'with same providers if thier uids are different' do
        sns_confirmation = create(:sns_confirmation, provider: 'facebook')
        duplicated_provider = build(:sns_confirmation, provider: 'facebook')
        expect(duplicated_provider).to be_valid
      end
    end

    context 'is invalid' do
      it 'without a provider' do
        sns_confirmation = build(:sns_confirmation, provider: nil)
        sns_confirmation.valid?
        expect(sns_confirmation.errors[:provider]).to include('を入力してください')
      end
      it 'with a provider other than facebook or google_oauth2' do
        sns_confirmation = build(:sns_confirmation, provider: 'TECH::EXPERT')
        sns_confirmation.valid?
        expect(sns_confirmation.errors[:provider]).to include('は一覧にありません')
      end
      it 'without a uid' do
        sns_confirmation = build(:sns_confirmation, uid: nil)
        sns_confirmation.valid?
        expect(sns_confirmation.errors[:uid]).to include('を入力してください')
      end
      it 'without a email' do
        sns_confirmation = build(:sns_confirmation, email: nil)
        sns_confirmation.valid?
        expect(sns_confirmation.errors[:email]).to include('を入力してください')
      end
      it 'with a duplicated set of provider and uid' do
        sns_confirmation = create(:sns_confirmation)
        duplicated = build(:sns_confirmation, uid: sns_confirmation.uid, provider: sns_confirmation.provider)
        duplicated.valid?
        expect(duplicated.errors[:uid]).to include('はすでに存在します')
      end
      it 'without a user' do
        sns_confirmation = build(:sns_confirmation, user: nil)
        sns_confirmation.valid?
        expect(sns_confirmation.errors[:user]).to include('を入力してください')
      end
    end
  end
end