require 'xml/xslt'

class FamilyController < ApplicationController

  def index

    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )

    xml.families(:time => Time.now)  {
      for family in Family::find(:all,:order=>"name")
        xml.family(:name => family.name) {
          Chord::export(xml)
        }
      end
    }

    render_xsl(@xml,"public/stylesheets/family.xsl")

  end

end
