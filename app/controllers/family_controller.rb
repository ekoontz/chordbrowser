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

    if (self.params['fret_action'] == "insert") 
      newchord = Chord.new
      newchord.family = self.params['family']
      newchord.name = self.params['name']
      newchord.save

      ["nut",1,2,3,4].each do |fret|
        newfret = Fret.new
        newfret.number = fret
        newfret.chord_id = newchord.id
        
        newfret.e_low = self.params['fret'][fret.to_s]['e_low']
        newfret.a = self.params['fret'][fret.to_s]['a']
        newfret.d = self.params['fret'][fret.to_s]['d']
        newfret.g = self.params['fret'][fret.to_s]['g']
        newfret.b = self.params['fret'][fret.to_s]['b']
        newfret.e = self.params['fret'][fret.to_s]['e']

        newfret.save

      end

    end


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

        # used by XSLT to construct form for new (or eventually edit) chord.
        xml.chord_attributes {
          for chord_attribute in ChordAttribute::find(:all) 
            xml.chord_attribute(:name => chord_attribute.name)
          end
        }

        xml.edit {
          xml.chord {

            ["nut",1,2,3,4].each do |fret|
              xml.fret(:number => fret,
                       :e_low => "",
                       :a => "",
                       :d => "",
                       :g => "",
                       :b => "",
                       :e => "")
            end



          }
        }
      end
    }

    render_xsl(@xml,"public/stylesheets/family.xsl",
               {"action" => "new"})
    
  end


end
