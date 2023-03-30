require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let(:user) { create(:user, :skip_validate) }
  let(:post) { create(:post) }
  describe "POST /create" do
    context 'when user is logged in' do
      before do
        session_params = { session: { login_id: user.login_id, password_digest: user.password_digest } }
        post '/login', params: session_params
        # sign_in user
      end

      it 'creates a like' do
        expect {
          post :create, params: { post_id: @post.id }
        }.to change(Like, :count).by(1)
      end
    end
  end
end
