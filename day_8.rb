# frozen_string_literal: true

grid = ::File.readlines('inputs/day_8.txt', chomp: true).map { |line| line.chars.map(&:to_i) }
visible_trees = 0

# We're going to loop only over the "internal" grid, ignoring the outer rows and columns of the grid.
# Because we know those always count as visible, so we don't need to bother those.
grid.each_index do |row_index|
  next if row_index == 0 || row_index == (grid.length - 1)

  grid[row_index].each_index do |column_index|
    next if column_index == 0 || column_index == (grid[row_index].length - 1)

    tree = grid[row_index][column_index]

    next if tree == 0 # To speed up the loop

    # Is it visible from the left?
    view_from_left = grid[row_index].slice(0, column_index)
    visible_trees += 1 and next if view_from_left.max < tree

    # Is it visible from the right?
    view_from_right = grid[row_index].slice(column_index + 1, grid[row_index].length - column_index)
    visible_trees += 1 and next if view_from_right.max < tree

    # Is it visible from the top?
    view_from_top = grid.map { |row| row[column_index] }.slice(0, row_index)
    visible_trees += 1 and next if view_from_top.max < tree

    # Is it visible from the top?
    view_from_bottom = grid.map { |row| row[column_index] }.slice(row_index + 1, grid.length - row_index)
    visible_trees += 1 if view_from_bottom.max < tree
  end
end

# Add the outside trees to the count
visible_trees += 2 * grid.length
visible_trees += 2 * (grid.first.length - 2) # Cause the first and last tree got counted already from the previous line

puts "Total amount of visible trees: #{visible_trees}"

###### Part 2 #####
scoring = []

grid.each_index do |row_index|
  scoring[row_index] = []

  grid[row_index].each_index do |column_index|
    tree = grid[row_index][column_index]
    next if tree == 0 # To speed up the loop
    scenic_score = [0, 0, 0, 0]

    # Calculate the score from the left
    trees_to_the_left = grid[row_index].slice(0, column_index).reverse
    trees_to_the_left.each do |t|
      scenic_score[0] += 1
      break if t >= tree
    end

    # Calculate the scores from the right
    trees_to_the_right = grid[row_index].slice(column_index + 1, grid[row_index].length - column_index)
    trees_to_the_right.each do |t|
      scenic_score[1] += 1
      break if t >= tree
    end

    # Is it visible from the top?
    trees_to_the_top = grid.map { |row| row[column_index] }.slice(0, row_index).reverse
    trees_to_the_top.each do |t|
      scenic_score[2] += 1
      break if t >= tree
    end

    # Is it visible from the top?
    trees_to_the_bottom = grid.map { |row| row[column_index] }.slice(row_index + 1, grid.length - row_index)
    trees_to_the_bottom.each do |t|
      scenic_score[3] += 1
      break if t >= tree
    end

    # Calculate and store the score
    scoring[row_index] << scenic_score.reduce(1, :*)
  end
end

puts "Highest Scenic Score: #{scoring.flatten.max}"
