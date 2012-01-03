class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.integer :zip_code

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
