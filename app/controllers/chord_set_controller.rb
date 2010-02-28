class ChordSetController < ApplicationController

  def index
    # show all sets.
    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )
    ChordSet::export(xml)
    render_xsl @xml
  end

  def new
    # show all sets.
    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )
    ChordSet::export(xml)
    render_xsl @xml
  end

  def insert
    newset = ChordSet.new
    newset.name = self.params['name']
    newset.save

    flash[:notice] = "Chord set added."


    redirect_to "/chord_set/", :status=>303
    return

  end


end
