require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'アソシエーションのテスト' do

    context 'Messageテーブルとの関係' do
      it '1:Nとなっている' do
        t = Room.reflect_on_association(:messages)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Notificationテーブルとの関係' do
      it '1:Nとなっている' do
        t = Room.reflect_on_association(:notifications)
        expect(t.macro).to eq(:has_many)
      end
    end

    context 'Entryテーブルとの関係' do
      it '1:Nとなっている' do
        t = Room.reflect_on_association(:entries)
        expect(t.macro).to eq(:has_many)
      end
    end
  end
end