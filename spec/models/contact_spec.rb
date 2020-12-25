require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'バリデーションテスト' do
    let(:contact){build(:contact)}
    subject {contact.valid?}

    it '全て入力しているなら送信できる' do
      expect(contact).to be_valid
    end

    context 'nameカラムのテスト' do
      
      it '未入力だと送信できない' do
        contact.name = ''
        is_expected.to eq false
      end

      it '名前が未入力だとエラー' do
        contact.name = ''
        contact.valid?
        expect(contact.errors[:name]).to include('を入力してください')
      end

      it '21文字以上なら保存できない' do
        contact.name = 'a' * 21
        contact.valid?
        expect(contact.errors).to be_added(:name, :too_long, count: 20)
      end

      it '20文字以下なら保存できる' do
        contact.name = 'a' * 20
        expect(contact).to be_valid
      end
    end

    context 'emailカラムのテスト' do
      
      it '未入力だと送信できない' do
        contact.email = ''
        is_expected.to eq false
      end

      it 'メールアドレスが未入力だとエラー' do
        contact.email = ''
        contact.valid?
        expect(contact.errors[:email]).to include('を入力してください')
      end

      it '31文字以上なら保存できない' do
        contact.email = 'a' * 31
        contact.valid?
        expect(contact.errors).to be_added(:email, :too_long, count: 30)
      end

      it '30文字以下なら保存できる' do
        contact.email = 'test@gmail.com'
        expect(contact).to be_valid
      end
    end

    context 'contentカラムのテスト' do
      
      it '未入力だと送信できない' do
        contact.content = ''
        is_expected.to eq false
      end

      it 'テキストが未入力だとエラー' do
        contact.content = ''
        contact.valid?
        expect(contact.errors[:content]).to include('を入力してください')
      end

      it '1001文字以上なら保存できない' do
        contact.content = 'a' * 1001
        contact.valid?
        expect(contact.errors).to be_added(:content, :too_long, count: 1000)
      end

      it '1000文字以下なら保存できる' do
        contact.content = 'a' * 1000
        expect(contact).to be_valid
      end
    end
  end
end