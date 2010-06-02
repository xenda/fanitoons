class AddBirthDateToAccounts < ActiveRecord::Migration
  def self.up
    add_column :accounts, :birth_date, :date
  end

  def self.down
    remove_column :accounts, :birth_date
  end
end
