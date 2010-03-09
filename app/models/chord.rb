class Chord < ActiveRecord::Base

  # class method: export all chords.
  def Chord::export(xml,conditions = "")
    for chord in find(:all,:order=>"name ASC",:conditions=>conditions)
      chord.export(xml)
    end
  end

  # instance method: export one chord.
  def export(xml)

    # get family id.
    families = Family::find(:all,:conditions => "name='"+family+"'")
    #should be only one.
    for the_family in families
      family_id = the_family.id
    end

    xml.chord(:name => name,
              :family => family,
              :fret_offset => fret_offset,
              :family_id => family_id,
              :id => id
              ) {
      @frets = Fret::find(:all,:conditions => "chord_id='"+self.id.to_s+"'",
                          :order=>"number ASC")
      for fret in @frets
        xml.fret(:number => fret.number,
                 :e_low => fret.e_low,
                 :a => fret.a,
                 :d => fret.d,
                 :g => fret.g,
                 :b => fret.b,
                 :e => fret.e
                 )
      end

    }
  end

  def get_family_id
    families = Family::find(:all,:conditions => "name='"+family+"'")
    #should be only one.
    for the_family in families
      family_id = the_family.id
      return family_id
    end
  end


end
