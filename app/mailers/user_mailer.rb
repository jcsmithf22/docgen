class UserMailer < ApplicationMailer
  def password_reset
    @user = params[:user]
    @signed_id = @user.generate_token_for(:password_reset)

    mail to: @user.email, subject: "Reset your password"
  end

  def email_verification
    @user = params[:user]
    @signed_id = @user.generate_token_for(:email_verification)

    mail to: @user.email, subject: "Verify your email"
  end

  def invitation
    @invitation = params[:invitation]
    @token = @invitation.token
    @organization = @invitation.organization.name
    mail to: @invitation.email, subject: "You have been invited to join #{@organization}"
  end
end
