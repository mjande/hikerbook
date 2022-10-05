# frozen_string_literal: true

# The UsersController handles the REST actions for the User model.
class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.where.not('id = ?', current_user.id)
  end
end
