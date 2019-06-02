class UserSubscribeMailer < ApplicationMailer
  default :from => 'contact@grasruts.com'

    # send a signup email to the user, pass in the user object that   contains the user's email address
    def user_subscribe(user)
      @user = user
      mail( :to => @user.email,
      :subject => 'Thanks for subscribing.' )
    end
end
