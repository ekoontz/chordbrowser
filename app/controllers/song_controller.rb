class SongController < ApplicationController
  def index
    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )

    xml.songs(:time => Time.now)  {
      Song::export(xml)
    }
    render_xsl(@xml,"public/stylesheets/songs.xsl")
  end
end
