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
    if self.params["output"] == "xml"
      @headers["Content-Type"] = "text/xml; charset=utf-8"
    else
      @headers["Content-Type"] = "application/xhtml+xml; charset=utf-8"
    end
  end

  def render_xsl(xml,xsl = nil,xsl_params = Hash.new)
    if self.params["output"] == "xml"
      render :xml => xml
    else
      xslt = XML::XSLT.new()
      xslt.xml = xml

      default_xsl = "public/stylesheets/" + self.params[:controller] + "/" + self.params[:action] + ".xsl"

      if (xsl_params['mode'] == nil)
        xsl_params['mode'] = self.params[:action]
      end

      logger.info("default xsl: " + default_xsl)

      if (xsl == nil)
        # guess what the XSL is based on the URL.
        # (from routes.rb:) ':controller/:action/:id'
        xsl = default_xsl
      else
        logger.info("overriding default with caller's xsl: " + xsl)
      end

      xslt.xsl = File.read(xsl)

      xsl_params['request_forgery_protection_token'] = 
        self.request_forgery_protection_token.to_s

      # Does not work yet because of single quotes(') in token.
      # adding a single quote to end of input value in : public/stylesheets/family.xsl.
      xsl_params['form_authenticity_token'] = 
        self.form_authenticity_token.gsub(/\'/,"")

      if flash[:notice]
        xsl_params['flash_notice'] = flash[:notice]
      end

      if self.current_user
        xsl_params['current_user'] = self.current_user.id.to_s
      end

      xslt.parameters = xsl_params.clone

      @out = xslt.serve()

      self.response.headers["Cache-Control"] = "no-cache"
      self.response.headers["Pragma"] = "no-cache"

      render :xml => @out
    end

  end


  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
