class Profile < ActiveRecord::Base
  attr_accessible :name, :avatar, :crop_x, :crop_y, :crop_w, :crop_h, :crop
  attr_accessor :crop


  AVATAR_NW = 320
  AVATAR_NH = 600
  AVATAR_TW = 120
  AVATAR_TH = 120

  has_attached_file :avatar,
                    :styles => { :normal => "#{AVATAR_NW}x#{AVATAR_NH}>",
                                 :thumb => "#{AVATAR_TW}x#{AVATAR_TH}>" }, 
                    :processors => [:jcropper]

  after_update :reprocess_avatar, :if => :cropping?

  def cropping?
    !!crop && crop_x.present? && crop_y.present? && crop_w.present? && crop_h.present?
  end

  def avatar_geometry(style = :medium)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file avatar.path(style)
  end

  protected

    def reprocess_avatar
      avatar.reprocess!
    end
end
