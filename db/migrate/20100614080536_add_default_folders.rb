class AddDefaultFolders < ActiveRecord::Migration
  def self.up
    User.find(:all).each{|u|
      u.create_default_folders!
    }
  end

  def self.down
  end
end
