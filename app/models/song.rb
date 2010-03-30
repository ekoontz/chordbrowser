class Song < ActiveRecord::Base
  # class method: export all chords.
  def Song::export(xml,conditions = "")
    for song in find(:all,:order=>"name ASC",:conditions=>conditions)
      song.export(xml)
    end
  end

end
