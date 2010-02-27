# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require 'xml/xslt'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
#  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  before_filter :set_content_type

#  session :on
  #above generates warning:
  # DEPRECATION WARNING: Disabling sessions for a single controller has been deprecated. Sessions are now lazy loaded. So if you don't access them, consider them off. You can still modify the session cookie options with request.session_options.. (called from /home/ekoontz/projects/chordbrowser/app/controllers/application_controller.rb:13)
 
  def set_content_type
    @headers = {}
    #fixme: use switch, not nested if..else..
    if self.params["output"] == "xml"
      @headers["Content-Type"] = "text/xml; charset=utf-8"
    else
      if self.params["output"] == "xsl"
        @headers["Content-Type"] = "text/xml; charset=utf-8"
      else
        @headers["Content-Type"] = "application/xhtml+xml; charset=utf-8"
      end
    end
  end

  def render_xsl(xml,xsl = nil,extra_params = Hash.new)

    if self.params["output"] == "xml"
      render :xml => xml
      return
    end

    xslt = XML::XSLT.new()
    xslt.xml = xml
    
    default_xsl = "public/stylesheets/" + self.params[:controller] + "/" + self.params[:action] + ".xsl"
    
    if (self.params['mode'] == nil)
      self.params['mode'] = self.params[:action]
    end
    
    logger.info("render_xsl(): default xsl: " + default_xsl)
    
    if (xsl == nil)
      # guess what the XSL is based on the URL.
      # (from routes.rb:) ':controller/:action/:id'
      xsl = default_xsl
    else
      logger.info("overriding default with caller's xsl: " + xsl)
    end
    
    xslt.xsl = File.read(xsl)
    
    if self.params["output"] == "xsl"
      render :xml => File.read(xsl)
      return
    end

    self.params['request_forgery_protection_token'] = 
      self.request_forgery_protection_token.to_s
    
    # Does not work yet because of single quotes(') in token.
    # adding a single quote to end of input value in : public/stylesheets/family.xsl.
    self.params['form_authenticity_token'] = 
      self.form_authenticity_token.gsub(/\'/,"")
    
    if flash[:notice]
      self.params['flash_notice'] = flash[:notice]
    end
    
    if self.current_user
      self.params['current_user'] = self.current_user.id.to_s
    end

    logger.info("render_xsl(): <self.params>");
    self.params.keys.sort.each {|key|
      logger.info(" " + key + " => " + self.params[key])
    }
    logger.info("render_xsl(): </self.params>");

# can't do this because some self.params 
# (most, in fact) cause the xslt to not work
# for unknown reasons.
#    xslt_params = xslt_params.merge(self.params)
    xslt_params = Hash.new
    self.params.keys.sort.each {|key|
      logger.info(" " + key + " => " + self.params[key])
      if (
          key != "id" &&
          key != "mode") 
        xslt_params[key] = self.params[key]
      end
    }
    
    xslt_params["foo"] = "bar"

    xslt_params = xslt_params.merge(extra_params)
    
    logger.info("render_xsl(): <xslt_params>");
    xslt_params.keys.sort.each {|key|
      logger.info(" " + key + " => " + xslt_params[key])
    }
    logger.info("render_xsl(): </xslt_params>");
    
    xslt.parameters = xslt_params
    
    @out = xslt.serve()
    
    self.response.headers["Cache-Control"] = "no-cache"
    self.response.headers["Pragma"] = "no-cache"
    
    if (@out == nil) 
      logger.info("ERROR: NO OUTPUT FOR XML: ")
      logger.info(xml)
      render :xml => "<error type='no output' xsl='"+xsl+"'/>"
    else
      render :xml => @out
    end
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
