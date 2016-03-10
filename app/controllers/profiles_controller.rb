class ProfilesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def create
    @profile = Profile.new(params[:profile])

    if @profile.save
      flash[:success] = 'Profile was successfully created.'
      redirect_to profiles_path
    else
      render :action => "new"
    end
  end

  def update
    @profile = Profile.find(params[:id])

    if @profile.update_attributes(params[:profile])
      flash[:success] = 'Profile was successfully updated.'
      redirect_to profiles_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    redirect_to(profiles_path)
  end

  # Save the uploaded photo or a cropped photo sent via AJAX calls
  def update_photo
    @profile = Profile.find(params[:id])
    @profile.update_attributes!(params[:profile])
    if @profile.cropping?
      render :action => "update_photo"
    else
      render :nothing => true
    end
  end

  # Render view for cropping. Called after upload finishes
  def crop_canvas
    @profile = Profile.find(params[:id])
    @profile.crop = 1
    @profile.crop_x = 0
    @profile.crop_y = 0
    @profile.crop_w = @profile.req_width
    @profile.crop_h = @profile.req_height
  end
end
