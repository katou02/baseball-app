require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'アソシエーションのテスト' do

    context 'Tweetテーブルとの関係' do
      it 'belongs_toになっている' do
        t = Notification.reflect_on_association(:tweet)
        expect(t.macro).to eq(:belongs_to)
      end
    end

    context 'Analysisテーブルとの関係' do
      it 'belongs_toになっている' do
        t = Notification.reflect_on_association(:analysis)
        expect(t.macro).to eq(:belongs_to)
      end
    end

    context 'Forecastテーブルとの関係' do
      it 'belongs_toになっている' do
        t = Notification.reflect_on_association(:forecast)
        expect(t.macro).to eq(:belongs_to)
      end
    end

    context 'Commentテーブルとの関係' do
      it 'belongs_toになっている' do
        t = Notification.reflect_on_association(:comment)
        expect(t.macro).to eq(:belongs_to)
      end
    end

    context 'ComentAnalysisテーブルとの関係' do
      it 'belongs_toになっている' do
        t = Notification.reflect_on_association(:comment_analysis)
        expect(t.macro).to eq(:belongs_to)
      end
    end

    context 'CommentForecastテーブルとの関係' do
      it 'belongs_toになっている' do
        t = Notification.reflect_on_association(:comment_forecast)
        expect(t.macro).to eq(:belongs_to)
      end
    end

    context 'Roomテーブルとの関係' do
      it 'belongs_toになっている' do
        t = Notification.reflect_on_association(:room)
        expect(t.macro).to eq(:belongs_to)
      end
    end

    context 'Messageテーブルとの関係' do
      it 'belongs_toになっている' do
        t = Notification.reflect_on_association(:message)
        expect(t.macro).to eq(:belongs_to)
      end
    end
  end
end