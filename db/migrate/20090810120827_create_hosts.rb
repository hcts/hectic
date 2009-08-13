class CreateHosts < ActiveRecord::Migration
  def self.up
    create_table :hosts do |t|
      t.string :name
      t.string :local_name # these are postfix's virtual mailbox domains
      t.string :pop_server
      t.string :smtp_server
      t.timestamps
    end
  end

  def self.down
    drop_table :hosts
  end
end
