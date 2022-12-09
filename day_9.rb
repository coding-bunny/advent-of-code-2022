# frozen_string_literal: true

require 'readline'

class Knot
  attr_accessor :x, :y, :visited_positions, :name

  def initialize(x, y, name)
    @x = x.to_i
    @y = y.to_i
    @name = name
    @visited_positions = { key => 1 }
  end
  def move_up
    @y += 1
    update_visited_positions
  end

  def move_down
    @y -= 1
    update_visited_positions
  end

  def move_left
    @x -= 1
    update_visited_positions
  end

  def move_right
    @x += 1
    update_visited_positions
  end

  def key
    "#{@x}, #{@y}"
  end

  def update_visited_positions
    @visited_positions.key?(key) ? @visited_positions[key] += 1 : @visited_positions[key] = 1
  end
end

head_movements = ::File.readlines('inputs/day_9.txt', chomp: true)
# head_movements = ::File.readlines('inputs/day_9.test1.txt', chomp: true)
# head_movements = ::File.readlines('inputs/day_9.test2.txt', chomp: true)
head_position = ::Knot.new(1, 1, 'head')
tail_position = ::Knot.new(1, 1, 'tail')

def move_knot(head, tail)
  # Don't move the tail if it's touching diagonally the head still
  return if touching_diagonally?(tail, head)

  # Can we just move left/right to touch the head?
  if tail.y == head.y
    tail.x > head.x ? tail.move_left : tail.move_right
    return
  end

  # Can we just move up/down to touch the head?
  if tail.x == head.x
    tail.y > head.y ? tail.move_down : tail.move_up
    return
  end

  # == Move diagonally to touch the head again ==
  # In this case jump manually to not record the intermediate jumps and save the final position.
  # However we need to figure out what jumps makes most sense: e.g which jump is the smallest.
  jump_horizontally(tail, head)
  jump_vertically(tail, head)

  tail.update_visited_positions
end

def jump_horizontally(tail, head)
  if tail.x > head.x
    tail.x -= 1
  else
    tail.x += 1
  end
end

def jump_vertically(tail, head)
  if tail.y > head.y
    tail.y -= 1
  else
    tail.y += 1
  end
end

def touching_diagonally?(tail, head)
  (tail.y - head.y).abs <= 1 && (tail.x - head.x).abs <= 1
end

head_movements.each do |movement|
  direction, steps = movement.split(' ')

  steps.to_i.times do
    case direction
    when 'D'
      head_position.move_down
    when 'L'
      head_position.move_left
    when 'R'
      head_position.move_right
    when 'U'
      head_position.move_up
    else
      puts "The direction '#{direction}' is unknown"
    end

    # == Now figure out where the tail needs to move to ==
    move_knot(head_position, tail_position)
  end
end

puts "The tail visited #{tail_position.visited_positions.keys.length} positions at least once"

## PART 2
head = ::Knot.new(1, 1, 'H')
one = ::Knot.new(1, 1, '1')
two = ::Knot.new(1, 1, '2')
three = ::Knot.new(1, 1, '3')
four = ::Knot.new(1, 1, '4')
five = ::Knot.new(1, 1, '5')
six = ::Knot.new(1, 1, '6')
seven = ::Knot.new(1, 1, '7')
eight = ::Knot.new(1, 1, '8')
nine = ::Knot.new(1, 1, '9')

head_movements.each do |movement|
  direction, steps = movement.split(' ')

  steps.to_i.times do
    case direction
    when 'D'
      head.move_down
    when 'L'
      head.move_left
    when 'R'
      head.move_right
    when 'U'
      head.move_up
    else
      puts "The direction '#{direction}' is unknown"
    end

    # == Now figure out where the tail needs to move to ==
    move_knot(head, one)
    move_knot(one, two)
    move_knot(two, three)
    move_knot(three, four)
    move_knot(four, five)
    move_knot(five, six)
    move_knot(six, seven)
    move_knot(seven, eight)
    move_knot(eight, nine)
  end
end

puts "The tail visited #{nine.visited_positions.keys.length} positions at least once"
