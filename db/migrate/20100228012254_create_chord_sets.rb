class CreateChordSets < ActiveRecord::Migration
  def self.up
    create_table :chord_sets do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :chord_sets
  end
end
