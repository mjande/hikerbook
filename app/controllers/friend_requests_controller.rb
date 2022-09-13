class FriendRequestsController < ApplicationController
  def create
    @friend_request = FriendRequest.new(sender_id: current_user.id, receiver_id: params[:receiver])

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
end
