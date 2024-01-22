require 'rails_helper'

describe Post do
  # 共通データの作成
  let(:user) { create(:user) }
  let(:title) { 'テストタイトル' }
  let(:content) { 'テスト本文' }
  let(:user_id) { user.id }

  # 【対象テストの切り出し】
  describe 'バリデーション' do
    let(:post) { build(:post, title:, content:, user_id:) }
    # 【条件】
    context '正常系' do
      # 【条件ごとの必要なデータ】
      # 【期待する結果】
      it '有効である' do
        expect(post.valid?).to be(true)
      end
    end
    # 【条件】
    context '異常系' do
      context 'title が空の場合' do
        # 【条件ごとの必要なデータ】
        let(:title) { nil }
        # 【期待する結果】
        it '無効である' do
          expect(post.valid?).to be(false)
          expect(post.errors[:title]).to include('が入力されていません。')
        end
      end
      context 'title が 100 文字を超える場合' do
        let(:title) { 'a' * 101 }
        it '無効である' do
          expect(post.valid?).to be(false)
        end
      end
      context 'content が空の場合' do
        let(:content) { nil }
        it '無効である' do
          expect(post.valid?).to be(false)
        end
      end
      context 'content が 1000 文字を超える場合' do
        let(:content) { 'a' * 1001 }
        it '無効である' do
          expect(post.valid?).to be(false)
        end
      end
      context 'user_idが空の場合' do
        let(:user_id) { '' }
        it '無効である' do
          expect(post.valid?).to be(false)
        end
      end
    end
  end
  describe 'データの検証' do
    before { create(:post, title:, content:, user_id:) }

    subject { described_class.first }

    it 'Postの属性を返す' do
      expect(subject.title).to eq('テストタイトル')
      expect(subject.content).to eq('テスト本文')
      expect(subject.user_id).to eq(user.id)
    end
  end
end
