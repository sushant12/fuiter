# frozen_string_literal: true

FactoryBot.define do
  factory :auth_hash, class: OmniAuth::AuthHash do
    initialize_with do
      OmniAuth::AuthHash.new(
        provider: provider,
        uid: uid,
        info: {
          email: email
        },
        credentials: {
          token: 'testtoken234tsdf'
        }
      )
    end

    trait :facebook do
      provider { 'facebook' }
      sequence(:uid)
      email { 'testuser@facebook.com' }
    end

    trait :does_not_persist do
      email { '' }
    end
  end
end
