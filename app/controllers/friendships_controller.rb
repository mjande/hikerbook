# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :set_friendship, only: :create
  before_action :set_users, only: [:create, :destroy]

  def create
    if @friendship.save
      respond_to do |format|
        flash[:notice] = "You and #{@friendship.user2.username} are now friends!"

        format.html { redirect_to users_path }
        format.turbo_stream { redirect_to users_path }
      end
    else
      flash.now[:alert] = 'Something went wrong'
      render template: 'users/index', status: :unprocessable_entity
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])

    if @friendship.destroy
      respond_to do |format|
        format.html { redirect_to users_path, notice: 'You are no longer friends.' }
        format.turbo_stream { redirect_to users_path, notice: 'You are no longer friends.' }
      end
    else
      flash.now[:notice] = 'Something went wrong'
      render template: 'users/index', status: :unprocessable_entity
    end
  end

  private

  def set_friendship
    @friendship = Friendship.new(user1_id: current_user.id, user2_id: params[:user2])
  end

  def set_users
    @users = User.all
  end
end
