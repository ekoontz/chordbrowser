class Fret < ActiveRecord::Base
  def Fret::export(xml)
    for fret in find(:all,:order=>"name")
      fret.export(xml)
    end
  end

  def export(xml)
    xml.chord(:name => name,
              :chord => family
              ) 
  end

end
