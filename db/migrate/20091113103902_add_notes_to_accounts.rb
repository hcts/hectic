class AddNotesToAccounts < ActiveRecord::Migration
  def self.up
    change_table :accounts do |t|
      t.text :notes
    end
  end

  def self.down
    change_table :accounts do |t|
      t.remove :notes
    end
  end
end
