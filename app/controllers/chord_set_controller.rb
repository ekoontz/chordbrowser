class ChordSetController < ApplicationController

  def index
    # show all sets.
    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )
    ChordSet::export(xml)
    render_xsl @xml
  end

  def new
    # same as "index", but stylesheet will differ.
    self.index
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
    redirect_to "/chord_set/view/"+newset.id.to_s, :status=>303
  end

  def delete
    if current_user

      links = ChordSetMembers::find(:all,:conditions=>("chord_set_id = '"+ params[:id] + "'"))
      for link in links
        link.delete
      end

      this_set = ChordSet::find(:all,:conditions=>("id = '"+ params[:id] + "'")).first
      if (this_set)
        this_set.delete
      end
      flash[:notice] = "Chord set deleted."
    else
      flash[:notice] = "You must be logged in to delete chord sets."
    end
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
    if current_user
      link = ChordSetMembers::find(:all,:conditions=>["chord_id='"+params[:id]+"'","chord_set_id='"+params[:chord_set_id]+"'"]).first
      if (link) 
        link.delete
      end
      flash[:notice] = "Chord removed from this set."
    else
      flash[:notice] = "You must be logged in to remove chords from sets."
    end
    redirect_to "/chord_set/view/"+params[:chord_set_id], :status=>303
  end

end
