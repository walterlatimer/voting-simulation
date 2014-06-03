class Politician < Citizen

	attr_accessor :party
	PARTIES = ["Republican", "Democrat"] # All possible options

	def initialize
		super
		@party = get_party
	end

	def update_party
		prompt = "Current Party: #{@party}. New Party?"
		@party = update(@party, prompt: prompt, values: PARTIES)
	end

	# Vote for self
	def vote(candidates)
		super
		puts "#{@name} voted for #{self.name}.  As if we didn't see that coming..."
		return self
	end

	private
	def get_party
		gets_from_values(PARTIES, prompt: "Party? Republican or Democrat?")
		# PARTIES.sample
	end
end