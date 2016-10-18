class Room < ActiveRecord::Base
   belongs_to :studio
   has_many :sessions
end
