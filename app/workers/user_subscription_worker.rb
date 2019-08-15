  class UserSubscriptionWorker
  include Sidekiq::Worker

  def perform(email, type)
    case type
    when 'new_subscription'
      UserSubscribeMailer.new_user_subscription(email).deliver
    when 'remove_subscription'
      UserSubscribeMailer.remove_user_subscription(email).deliver
    when 'failed_renewing_subscription'
      UserSubscribeMailer.failed_renewing_subscription(email).deliver
    else
    end
  end
end
