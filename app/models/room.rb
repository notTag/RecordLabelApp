class Room < ActiveRecord::Base
   belongs_to :studio
   belongs_to :session
end
