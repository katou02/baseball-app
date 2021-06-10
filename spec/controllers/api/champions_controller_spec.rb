require 'rails_helper'

RSpec.describe Api::V1::ChampionsController,type: :controller do
#   let(:user){build(:user)}
#   let(:champion){build(:champion)}
  before do
    @user = create(:user)
    allow(controller)
    .to receive(:current_user)
    .and_return(@user)
    @champion = create(:champion,user_id: @user.id)
  end

  describe 'show' do
    it "正常なレスポンスを返す" do
      get :show,params: {id: @champion.id}
      expect(response).to be_success
    end

    it 'レスポンコード200を返す' do
      get :show,params: {id: @champion.id}
      expect(response).to have_http_status '200'
    end
  end

  describe 'create' do
    context 'ログイン済み' do
      it '保存できること' do
        sign_in @user
        expect {
          post :create,params: @champion
          expect(response).to
        }
      end
    end
  end
end