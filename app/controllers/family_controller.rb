class FamilyController < ApplicationController

  def index
    # show all families
    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )

    xml.families(:time => Time.now)  {
      for family in Family::find(:all,:order=>"name")
        xml.family(:name => family.name,:id=>family.id) {
          Chord::export(xml,"family='"+family.name+"'")
        }
      end
    }

    render_xsl(@xml)

  end

  def view
    # show one family
    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )
    # should be only one family for this chord.
    for family in Family::find(
                               :all,
                               :conditions => ("id='" + params[:id] + "'"))
      xml.family(:name => family.name, :id => family.id) {
        Chord::export(xml,"family='"+family.name+"'")
      }
    end

    logger.info("family_controller.rb:view: checking fret_action.")

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

      #chord attribute stuff not working yet..
      if nil
        for attrib in ChordAttribute::find(:all)
          
          logger.info("checking chord attribute: " + attrib.name + ".")
          
          if ((self.params['attribute']) && (self.params['attrib'][attrib.name] == "on"))
            logger.info("attribute: " + attrib.name + " checked.")
            
            # link chord (e.g. 'C#sus4') with attribute (e.g. 'sus4')
            
            link = ChordToChordAttrib.new
            
            link.chord_id = newchord.id
            
            attribs = ChordAttribute::find(:all,
                                           :conditions => ("name='"+self.params['attrib'][attrib.name]+"'"))
            set_attrib = attribs[0]
            
            link.attrib_id = set_attrib.id
          else
            logger.info("done checking attribute: " + attrib.name + ".")          
          end
        end
      end

      # look up family by name.(FIXME: controller should pass family by id, not name.)
      for family in Family::find(
                                 :all,
                                 :conditions => ("name='" + self.params['family'] + "'"))
        family_id = family.id
      end

      redirect_to "/family/view/"+family_id.to_s, :status=>303
      return
    end

    render_xsl(@xml)

  end

  def newchord

    @xml = ""
    xml = Builder::XmlMarkup.new(:target => @xml, :indent => 2 )

    xml.families(:time => Time.now)  {
      for family in Family::find(
                                 :all,
                                 :conditions => ("id='" + params[:id] + "'"))
        xml.family(:name => family.name, :id => family.id) {
          Chord::export(xml,"family='"+family.name+"'")
        }

        # used by XSLT to construct form for new (or eventually edit) chord.
        if nil
          xml.chord_attributes {
            for chord_attribute in ChordAttribute::find(:all) 
              xml.chord_attribute(:name => chord_attribute.name)
            end
          }
        end

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

    render_xsl(@xml,nil,
               {"action" => "new"})
    
  end


end
