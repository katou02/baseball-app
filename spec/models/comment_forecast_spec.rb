require 'rails_helper'

RSpec.describe CommentForecast, type: :model do
  describe 'バリデーションのテスト' do
    let(:comment_fcs){build(:comment_forecast)}
    subject { comment_fcs.valid? }

    it '全て入力していれば保存できる' do
      expect(comment_fcs).to be_valid
    end

    context 'textカラム' do

      it '未入力だと保存できない' do
        comment_fcs.text = ''
        is_expected.to eq false
      end

      it 'テキストが未入力であればエラー' do
        comment_fcs.text = ''
        comment_fcs.valid?
        expect(comment_fcs.errors[:text]).to include('を入力してください')
      end

      it '300文字以上だと保存できない' do
        comment_fcs.text = 'a' * 301
        comment_fcs.valid?
        expect(comment_fcs.errors).to be_added(:text, :too_long, count: 300)
      end

      it '300文字以下なら保存できる' do
        comment_fcs.text = 'a' * 300
        expect(comment_fcs).to be_valid
      end
    end

    context 'userカラム' do
      it '空なら保存できない' do
        comment_fcs.user_id = ''
        is_expected.to eq false
      end

      it 'ユーザーが空ならエラー' do
        comment_fcs.user_id = ''
        comment_fcs.valid?
        expect(comment_fcs.errors[:user]).to include('を入力してください')
      end
    end

    context 'forecastカラム' do
      it '空なら保存できない' do
        comment_fcs.forecast_id = ''
        is_expected.to eq false
      end

      it 'forecast_idが空ならエラー' do
        comment_fcs.forecast_id = ''
        comment_fcs.valid?
        expect(comment_fcs.errors[:forecast]).to include('を入力してください')
      end
    end
  end

  describe 'アソシエーションのテスト' do
    
    context 'Forecastテーブルとの関係' do
      it '1:Nとなっている' do
        t = CommentForecast.reflect_on_association(:forecast)
        expect(t.macro).to eq(:belongs_to)
      end
    end

    context 'Userテーブルとの関係' do
      it '1:Nとなっている' do
        t = CommentForecast.reflect_on_association(:user)
        expect(t.macro).to eq(:belongs_to)
      end
    end
  end
end