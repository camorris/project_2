class BadgesController < ApplicationController
  before_action :authorize, except: [:index, :show] 
  def index
    @badges = current_user.badges
  end

  def show
    @badge = Badge.find(params[:id])
  end

  def new
    @badge = Badge.new
  end

  def create
    @badge = current_user.badges.new(badge_params)
    # @badge.user = current_user
    if @badge.save
      redirect_to badges_path
    else 
      validation_error_messages(@badge)
      redirect_to new_badge_path

    end
  end
  def edit
    @badge = Badge.find(params[:id])
  end
 
  def update
      @badge = Badge.find(params[:id])
      if @badge.update(badge_params)
        redirect_to badge_path(@badge)
      else
        redirect_to edit_badge_path(@badge)

      end
  end
  

  def destroy
    @badge = Badge.find(params[:id])
    if @badge.destroy
      redirect_to badges_path
    end
  end
  # these lines of code define the method to have a errors messages pop up 
  private
  def validation_error_messages(badge)
    if badge.errors.any?
      errors = "<ul>"
      badge.errors.full_messages.each do |message|
        errors += "<li>#{message}</li>"
      end
    end
    errors += "</ul>"
    flash[:error] = errors
  end
# these lines of code make users enter in this information
        def badge_params
    params.require(:badge).permit(:course, :website, :date, :purpose)
  end
end
