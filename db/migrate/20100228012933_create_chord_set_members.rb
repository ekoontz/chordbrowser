class CreateChordSetMembers < ActiveRecord::Migration
  def self.up
    create_table :chord_set_members do |t|
      t.column :chord_set_id, :integer, :null => false
      t.column :chord_id, :integer, :null => false
      t.timestamps
    end

    execute "ALTER TABLE chord_set_members ADD CONSTRAINT fk_chord_set_members_chord_set foreign key (chord_set_id) REFERENCES chord_sets(id)"

    execute "ALTER TABLE chord_set_members ADD CONSTRAINT fk_chord_set_members_chord foreign key (chord_id) REFERENCES chords(id)"

  end

  def self.down
    drop_table :chord_set_members
  end
end
