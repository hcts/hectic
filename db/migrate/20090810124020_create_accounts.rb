class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.references :host
      t.string :username
      t.string :password
      t.string :public_email
      t.string :private_email
      t.string :mailbox_path
      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
