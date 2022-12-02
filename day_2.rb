# frozen_string_literal: true

input = ::File.readlines('inputs/day_2.txt')

GUESSED_SCORING = {
  "A X" => 4, # Rock & Draw
  "A Y" => 8, # Paper & Win
  "A Z" => 3, # Scissors & Loss
  "B X" => 1, # Rock & Loss
  "B Y" => 5, # Paper & Draw
  "B Z" => 9, # Scissors & Win
  "C X" => 7, # Rock & Win
  "C Y" => 2, # Paper & Loss
  "C Z" => 6, # Scissors & Draw
}

score = input.map { |line| GUESSED_SCORING[line.strip] }.sum
puts "Your score according to the guide in part 1: #{score}"

# Because we now need to follow the guide for part two, we need to update the mapping.
SCORING = {
  "A X" => 3, # Scissors & Loss
  "A Y" => 4, # Rock & Draw
  "A Z" => 8, # Paper & Win
  "B X" => 1, # Rock & Loss
  "B Y" => 5, # Paper & Draw
  "B Z" => 9, # Scissors & Win
  "C X" => 2, # Paper & loss
  "C Y" => 6, # Scissors & Draw
  "C Z" => 7, # Rock & Win
}

score = input.map { |line| SCORING[line.strip] }.sum
puts "Your score according to the guide in part 2: #{score}"
