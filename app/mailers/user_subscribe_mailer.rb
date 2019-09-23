# frozen_string_literal: true

class UserSubscribeMailer < ApplicationMailer
  default from: Fuitter.credentials[:sender_email]

  def new_user_subscription(email)
    mail(to: email,
         subject: 'Thanks for subscribing.')
  end

  def remove_user_subscription(email)
    mail(to: email,
         subject: 'Your subscription has been canceled.')
  end

  def failed_renewing_subscription(email)
    mail(to: email,
         subject: 'Subscription Renewal failed. Looks like we are not able to charge your card')
  end
end
