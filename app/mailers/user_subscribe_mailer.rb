class UserSubscribeMailer < ApplicationMailer
  default :from => Rails.application.credentials.sender_email

    # send a signup email to the user, pass in the user object that   contains the user's email address
    def user_subscribe(email)
      mail( :to => email,
      :subject => 'Thanks for subscribing.' )
    end
end
