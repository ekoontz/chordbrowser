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

#    debugger

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
    #should be only one.
    for chord in Chord::find(
                             :all,
                             :conditions => ("id='" + params[:id] + "'"))
      chord.name = self.params['name']
      chord.save

      for family in Family::find(
                                 :all,
                                 :conditions => ("name='" + chord.family + "'"))
        
        family_id = family.id
      end
    end

    redirect_to("/family/view/"+family_id.to_s)

  end

end
