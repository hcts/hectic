class AddLimitToAccounts < ActiveRecord::Migration
  def self.up
    change_table :accounts do |t|
      t.integer :limit, :default => 0
    end
  end

  def self.down
    change_table :accounts do |t|
      t.remove :limit
    end
  end
end
