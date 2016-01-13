class GroupEventsController < ApplicationController
  before_action :find_group_event, only: [:show, :update, :destroy]

  def index
    render json: GroupEvent.unmarked
  end

  def show
    render json: @group_event
  end

  def create
    @group_event = GroupEvent.new(group_event_params)

    if @group_event.save
      render json: @group_event, status: :created, location: @group_event
    else
      render json: @group_event.errors, status: :unprocessable_entiry
    end
  end

  def update
    if @group_event.update(group_event_params)
      head :no_content
    else
      render json: @group_event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @group_event.mark_as_destroyed
    head :no_content
  end

  def publish
    @group_event = GroupEvent.find(params[:group_event_id])
    @group_event.publish
    head :no_content
  end

  private 
    
    def find_group_event
      @group_event = GroupEvent.find(params[:id])
    end

    def group_event_params
      params.require(:group_event).permit(:name, :description, :location, :starts_at, :ends_at, :duration)
    end

end
