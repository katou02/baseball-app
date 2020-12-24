require 'rails_helper'

RSpec.describe Tweet, type: :model do

  describe 'アソシエーションテスト' do
      
    context 'Tweetテーブルとの関係' do
      it '1:Nとなっている' do
        t = Category.reflect_on_association(:tweets)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Analysisテーブルとの関係' do
      it '1:Nとなっている' do
        t = Category.reflect_on_association(:analyses)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Forecastテーブルとの関係' do
      it '1:Nとなっている' do
        t = Category.reflect_on_association(:forecasts)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Championテーブルとの関係' do
      it '1:Nとなっている' do
        t = Category.reflect_on_association(:champions)
        expect(t.macro).to eq(:has_many)
      end
    end
  end
end