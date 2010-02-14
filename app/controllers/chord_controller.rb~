class ChordController < ApplicationController

  def index
    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )

    xml.chords(:time => Time.now)  {
      Chord::export(xml)
    }
    render_xsl(@xml,"public/stylesheets/error.xsl")
  end

  def delete
    @xml = ""
    this_chord = Chord::find(:all,:conditions=>("id = '"+ params[:id] + "'")).first
    if (this_chord)
      this_chord.delete
    end

    redirect_to("/")

  end

  def edit
    @xml = ""
    this_chord = Chord::find(:all,:conditions=>("id = '"+ params[:id] + "'")).first
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )

    if (this_chord)
      xml.chords(:time => Time.now)  {
        this_chord::export(xml)
      }
    else
      # throw error of some kind..
    end

    render_xsl(@xml,"public/stylesheets/chord-standalone.xsl",
               {"edit_chord" => params[:id]}
               )

  end

  def save
    #1-iteration loop.
    #fixme: probably not the preferred method.
    for chord in Chord::find(
                             :all,
                             :conditions => ("id='" + params[:id] + "'"))
      chord.name = self.params['name']

      # FIXME : refactor: copy and pasted from family_controller.rb:view
      ["nut","1","2","3","4"].each do |fret|
        #1-iteration loop.
        #fixme: probably not the preferred method.
        for editfret in Fret::find(:all,
                               :conditions => (("chord_id='" + params[:id] + "' AND number='"+fret+"'")))
          
          editfret.e_low = self.params['fret'][fret.to_s]['e_low']
          editfret.a = self.params['fret'][fret.to_s]['a']
          editfret.d = self.params['fret'][fret.to_s]['d']
          editfret.g = self.params['fret'][fret.to_s]['g']
          editfret.b = self.params['fret'][fret.to_s]['b']
          editfret.e = self.params['fret'][fret.to_s]['e']
          
          editfret.save

        end

      end


      chord.save

      #find family_id : (again, will only loop over one element)
      for family in Family::find(
                                 :all,
                                 :conditions => ("name='" + chord.family + "'"))
        
        family_id = family.id
      end
    end

    redirect_to("/family/view/"+family_id.to_s)

  end

end
