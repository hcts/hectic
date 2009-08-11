class AddPopLoginViaToHosts < ActiveRecord::Migration
  def self.up
    change_table(:hosts) do |t|
      t.string :pop_login_via, :default => 'username'
    end
  end

  def self.down
    change_table(:hosts) do |t|
      t.remove :pop_login_via
    end
  end
end
