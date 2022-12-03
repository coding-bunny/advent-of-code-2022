# frozen_string_literal: true

# Load all the lines from the input for each
bag_contents = ::File.readlines('inputs/day_3.txt', chomp: true)
PRIORITY = (('a'..'z').to_a + ('A'..'Z').to_a).freeze

priorities = bag_contents.map do |bag|
  # Get the bag compartments
  compartment_one, compartment_two = bag.chars.each_slice((bag.size / 2).round).to_a

  # Get union of common items, removing duplicate entries
  union_of_items = (compartment_one & compartment_two).uniq

  # map and return the sum of priorities
  union_of_items.map { |item| PRIORITY.find_index(item) + 1 }.sum
end

puts "The sum of all priorities for part 1: #{priorities.sum}"

# Part 2 Calculations
priorities = 0

# Loop over the bag_contents per 3 entries, so we process those lines
bag_contents.each_slice(3) do |bags|
  # Split the three bags array into individual arrays
  bag_one, bag_two, bag_three = bags

  # Get union of common items, removing duplicate entries
  union_of_items = (bag_one.chars & bag_two.chars & bag_three.chars).uniq

  # map and return the sum of priorities, adding it to our counter
  priorities += union_of_items.map { |item| PRIORITY.find_index(item) + 1 }.sum
end

puts "The sum of all priorities for part 2: #{priorities}"