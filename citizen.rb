class Citizen

	attr_accessor :name
	attr_reader :voter_id

	@@voter_id = 1

	def initialize
		@name       = get_name
		@voter_id   = @@voter_id
		@@voter_id += 1
	end

	def update_name
		@name = update(@name, prompt: "\nCurrent name: #{@name}. New name?")
	end

	# Pause for one second before each vote
	# Pass in array of candidates to vote from
	def vote(candidates) sleep(1) end

	private
	def get_name
		puts "\nWhat would you like to name your #{self.class.to_s.downcase}?"
		gets_alpha
		# test_name = ["Walter", "Ed", "Juha", "Jo", "Chris", "Julie",
		# "Matt", "Frank", "Crystalei", "Joey", "Janvier", "Bryan", "Sean",
		# "Sara", "Rima", "Hector", "Javier", "Darrell", "PK", "Orrett", "Jordan", "Burt"]
		# @name = test_name.sample
	end
end