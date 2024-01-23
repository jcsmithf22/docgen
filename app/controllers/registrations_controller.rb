class RegistrationsController < ApplicationController
  skip_before_action :authenticate
  before_action :set_invitation, only: %i[ new create ]

  def new
    @user = User.new(email: @invitation.email, organization_id: @invitation.organization_id)
  end

  def create
    @user = User.new(user_params)

    if @user.save

      @invitation.update_attribute(:accepted, true)
      session_record = @user.sessions.create!
      cookies.signed.permanent[:session_token] = { value: session_record.id, httponly: true }

      send_email_verification
      redirect_to root_path, notice: "Welcome! You have signed up successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_invitation
    if (@invitation = Invitation.includes(:organization).find_by(token: params[:token]))
      if @invitation.accepted
        redirect_to root_path, alert: "That invitation has already been accepted"
      end
      @organization = @invitation.organization
    else
      redirect_to root_path, alert: "That invitation is invalid"
    end
  end

  def user_params
    params.permit(:email, :password, :password_confirmation, :first_name, :last_name, :organization_id).merge(role: "member")
  end

  def send_email_verification
    UserMailer.with(user: @user).email_verification.deliver_later
  end
end
