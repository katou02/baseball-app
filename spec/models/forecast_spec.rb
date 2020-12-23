require 'rails_helper'

RSpec.describe Forecast, type: :model do
  describe 'バリデーションテスト' do
    let(:forecast){build(:forecast)}
    subject {forecast.valid?}

    it '全て入力していれば保存できる' do
      expect(forecast).to be_valid
    end

    context 'textカラム' do
      it '未入力だと保存できない' do
        forecast.text = ''
        is_expected.to eq false
      end

      it 'テキストが未入力であればエラー' do
        forecast.text = ''
        forecast.valid?
        expect(forecast.errors[:text]).to include('を入力してください')
      end

      it '2001文字以上なら保存できない' do
        forecast.text = 'a' * 2001
        forecast.valid?
        expect(forecast.errors).to be_added(:text, :too_long, count: 2000)
      end

      it '2000文字以下なら保存できる' do
        forecast.text = 'a' * 2000
        expect(forecast).to be_valid
      end
    end

    context 'roundカラム' do 
      it '未入力だと保存されない' do
        forecast.round = ''
        is_expected.to eq false
      end

      it 'roundが入力されてないとエラー' do
        forecast.round = ''
        forecast.valid?
        expect(forecast.errors[:round]).to include('を入力してください')
      end

      context 'probabilityカラム' do
      
        it '未入力だと保存されない' do
          forecast.probability = ''
          is_expected.to eq false
        end
  
        it 'probabilityが入力されてないとエラー' do
          forecast.probability = ''
          forecast.valid?
          expect(forecast.errors[:probability]).to include('を入力してください')
        end
      end

      context 'win_schoolカラム' do
      
        it '未入力だと保存できない' do
          forecast.win_school_id = ''
          is_expected.to eq false
        end
  
        it '勝利予想が未入力だとエラー' do
          forecast.win_school_id = ''
          forecast.valid?
          expect(forecast.errors[:win_school]).to include('を入力してください')
        end
  
        it '存在しない外部キーなら保存できない' do
          forecast.win_school_id = 6
          is_expected.to eq false
        end
  
        it '外部キーが存在するなら保存できる' do
          forecast.win_school_id = 1
          expect(forecast).to be_valid
        end
      end

      context 'lose_schoolカラム' do
      
        it '未入力だと保存できない' do
          forecast.lose_school_id = ''
          is_expected.to eq false
        end
  
        it '敗退予想が未入力だとエラー' do
          forecast.lose_school_id = ''
          forecast.valid?
          expect(forecast.errors[:lose_school]).to include('を入力してください')
        end
  
        it '存在しない外部キーなら保存できない' do
          forecast.lose_school_id = 6
          is_expected.to eq false
        end
  
        it '外部キーが存在するなら保存できる' do
          forecast.lose_school_id = 2
          expect(forecast).to be_valid
        end
      end

      context 'tournamentカラム' do
      
        it '未入力なら保存できない' do
          forecast.tournament_id = ''
          is_expected.to eq false
        end
  
        it '大会が未入力ならエラー' do
          forecast.tournament_id = ''
          forecast.valid?
          expect(forecast.errors[:tournament]).to include('を入力してください')
        end
  
        it '存在しない外部キーなら保存できない' do
          forecast.tournament_id = 2
          is_expected.to eq false
        end
  
        it '外部キーが存在するなら保存できる' do
          forecast.tournament_id = 3
          expect(forecast).to be_valid
        end
      end

      context 'userカラム' do
        it '空なら保存できない' do
          forecast.user_id = ''
          is_expected.to eq false
        end
  
        it 'ユーザーが空ならエラー' do
          forecast.user_id = ''
          forecast.valid?
          expect(forecast.errors[:user]).to include('を入力してください')
        end
      end
    end
  end

  describe 'アソシエーションテスト' do

    context 'Categoryテーブルとの関係' do
      it '1:Nとなっている' do
        t = Forecast.reflect_on_association(:categories)
        expect(t.macro).to eq(:has_many)     
      end
    end

    context 'CommentForecastテーブルとの関係' do
      it '1:Nとなっている' do
        t = Forecast.reflect_on_association(:comment_forecasts)
        expect(t.macro).to eq(:has_many)     
      end
    end

    context 'Notificationテーブルとの関係' do
      it '1:Nとなっている' do
        t = Forecast.reflect_on_association(:notifications)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Userモデルとの関係' do
      it '1:Nにとなっている' do
        t = Forecast.reflect_on_association(:user)
        expect(t.macro).to eq(:belongs_to)
      end
    end
  end
end