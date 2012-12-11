class AddCropDimsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :req_width, :integer
    add_column :profiles, :req_height, :integer
  end
end
