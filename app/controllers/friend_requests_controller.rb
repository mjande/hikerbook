class FriendRequestsController < ApplicationController
  def create
    @friend_request = FriendRequest.new(friend_request_params)
    # debugger
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

  private

  def friend_request_params
    params.require(:friend_request).permit(:sender_id, :potential_friend_id)
  end
end
