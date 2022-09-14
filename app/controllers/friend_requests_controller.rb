class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: :create

  def create
    if @friend_request.save
      respond_to do |format|
        format.html { redirect_to users_path, notice: "Your friend request was sent!" }
        format.turbo_stream { redirect_to users_path, notice: "Your friend request was sent!" }
      end
    else
      flash.now[:alert] = 'Something went wrong'
      
      @users = User.all
      render template: 'users/index', status: :unprocessable_entity
    end
  end

  def set_friend_request
    @friend_request = FriendRequest.new(sender_id: current_user.id, receiver_id: params[:receiver])
  end
end
