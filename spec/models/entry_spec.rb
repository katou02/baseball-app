require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe 'アソシエーションテスト' do
    
    context 'Userテーブルとの関係' do
      it 'belongs_toになっている' do
        t = Entry.reflect_on_association(:user)
        expect(t.macro).to eq(:belongs_to)
      end
    end

    context 'Roomテーブルとの関係' do
      it 'belongs_toになっている' do
        t = Entry.reflect_on_association(:room)
        expect(t.macro).to eq(:belongs_to)
      end
    end
  end
end