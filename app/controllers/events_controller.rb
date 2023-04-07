class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_event, except: %i[index show new create]

  def index
    @events = Event.all
  end

  def show
    @event = Event.includes(:attendees).find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      flash[:notice] = "Event '#{@event.name}' created!"
      redirect_to @event, status: :see_other
    else
      flash[:alert] = "Event '#{@event.name}' has errors!"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      flash[:notice] = "Event '#{@event.name}' updated!"
      redirect_to @event, status: :see_other
    else
      flash[:alert] = "Event '#{@event.name}' has errors!"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @event.destroy
      flash[:notice] = "Event '#{@event.name}' destroyed!"
      redirect_to @event, status: :see_other
    else
      flash[:alert] = "Event '#{@event.name}' has errors!"
      redirect_to @event, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :location, :description)
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
