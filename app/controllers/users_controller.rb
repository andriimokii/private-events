class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @users = User.all
  end

  def show
    @user = User.includes(:events).find(params[:id])
    @past_events = @user.attended_events.past
    @future_events = @user.attended_events.future
  end
end
