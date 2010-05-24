class AddFbTokenToAccounts < ActiveRecord::Migration
  def self.up
    change_table :accounts do |t|
      t.string :fb_token
    end
      end

      def self.down
    change_table :accounts do |t|
      t.remove :fb_token
    end
  end
end
