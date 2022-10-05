# frozen_string_literal: true

# The FriendshipsController handles the REST actions for the Friendship model.
class FriendshipsController < ApplicationController
  before_action :build_friendship, only: :create
  before_action :set_friendship, only: :destroy
  before_action :set_friend, only: :destroy
  before_action :set_users, only: %i[create destroy]

  def create
    if @friendship.save
      respond_to do |format|
        flash[:success] = "You and #{@friendship.user2.username} are now friends!"

        format.html { redirect_to users_path }
        format.turbo_stream
      end
    else
      flash.now[:error] = 'Something went wrong'
      render template: 'users/index', status: :unprocessable_entity
    end
  end

  def destroy
    if @friendship.destroy
      respond_to do |format|
        flash[:success] = 'You are no longer friends!'
        format.html { redirect_to users_path }
        format.turbo_stream
      end
    else
      flash.now[:error] = 'Something went wrong'
      render template: 'users/index', status: :unprocessable_entity
    end
  end

  private

  def build_friendship
    @friendship = Friendship.new(user1_id: current_user.id, user2_id: params[:user2])
  end

  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  def set_friend
    @friend = @friendship.user1 == current_user ? @friendship.user2 : @friendship.user1
  end

  def set_users
    @users = User.all
  end
end
