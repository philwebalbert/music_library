class CreateArtists < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
      t.string :name
      t.string :active_years
      t.text :biography

      t.timestamps
    end
  end

  def self.down
    drop_table :artists
  end
end
