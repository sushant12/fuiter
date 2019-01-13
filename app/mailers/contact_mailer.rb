class ContactMailer < ApplicationMailer
  def notify_user(user_query)
    @name = user_query[:name]
    mail to: user_query[:email], subject: "Fuitter: Contact Us Confirmation"
  end

  def notify_admin(user_query)
    @user_query = user_query
    mail(to: 'contact@grasruts.com', subject: 'Fuitter: Contact Us Notification')
  end
end
