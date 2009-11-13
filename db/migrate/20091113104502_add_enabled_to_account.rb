class AddEnabledToAccount < ActiveRecord::Migration
  def self.up
    change_table :accounts do |t|
      t.boolean :enabled, :default => true
    end
  end

  def self.down
    change_table :accounts do |t|
      t.remove :enabled
    end
  end
end
