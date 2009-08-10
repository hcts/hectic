class CreateHosts < ActiveRecord::Migration
  def self.up
    create_table :hosts do |t|
      t.string  :smtp_server_address
      t.string  :smtp_server_credentials
      t.string  :smtp_server_name
      t.integer :smtp_server_port, :default => 587
      t.string  :smtp_server_username
      t.string  :smtp_server_password
      t.timestamps
    end
  end

  def self.down
    drop_table :hosts
  end
end
