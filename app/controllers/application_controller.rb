# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require 'xml/xslt'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
#  protect_from_forgery # See ActionController::RequestForgeryProtection for details

 before_filter :set_content_type
 
  def set_content_type
    @headers = {}
    if self.params["output"] == "xml"
      @headers["Content-Type"] = "text/xml; charset=utf-8"
    else
      @headers["Content-Type"] = "application/xhtml+xml; charset=utf-8"
    end
  end

  def render_xsl(xml,xsl,xsl_params = Hash.new)
    if self.params["output"] == "xml"
      render :xml => @xml
    else
      xslt = XML::XSLT.new()
      xslt.xml = @xml
      xslt.xsl = File.read(xsl)

      logger.info("render.xsl: xsl: " + xsl)
      xsl_params['request_forgery_protection_token'] = 
        self.request_forgery_protection_token.to_s

      # Does not work yet because of single quotes(') in token.
      # adding a single quote to end of input value in : public/stylesheets/family.xsl.
      xsl_params['form_authenticity_token'] = 
        self.form_authenticity_token.gsub(/\'/,"")

      xslt.parameters = xsl_params.clone

      @out = xslt.serve()
      render :xml => @out
    end

  end


  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
