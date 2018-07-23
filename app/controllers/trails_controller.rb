class TrailsController < ApplicationController

  before_action :current_user

  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @trails = Trail.all
    end
  end

  def new
    @trail = Trail.new
  end

  def create
    if !logged_in?
      @message = ["You must be logged in to create a trail. Please login below."]
      
      render "sessions/new"
    else
      @trail = Trail.create(trail_params)

      redirect_to trails_path
    end
  end

  def show
    @trail = Trail.find(params[:id])
  end

  def edit
    @trail = Trail.find(params[:id])
  end


  def update
    @trail = Trail.find(params[:id])
    @trail.update(trail_params)
   
    redirect_to trail_path(@trail)
  end

  def destroy
    if !logged_in?
      redirect_to login_path
    else
      @trail = Trail.find(params[:id]).destroy

      redirect_to user_path(@current_user)
    end
  end
  
  private

  def trail_params
    params.require(:trail).permit(:name, :length)
  end
end
