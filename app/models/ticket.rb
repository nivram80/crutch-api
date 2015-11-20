class Ticket < ActiveRecord::Base
	belongs_to :project
	belongs_to :state

	validates :title, presence: true
	validates :details, presence: true

	after_create :set_priority

	def change_priority
		adjust_previous_state_lower_tickets
		self.priority = max_priority ? (max_priority + 1) : 1
		self.save
	end

private

	def max_priority
		max_priority = Ticket.where('state_id = ? AND project_id = ? AND id != ?', self.state_id, self.project_id, self.id).maximum("priority")
	end

	def set_priority
		self.priority = max_priority ? (max_priority + 1) : 1
		self.save
	end

	def adjust_previous_state_lower_tickets
		reduce_priority(lower_priority_tickets) if lower_priority_tickets
	end

	def lower_priority_tickets
		lower_priority_tickets = previous_state_tickets.where('priority > ?', self.priority)
	end

	def previous_state_tickets
		Ticket.where('state_id = ? AND project_id = ?', self.previous_state_id, self.project_id)
	end

	def reduce_priority(lower_priority_tickets)
		lower_priority_tickets.each do |ticket|
			ticket.priority -= 1
			ticket.save
		end
	end
 
end
