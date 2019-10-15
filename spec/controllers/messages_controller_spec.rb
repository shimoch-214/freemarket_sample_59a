require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:item)         { create(:item) }
  let(:transact)     { create(:transact) }
  let(:user)         { create(:user) }
  let(:another_user1) { create(:user) }
  let(:another_user2) { create(:user) }

  describe 'POST #create' do
    let(:valid_params) {{
      message: {
        text: 'hogehoge'
      },
      transact_id: transact.id
    }}
    let(:invalid_params) {{
      message: {
        text: ''
      },
      transact_id: transact.id
    }}

    context 'when the user signed in' do
      before do
        sign_in user
      end
      context 'then he is the member of the transaction' do
        before do
          transact.seller = user
          transact.buyer = another_user1
          transact.save
        end
        subject(:subject_valid_params) {
          post :create, params: valid_params
        }
        subject(:subject_invalid_params) {
          post :create, params: invalid_params

        }
        it 'creates a message with a valid params' do
          expect {
            subject_valid_params
          }.to change(Message, :count).by(1)
        end
        it 'redirects to the transact_path with a valid params' do
          subject_valid_params
          expect(response).to redirect_to(transact_path(assigns(:transact)))
        end
        it 'does not create a message with a invalid params' do
          expect {
            subject_invalid_params
          }.to change(Message, :count).by(0)
        end
        it 'renders the transacts/show view with a invalid params' do
          subject_invalid_params
          expect(response).to render_template 'transacts/show'
        end
      end
      context 'then he is not the member of the transaction' do
        before do
          transact.seller = another_user1
          transact.buyer = another_user2
          transact.save
        end
        it 'redirect to the root_path' do
          post :create, params: valid_params
          expect(response).to redirect_to root_path
        end
      end
    end
    context 'when the user does not signed in' do
      it 'redirects to the user_sessions_new_path' do
        post :create, params: valid_params
        expect(response).to redirect_to user_sessions_new_path
      end
    end
  end
end