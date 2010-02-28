class ChordSet < ActiveRecord::Base
  has_many :chord_set_members

  #class instance : export all chords (that satisfy specified conditions, or all, if no conditions given).
  def ChordSet::export(xml,conditions = "",add = "")

    xml.chord_sets(:time => Time.now) {
      for chord_set in find(:all,:order=>"name ASC",:conditions=>conditions)
        chord_set.export(xml)
      end

      # find all chords for which there is a corresponding chord_set_member.
      xml.chords {
        for chord in Chord::find_by_sql ["SELECT * FROM chords 
                                                  WHERE id IN (SELECT chord_id 
                                                                 FROM chord_set_members 
                                                                WHERE chord_set_id = ?)",chord_set[:id]]
          chord.export(xml)
        end
      }

      if (add == "add") 
        xml.add {
          xml.chords {
            # find all chords for which there is NOT a corresponding chord_set_member.
            for chord in Chord::find_by_sql ["SELECT * FROM chords 
                                                  WHERE id NOT IN (SELECT chord_id 
                                                                 FROM chord_set_members 
                                                                WHERE chord_set_id = ?) ORDER BY name",chord_set[:id]]
              chord.export(xml)
            end
          }

        }
      end

    }
  end

  def export(xml)
    xml.chord_set(:name => name,
                  :id => id) {
    }
  end

end
