require 'rails_helper'

describe User do
  let(:nickname) { 'テスト太郎' }
  let(:email) { 'test@example.com' }
  let(:password) { '12345678' }
  let(:user) { User.new(nickname:, email:, password:, password_confirmation: password) }

  describe '.first' do
    before do
      create(:user, nickname:, email:)
    end

    subject { described_class.first }

    it '事前に作成した通りのUserを返す' do
      expect(subject.nickname).to eq('テスト太郎')
      expect(subject.email).to eq('test@example.com')
    end
  end

  describe 'validation' do
    describe 'nickname属性' do
      describe '正常系' do
        context 'nicknameが20文字以下の場合' do
          let(:nickname) { 'あいうえおかきくけこさしすせそたちつてと' } # 20文字

          it 'User オブジェクトは有効である' do
            expect(user.valid?).to be(true)
          end
        end

        describe '異常系' do
          context 'nicknameが20文字を超える場合' do
            let(:nickname) { 'あいうえおかきくけこさしすせそたちつてとな' } # 21文字

            it 'User オブジェクトは無効である' do
              user.valid?

              expect(user.valid?).to be(false)
              expect(user.errors[:nickname]).to include('is too long (maximum is 20 characters)')
            end
          end
          context 'nicknameが空欄の場合' do
            let(:nickname) { '' }
            it 'User オブジェクトは有効である' do
              expect(user.valid?).to be(false)
              expect(user.errors[:nickname]).to include("can't be blank")
            end
          end
        end
      end
    end
  end
end
