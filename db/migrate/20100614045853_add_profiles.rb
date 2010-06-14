class AddProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer  :account_id
      t.string   :first_name
      t.string   :last_name
      t.string   :website
      t.string   :blog
      t.string   :icon
      t.timestamps
    end
    Account.find(:all).each{|u|
      profile = Profile.new
      profile.account_id = u.id
      profile.save!
    }
  end

  def self.down
  end
end
