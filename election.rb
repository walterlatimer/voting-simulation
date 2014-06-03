class Election

	@@term = 1

	attr_reader :term, :winner, :total_voters, :percent, :candidates

	def initialize(voters)
		@term         = @@term
		@@term       += 1
		@voters       = voters # Array of all citizens voting in this election
		@total_voters = @voters.size # Number of citizens who voted in this election
		@candidates   = get_candidates # Array of all politicians in this election
		@votes        = [] # Array of each vote cast
		get_votes
		get_results
		@percent      = get_percent_of_vote
	end

	private

	def get_candidates
		@voters.select{ |voter| voter.class == Politician }
	end

	# Add each citizen's vote to an array
	def get_votes
		@voters.each{ |voter| @votes << voter.vote(@candidates) }
	end

	# Count votes for each candidate to determine winner
	# In the event of a tie, the politician who existed first wins
	def get_results
		puts ""
		winner = nil
		@candidates.each do |candidate|
			@winner ||= candidate
			@winner   = candidate if @votes.count(candidate) > @votes.count(@winner)
			sleep(1)
			puts "#{candidate.name} has #{@votes.count(candidate)} votes."
		end
		sleep(1)
		puts "\n#{@winner.name} won the election!"
	end

	# Percentage of votes for election winner out of total votes cast
	def get_percent_of_vote
		(@votes.count(@winner).to_f / @votes.count.to_f * 100).round
	end

end