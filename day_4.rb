# frozen_string_literal: true

# Load all the sections
assignments = ::File.readlines('inputs/day_4.txt', chomp: true)
complete_overlap = 0
partial_overlap = 0

# When do ranges overlap completely?
# When both the end and start of a range falls within the other, in both directions
def ranges_overlap?(range_a, range_b)
  return true if range_a.begin >= range_b.begin && range_a.end <= range_b.end
  return true if range_b.begin >= range_a.begin && range_b.end <= range_a.end
  false
end

# Loop over each assignment, and determine whether the pair has overlapping sectors.
assignments.each do |assignment|
  # convert each assignment into a Range, so we can determine whether they overlap.
  one, two = assignment.split(',')
  one = Range.new(*one.split('-').map { |d| Integer(d) })
  two = Range.new(*two.split('-').map { |d| Integer(d) })

  # Now that we have both sections as a Ruby range we can verify if there's complete overlap or partial overlap
  complete_overlap += 1 if ranges_overlap?(one, two)
  partial_overlap += 1 if one.cover?(two.first) || two.cover?(one.first)
end

puts "There are #{complete_overlap} assignments that completely overlap"
puts "There are #{partial_overlap} assignments that partially overlap"
