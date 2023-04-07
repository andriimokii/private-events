class Events::EnrollmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    enrollment = current_user.enrollments.new(event: @event)

    if enrollment.save
      flash[:notice] = "You are now attending this event!"
      redirect_to @event, status: :see_other
    else
      flash[:alert] = "Some error!"
      redirect_to @event, status: :unprocessable_entity
    end
  end

  def destroy
    enrollment = current_user.enrollments.find_by(event: @event)

    if enrollment.destroy
      flash[:notice] = "You are no longer attending this event!"
      redirect_to @event, status: :see_other
    else
      flash[:alert] = "Some error!"
      redirect_to @event, status: :unprocessable_entity
    end
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end
