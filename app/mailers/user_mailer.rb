class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    delivery_options = { user_name: "vincent@stoop.nl",
                         password: "bN<k3i3H",
                         address: "web102.your-webhost.nl" }
    mail to: user.email, subject: "Account activation", delivery_method_options: delivery_options
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
