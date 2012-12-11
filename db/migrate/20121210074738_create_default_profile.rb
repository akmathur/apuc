class CreateDefaultProfile < ActiveRecord::Migration
  def up
    Profile.create!(:name => "default-test")
  end

  def down
  end
end
