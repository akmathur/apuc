class Profile < ActiveRecord::Base
  attr_accessible :name, :avatar, :crop_x, :crop_y, :crop_w, :crop_h, :crop, :req_width, :req_height
  attr_accessor :crop

  validates :req_width, :req_height, :presence => true

  has_attached_file :avatar,
    :styles => lambda { |attachment|
      { 
        :normal => "#{attachment.instance.req_width}x#{attachment.instance.req_height}>",
        :thumb => "82x82>"
      }
    },
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
