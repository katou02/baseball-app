require 'rails_helper'

RSpec.describe Api::V1::CommentForecastsController, type: :controller do
  let(:user){build(:user)}
  let(:comment_forecast){build(:comment_forecast)}
  let(:forecast){build(:forecast)}

  describe 'create' do
    context 'ログイン済み' do
      it '保存できること' do
        sign_in user
        expect {
          post :create,params: comment_forecast
          expect(response).to
        }
      end
    end
  end

  describe 'destroy' do
    context 'ログイン済み' do
      it '削除できること' do
        sign_in user
        delete :destroy,params: {id: comment_forecast.id,forecast_id: forecast.id}
      end
    end
  end
end