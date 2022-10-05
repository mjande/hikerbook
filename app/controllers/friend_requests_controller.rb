# frozen_string_literal: true

# The FriendRequestsController handles the REST actions for the FriendRequest model.
class FriendRequestsController < ApplicationController
  before_action :build_friend_request, only: :create
  before_action :set_friend_request, only: :destroy

  def create
    if @friend_request.save
      respond_to do |format|
        format.html { redirect_to users_path, flash: { success: 'Your friend request was sent!' } }
        format.turbo_stream { flash.now[:success] = 'Your friend request was sent!' }
      end
    else
      flash.now[:error] = 'Something went wrong'

      @users = User.all
      render template: 'users/index', status: :unprocessable_entity
    end
  end

  def destroy
    if @friend_request.destroy
      respond_to do |format|
        format.html { redirect_to users_path, flash: { success: 'The friend request was ignored!' } }
        format.turbo_stream { flash.now[:success] = 'The friend request was ignored!' }
      end
    else
      flash.now[:error] = 'Something went wrong'

      @users = User.all
      render template: 'users/index', status: :unprocessable_entity
    end
  end

  private

  def build_friend_request
    @friend_request = FriendRequest.new(sender_id: current_user.id, receiver_id: params[:receiver])
  end

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end
