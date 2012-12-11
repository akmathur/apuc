class ProfilesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @profile = Profile.first
  end

  # save the uploaded photo, render view for cropping
  def update_photo
    @profile = Profile.find(params[:id])
    @profile.update_attributes!(params[:profile])
    render :nothing => true
  end

  # render view for cropping
  def refresh_photo
    @profile = Profile.find(params[:id])
    @profile.crop = 1
    @profile.crop_x = 0
    @profile.crop_y = 0
    @profile.crop_w = @profile.req_width
    @profile.crop_h = @profile.req_height
  end

  def replace_photo
    @profile = Profile.find(params[:id])
  end

  def update_crop
    @profile = Profile.find(params[:id])
    @profile.reload
    @profile.update_attributes!(params[:profile])
  end
end
