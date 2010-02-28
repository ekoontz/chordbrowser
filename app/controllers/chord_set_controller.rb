class ChordSetController < ApplicationController
  def index
    # show all sets.
    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )

    xml.chord_sets(:time => Time.now)  {
      for chord_set in ChordSet::find(:all,:order=>"name")
        xml.chord_set(:name => chord_set.name,:id=>chord_set.id) {
          #export all chords for this set.
        }
      end
    }

    render_xsl(@xml)

  end

end
