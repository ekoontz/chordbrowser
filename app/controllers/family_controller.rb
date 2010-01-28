class FamilyController < ApplicationController

  def index
    # show all families
    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )

    xml.families(:time => Time.now)  {
      for family in Family::find(:all,:order=>"name")
        xml.family(:name => family.name) {
          Chord::export(xml,"family='"+family.name+"'")
        }
      end
    }

    render_xsl(@xml,"public/stylesheets/family.xsl")

  end

  def view
    # show one family
    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )

    xml.families(:time => Time.now)  {
      for family in Family::find(
                                 :all,
                                 :conditions => ("name='" + params[:id] + "'"))
        xml.family(:name => family.name) {
          Chord::export(xml,"family='"+params[:id]+"'")
        }
      end
    }

    render_xsl(@xml,"public/stylesheets/family.xsl")
  end

  def newchord

    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )

    xml.families(:time => Time.now)  {
      for family in Family::find(
                                 :all,
                                 :conditions => ("name='" + params[:id] + "'"))
        xml.family(:name => family.name) {
          Chord::export(xml,"family='"+params[:id]+"'")
        }
        xml.edit {
          xml.chord {
            xml.fret(:number => "nut",
                     :e_low => "open",
                     :a => "open",
                     :d => "open",
                     :g => "open",
                     :b => "open",
                     :e => "open"
                     )

            xml.fret(:number => "1",
                     :e_low => "",
                     :a => "",
                     :d => "",
                     :g => "",
                     :b => "",
                     :e => "")

            xml.fret(:number => "2",
                     :e_low => "",
                     :a => "",
                     :d => "",
                     :g => "",
                     :b => "",
                     :e => "")

            xml.fret(:number => "3",
                     :e_low => "",
                     :a => "",
                     :d => "",
                     :g => "",
                     :b => "",
                     :e => "")

            xml.fret(:number => "4",
                     :e_low => "",
                     :a => "",
                     :d => "",
                     :g => "",
                     :b => "",
                     :e => "")


          }
        }
      end
    }

    render_xsl(@xml,"public/stylesheets/family.xsl",
               {"action" => "new"})
    
  end


end
