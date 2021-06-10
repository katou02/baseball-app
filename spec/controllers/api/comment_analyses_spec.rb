require 'rails_helper'

RSpec.describe Api::V1::CommentAnalysesController, type: :controller do
  let(:user){build(:user)}
  let(:comment_analysis){build(:comment_analysis)}
  let(:analysis){build(:analysis)}

  describe 'create' do
    context 'ログイン済み' do
      it '保存できること' do
        sign_in user
        expect {
          post :create,params: comment_analysis
          expect(response).to
        }
      end
    end
  end

  describe 'destroy' do
    context 'ログイン済み' do
      it '削除できること' do
        sign_in user
        delete :destroy,params: {id: comment_analysis.id,analysis_id: analysis.id}
      end
    end
  end
end