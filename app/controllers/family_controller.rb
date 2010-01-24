require 'xml/xslt'

class FamilyController < ApplicationController

  def index

    # <build the xml output.>
    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )

    now = Time.now
    xml.families(:time => now)  {
      for family in Family::find(:all,:order=>"name")
        xml.family(:name => family.name) {
          Chord::export(xml)
        }
      end
    }

    render_xsl(@xml,"public/stylesheets/family.xsl")

  end

end
