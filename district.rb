class District

	attr_accessor :citizens, :elections

	MENU_OPTIONS  = [:create, :list, :update, :vote, :history, :delete] # All possible options
	CITIZEN_TYPES = [:politician, :person] # All possible options

	def initialize
		@citizens, @elections = [], []
	end

	def main_menu
		prompt = "What would you like to do? Create, List, Update, Delete, Vote, or History?"
		case gets_from_values(MENU_OPTIONS, prompt: prompt, as_sym: true)
		when :create  then create_citizen
		when :list    then list_citizens
		when :update  then update_citizen
		when :vote    then begin_election
		when :history then view_election_history
		when :delete  then delete_citizen
		end
		main_menu
	end

	private
	def create_citizen
		prompt = "What would you like to create? Politician or Person?"
		@citizens << case gets_from_values(CITIZEN_TYPES, prompt: prompt, as_sym: true)
		when :person     then Person.new
		when :politician then Politician.new
		end
	end

	# Return list of all citizens, sorted by Voter ID
	def list_citizens
		puts ""
		@citizens.each do |citizen|
			print "#{citizen.voter_id}\t#{citizen.class}, #{citizen.name}, "
			puts case citizen
			when Person     then citizen.politics
			when Politician then citizen.party
			end
		end
		puts "No citizens yet!" if @citizens.none?
	end

	# Update citizen by Voter ID if Voter ID exists
	def update_citizen
		if @citizens.any?
			voter_id = get_voter_id
			if citizen = @citizens.select{ |whose| whose.voter_id == voter_id }.pop
				citizen.update_name	
				case citizen
				when Person     then citizen.update_politics
				when Politician then citizen.update_party	
				end
			else
				puts "Citizen not found!"
			end
		else
			puts "No citizens yet!"
		end
	end

	# Delete citizen by Voter ID if Voter ID exists
	def delete_citizen
		if @citizens.any?
			voter_id = get_voter_id
			deleted  = @citizens.delete_if{ |citizen| citizen.voter_id == voter_id}
			puts deleted ? "Citizen deleted." : "Citizen not found!"
		else
			puts "No citizens yet!"
		end
	end

	def get_voter_id
		puts ""
		puts "Voter ID?"
		gets.chomp.to_i
	end

	# Run election if at least one politician exists
	def begin_election
		if @citizens.select{ |whose| whose.class == Politician }.any?
			@elections << Election.new(@citizens)
		else
			puts "There are no politicians!"
		end
		main_menu
	end

	# Display all previous winners along with election stats if any elections exist
	def view_election_history
		puts ""
		@elections.each do |election|
			print "Term #{election.term}: #{election.winner.name}, #{election.winner.party} "
			puts "(#{election.percent}% of vote, #{election.candidates.size} ran, #{election.total_voters} citizens voted)"
		end
		puts "No elections yet!" if @elections.none?
		main_menu
	end

end