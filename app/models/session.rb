class Session < ActiveRecord::Base
   has_one :user
   has_one :room
   
end
