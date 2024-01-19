class InvitationsController < ApplicationController
  include ApplicationHelper
  before_action :admin?

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    if user_already_exists?
      flash.now[:alert] = "That user already exists"
      render :new, status: :unprocessable_entity
    elsif @invitation.save
      send_email_invite
      redirect_to root_path, notice: "Invitation sent successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @invitations = Invitation.where(organization_id: Current.user.organization_id)
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :token).merge(organization_id: Current.user.organization.id)
  end

  def send_email_invite
    UserMailer.with(invitation: @invitation).invitation.deliver_later
  end

  def user_already_exists?
    User.find_by(email: @invitation.email, organization_id: @invitation.organization_id)
  end
end
