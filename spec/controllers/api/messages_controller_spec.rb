require 'rails_helper'

RSpec.describe Api::V1::MessagesController,type: :controller do
  let(:user){build(:user)}
  let(:message){build(:message)}

  describe 'create' do
    context 'ログイン済み' do
      it '保存できること' do
        sign_in user
        expect {
          post :create,params: message
          expect(response).to
        }
      end
    end
  end
end