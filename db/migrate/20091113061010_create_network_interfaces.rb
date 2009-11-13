class CreateNetworkInterfaces < ActiveRecord::Migration
  def self.up
    create_table :network_interfaces do |t|
      t.string :host
      t.integer :snmp_index
      t.timestamps
    end
  end

  def self.down
    drop_table :network_interfaces
  end
end
