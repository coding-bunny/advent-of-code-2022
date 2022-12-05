# frozen_string_literal: true

# Load the contents of the file
data = ::File.readlines('inputs/day_5.txt', chomp: true)

## We need to split the data into the instructions as well as initial setup so we can parse it.
# We know the setup and instructions are seperated by an empty line.
delimiter_index = data.index('')
setup = data.slice(0, delimiter_index - 1)
instructions = data.slice((delimiter_index + 1)..data.length)

# Now we can first parse out the setup into a Hash so we have something to work with and manipulate.
# The keys can be obtained from the final line of the setup.
keys = data[delimiter_index - 1].split(' ')
yard = keys.map { |key| [key, []] }.to_h
yard_two = yard.dup

# We can hard code the logic here because each line uses the same width, meaning we only need to check
# every nth character, starting a position 1, and jumping 4 characters every single time. and do this 9 times
setup.each do|line|
  9.times do |counter|
    index = 1 + (counter * 4)
    crate = line.chars[index]
    yard[(counter + 1).to_s] << crate unless crate == ' ' || crate.nil?
  end
end

# Now that we reached this point, our "yard" variable contains the entire setup of crates parsed from the file.
# Now we can loop over the instructions and execute them.
instructions.each do |instruction|
  _, amount, _, source, _, target = instruction.split(' ')

  # Take the amount of crates from the source
  crates = yard[source].take(amount.to_i)
  yard[source] = yard[source].drop(amount.to_i)

  # Move them to the destination
  yard[target] = crates.reverse.concat(yard[target])
end

puts "The top crates of each stack are: #{yard.values.map(&:first).join}"

# Now do the same logic for the second operation, but without reversing the logic of the moved crates
instructions.each do |instruction|
  _, amount, _, source, _, target = instruction.split(' ')

  # Take the amount of crates from the source
  crates = yard_two[source].take(amount.to_i)
  yard_two[source] = yard_two[source].drop(amount.to_i)

  # Move them to the destination
  yard_two[target] = crates.concat(yard_two[target])
end

puts "The top crates of each stack are: #{yard_two.values.map(&:first).join}"