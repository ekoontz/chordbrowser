class ChordSet < ActiveRecord::Base
  has_many :chord_set_members

  #class instance : export all chords (that satisfy specified conditions, or all, if no conditions given).
  def ChordSet::export(xml,conditions = "")
    xml.chord_sets(:time => Time.now) {
      for chord_set in find(:all,:order=>"name ASC",:conditions=>conditions)
        chord_set.export(xml)
      end

      xml.chords {
        for chord in Chord::find(:all,:order=>"name ASC")
          chord.export(xml)
        end
      }

    }
  end

  def export(xml)
    xml.chord_set(:name => name,
                  :id => id) {
    }
  end

end
