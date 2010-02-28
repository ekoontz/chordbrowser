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

  def view
    # show one set.
    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )
    ChordSet::export(xml,"id='"+params[:id]+"'")
    render_xsl @xml
  end

  def view_with_add
    # show one set and also show all chords that could be added to this set.
    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )
    ChordSet::export(xml,"id='"+params[:id]+"'","add")
    render_xsl @xml
  end

  def insert
    # new chord set.
    newset = ChordSet.new
    newset.name = self.params['name']
    newset.save

    flash[:notice] = "Chord set added."
    redirect_to "/chord_set/", :status=>303
  end

  def add_chord
    # add chord to set.

    newlink = ChordSetMembers.new
    newlink.chord_id = params[:id]
    newlink.chord_set_id = params[:chord_set_id]
    newlink.save

    flash[:notice] = "Chord added to this set."
    redirect_to "/chord_set/view/"+params[:chord_set_id], :status=>303
  end

  def remove_chord
    # add chord to set.

    link = ChordSetMembers::find(:all,:conditions=>["chord_id='"+params[:id]+"'","chord_set_id='"+params[:chord_set_id]+"'"]).first
    if (link) 
      link.delete
    end

    flash[:notice] = "Chord removed from this set."
    redirect_to "/chord_set/view/"+params[:chord_set_id], :status=>303
  end

end
