require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'バリデーションのテスト' do
    context 'bodyカラム' do
      message = Message.new(body: '')

      it '未入力だと保存できない' do
        expect(message.valid?).to eq false
      end

      it 'メッセージが未入力であればエラー' do
        message
        message.valid?
        expect(message.errors[:body]).to include('を入力してください')
      end

      it '301文字以上だと保存できない' do
        message.body = 'a' * 301
        message.valid?
        expect(message.errors).to be_added(:body, :too_long, count: 300)
      end
    end
  end

  describe 'アソシエーションのテスト' do
    
    context 'Userテーブルとの関係' do
      it 'belongs_toになっている' do
        t = Message.reflect_on_association(:user)
        expect(t.macro).to eq(:belongs_to)
      end
    end

    context 'Roomテーブルとの関係' do
      it 'belongs_toになっている' do
        t = Message.reflect_on_association(:room)
        expect(t.macro).to eq(:belongs_to)
      end
    end

    context 'Notificationテーブルとの関係' do
      it '1:Nとなっている' do
        t = Message.reflect_on_association(:notifications)
        expect(t.macro).to eq(:has_many)
      end
    end
  end
end