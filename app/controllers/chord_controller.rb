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
    if current_user
    else
      flash[:notice] = "You must be logged in to delete chords."
      this_chord = Chord::find(:all,:conditions=>("id = '"+ params[:id] + "'")).first
      if (this_chord)
        #FIXME: use family id, not family name as foreign key to families.      
        family_id = this_chord.get_family_id.to_s
        redirect_to "/family/view/"+family_id, :status=>303
        return
      else
        redirect_to "/"+family_id, :status=>303

      end
    end

    this_chord = Chord::find(:all,:conditions=>("id = '"+ params[:id] + "'")).first
    if (this_chord)
      #FIXME: use family id, not family name as foreign key to families.      
      family_id = this_chord.get_family_id.to_s

      this_chord.delete
      logger.info(" REDIRECTING WITH A 303.")
      flash[:notice] = "Chord deleted."
      redirect_to "/family/view/"+family_id, :status=>303
      return
    end
    logger.info("error: chord to delete was not found.")
    redirect_to "/family/view/"+family_id, :status=>303

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
      family_id = chord.get_family_id.to_s

    end

    flash[:notice] = "Chord added."
    redirect_to "/family/view/"+family_id.to_s,:status=>303

  end

end
