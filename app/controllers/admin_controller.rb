class AdminController < ApplicationController
  def foo
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )
    xml.admin(:time => Time.now) {
    }
    render :xml => @out
  end
end
