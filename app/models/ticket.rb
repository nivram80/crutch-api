class Ticket < ActiveRecord::Base
	belongs_to :project
	belongs_to :state
end
