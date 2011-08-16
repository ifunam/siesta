class Room < ActiveRecord::Base
  belongs_to :building
  belongs_to :room_type
end
