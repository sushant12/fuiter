# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'Facebook' do
    context 'Success handling' do
      before do
        request.env['omniauth.auth'] = FactoryBot.create(:auth_hash, :facebook)
        get :facebook
      end

      let(:user) { User.find_by(email: 'testuser@facebook.com') }

      it 'sets current_user to proper user' do
        expect(subject.current_user).to eq(user)
      end
    end

    context 'Non-persisting User' do
      before do
        request.env['omniauth.auth'] = FactoryBot.create(
          :auth_hash, :facebook, :does_not_persist
        )
        get :facebook
      end

      it 'redirects to new user registration' do
        expect(response).to redirect_to new_user_registration_url
      end
    end
  end
end
