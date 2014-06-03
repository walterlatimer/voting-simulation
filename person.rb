class Person < Citizen
	include VotingMethods

	attr_accessor :politics
	POLITICS = ["Tea Party", "Conservative", "Socialist", "Neutral", "Liberal"] # All possible options

	def initialize
		super
		@politics = get_politics
	end

	def update_politics
		prompt = "Current Politics: #{@politics}. New Politics?"
		@politics = update(@politics, prompt: prompt, values: POLITICS)
	end

	private

	def get_politics
		prompt = "Politics? Tea Party, Conservative, Neutral, Liberal, or Socialist"
		gets_from_values(POLITICS, prompt: prompt)
		# POLITICS.sample
	end
end