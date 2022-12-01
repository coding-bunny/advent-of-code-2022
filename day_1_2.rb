# frozen_string_literal: true

elves = {}
counter = 1
inputs = open('inputs/day_1_1.txt') { |file| file.readlines }

inputs.each do |input|
  calories = input.to_i

  if calories == 0
    counter += 1
    next
  else
    elves[counter] ||= 0
    elves[counter] += calories
  end
end

sorted_elves = elves.sort_by {|_key, value| value}.to_h

last_keys = sorted_elves.keys.last(3)
last_values = sorted_elves.values.last(3)

puts "The top three elves are: #{last_keys}, carrying #{last_values.sum} Kcal"
