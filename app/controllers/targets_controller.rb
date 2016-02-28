class TargetsController < ApplicationController
  def index
    # Grab the appropriate target instance and find channels
    @target = Target.first
    @channels = Target.first.channels.where("active = ?", true).order(:number)
    render :layout => false
  end

  def create
    @target = Target.new(target_params)

    if @target.save
      @target.auth = SecureRandom.hex(16)
      redirect_to target_path(@target)
    else
      render :new
    end
  end

  def new
    @target = Target.new
  end

  def edit
    @target = Target.find(params[:id])
  end

  def show
    @target = Target.first.channels.find(params[:id])
    render :layout => false
  end

  def update
    @target = Target.find(params[:id])
    if @target.update_attributes(target_params)
      redirect_to target_path(@target)
    else
      render :edit
    end
  end

  def destroy
    @target = Target.find(params[:id])
    @target.destroy
    redirect_to new_target_path
  end

  private
  def target_params
    params.require(:target).permit(:name, :last_name)
  end
end
