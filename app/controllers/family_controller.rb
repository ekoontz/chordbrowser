require 'xml/xslt'

class FamilyController < ApplicationController

  def index

    # <build the xml output.>
    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )

    now = Time.now
    # fixme: add page load time (Time.now minus request_start_time)
    xml.family(:time => now)  {
    }

    render_xsl(@xml,"public/stylesheets/family.xsl")

  end

end
