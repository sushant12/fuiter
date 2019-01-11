# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'John' }
    email  { 'test@gmail.com' }
    provider { 'facebook' }
    category { 'normal' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :reseller, class: User do
    name { 'John' }
    email  { 'test@gmail.com' }
    provider { 'facebook' }
    category { 'reseller' }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :admin, class: User do
    name { 'John' }
    email  { 'test@gmail.com' }
    provider { 'facebook' }
    category { 'admin' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
