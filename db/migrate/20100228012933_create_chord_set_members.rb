class CreateChordSetMembers < ActiveRecord::Migration
  def self.up
    create_table :chord_set_members do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :chord_set_members
  end
end
