require 'rails_helper'

RSpec.describe "Likes", type: :request do
  # ダミーデータを定義
  let(:user) { create(:user, :skip_validate) }
  let(:test_post) { create(:post) }
  let(:like) { create(:like, user: user, post: test_post) }

  before do
    # ログイン処理（user.passwordは仮想フィールド）
    post login_path, params: {
      session: {
        login_id: user.login_id,
        password: user.password
      }
    }
  end

  # いいねするとき
  describe "#create" do
    # 正常系
    context 'normal case' do
      # いいねができること
      it 'being able to like' do
        expect do
          post gourmet_post_likes_path(test_post.id), params: {}, xhr: true
        end.to change(Like, :count).by(1)
      end
    end

    # 異常系
    context 'abnormal case' do
      # ログインしていない場合、ログイン画面にリダイレクトされること
      it 'redirection to the login page if not logged in' do
        delete logout_path
        post gourmet_post_likes_path(test_post.id), params: {}, xhr: true
        # リダイレクト先がログイン画面であること
        # MEMO: XMLHttpRequestはリダイレクトでもステータスコード200を返すことがある
        expect(response).to redirect_to login_path
      end

      # 存在しない投稿にたいしていいねをした場合、エラーになること
      it 'error when liking a post that does not exist' do
        expect do
          # 存在しない投稿ID: 0
          post gourmet_post_likes_path(0), params: {}, xhr: true
        end.to raise_error ActiveRecord::RecordNotFound
      end

      # 存在しているいいねに対していいねをした場合、エラーになること
      it 'error when liking for a like that exists' do
        # 複合ユニークキー制約は spec/models/like_spec.rb で検証しています
        skip 'Composite unique key constraints are verified in spec/models/like_spec.rb'
      end
    end
  end

  # いいね解除するとき
  describe "#destroy" do
    before do
      # いいね（とユーザーと投稿）を予め登録しておく
      like
    end

    # 正常系
    context 'normal case' do
      # いいねが解除できること（いいねは物理削除）
      it 'the ability to cancel a like' do
        expect do
          delete gourmet_post_likes_path(test_post.id), params: {}, xhr: true
        end.to change(Like, :count).by(-1)
      end
    end

    # 異常系
    context 'abnormal case' do
      # ログインしていない場合、ログイン画面にリダイレクトされること
      it 'redirection to the login page if not logged in' do
        delete logout_path
        delete gourmet_post_likes_path(test_post.id), params: {}, xhr: true
        expect(response).to redirect_to login_path
      end

      # 存在しない投稿に対していいねを解除した場合、エラーになること
      it 'unliking a post that does not exist should result in an error' do
        expect do
          delete gourmet_post_likes_path(0), params: {}, xhr: true
        end.to raise_error ActiveRecord::RecordNotFound
      end

      # 存在しないいいねに対していいねを解除した場合、エラーになること
      it 'unliking a non-existent like should result in an error' do
        expect do
          like.destroy
          delete gourmet_post_likes_path(test_post.id), params: {}, xhr: true
        end.to raise_error NoMethodError
      end
    end
  end
end
