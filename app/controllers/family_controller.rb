require 'xml/xslt'

class FamilyController < ApplicationController
 before_filter :set_content_type
 
  def set_content_type
    @headers = {}
    if self.params["output"] == "xml"
      @headers["Content-Type"] = "text/xml; charset=utf-8"
    else
#      @headers["Content-Type"] = "text/xml; charset=utf-8"
    end
  end

  def index

    # <build the xml output.>
    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )

    now = Time.now
    # fixme: add page load time (Time.now minus request_start_time)
    xml.family(:time => now)  {
    }

    if self.params["output"] == "xml"
      render :xml => @xml
    else
      xslt = XML::XSLT.new()
      xslt.xml = @xml
      xslt.xsl = File.read("public/stylesheets/family.xsl")
      @out = xslt.serve()
      render :xml => @out
    end
  end

end
