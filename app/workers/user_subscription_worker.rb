  class UserSubscriptionWorker
  include Sidekiq::Worker

  def perform(user)
    UserSubscribeMailer.user_subscribe(user).deliver
  end
end
