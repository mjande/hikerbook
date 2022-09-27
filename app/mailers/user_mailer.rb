class UserMailer < ApplicationMailer
  default from: 'welcome@hikerbook.com'

  def welcome_email
    @user = params[:user]
    @url = 'https://radiant-crag-76822.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to HikerBook')
  end
end
