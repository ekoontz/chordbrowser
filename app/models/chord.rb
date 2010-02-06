class Chord < ActiveRecord::Base

  def Chord::export(xml,conditions = "")
    for chord in find(:all,:order=>"name",:conditions=>conditions)
      chord.export(xml)
    end
  end

  def export(xml)
    xml.chord(:name => name,
              :family => family,
              :id => id
              ) {
      @frets = Fret::find(:all,:conditions => "chord_id='"+self.id.to_s+"'")
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

end
