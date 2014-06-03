module Validations

	# Get value with validation from an array of values
	def gets_from_values(array_of_values, options = {})
		if array_of_values.class == Array
			error = nil
			loop do
				puts error if error
				puts ""
				puts options[:prompt] if options[:prompt]
				input = options[:as_sym] ? gets_alpha.downcase.to_sym : gets_alpha
				return input if array_of_values.include? input
				error = "Didn't catch that.  Try again."
			end
		end
	end

	# Update value with validation, if necessary
	def update(to_update, options={})
		before_update = to_update
		if options[:values]
			to_update = gets_from_values(options[:values], prompt: options[:prompt])
		else
			puts options[:prompt]
			to_update = gets_alpha
		end
		puts "#{before_update} has been updated to #{to_update}."
		return to_update
	end

	# Get user input, strip it of all non-alphabet characters
	# Capitalize each word
	def gets_alpha
		gets.chomp.gsub(/[^a-z ]/i, '').split.map(&:capitalize).join(' ')
	end

end



# Voting rules for voting citizens
# Needs to be refactored, badly
module VotingMethods
	def vote(candidates)
		super
		# Sort candidates by party
		republicans = candidates.select { |whose| whose.party == "Republican" }
		democrats   = candidates.select { |whose| whose.party == "Democrat" }

		# Determine which party the citizen will vote for
		party_vote = (rand(1..100) <= liberalness) ? "Democrat" : "Republican"

		# Randomly select a candidate from the voting party,
		# unless a candidate from that party doesn't exist
		voted_for = if republicans.any? && democrats.any?
			case party_vote
			when "Democrat"   then democrats.sample
			when "Republican" then republicans.sample
			end
		else
			candidates.sample
		end

		puts "#{@name} (#{@politics}) just voted for #{voted_for.name} (#{voted_for.party})!"
		return voted_for
	end

	def liberalness
		case @politics
		when "Tea Party"    then 10
		when "Conservative" then 25
		when "Neutral"      then 50
		when "Liberal"      then 75
		when "Socialist"    then 90
		end
	end
end