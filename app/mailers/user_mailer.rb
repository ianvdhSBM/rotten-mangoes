class UserMailer < ActionMailer::Base
  default from: "from@rottenmangoes.com"
  layout false

  def delete_user(user)
    @user = user
    # @url = ''
    mail(to: @user.email, subject: 'Your user account has been deleted')
  end

end
