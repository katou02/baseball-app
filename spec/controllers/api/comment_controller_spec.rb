require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  let(:user){build(:user)}
  let(:comment){build(:comment)}
  let(:tweet){build(:tweet)}

  describe 'create' do
    context 'ログイン済み' do
      it '保存できること' do
        sign_in user
        expect {
          post :create,params: comment
          expect(response).to
        }
      end
    end
  end

  describe 'destroy' do
    context 'ログイン済み' do
      it '削除できること' do
        sign_in user
        delete :destroy,params: {id: comment.id,tweet_id: tweet.id}
      end
    end
  end
end