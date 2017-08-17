class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  def index
    @events = current_user.events.where(start: params[:start]..params[:end])
  end

  def show
  end

  def new
    @event = current_user.events.new
  end

  def edit
  end

  def create
    @event = current_user.events.new(event_params)
    @event.save

  end

  def update
    @event.update(event_params)
  end

  def destroy
    @event.destroy
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :date_range, :start, :end, :color)
  end
end