# frozen_string_literal: true

# Input the commands from the source file
operations = ::File.readlines('inputs/day_7.txt', chomp: true)

# This structure represents a directory, and tracks its children, as well as the size and its parent.
Struct.new('Directory', :name, :children, :parent) do
  # Returns the size of the current directory, calculating recursively the size of all files and sub directories
  # @return Numeric The size of the current directory.
  def size
    files = children.select { |c| c.is_a?(::Struct::File) }
    files.map(&:size).sum + sub_dirs.map(&:size).sum
  end

  # Returns all sub directories from its children
  # @return Array All ::Struct::Directory objects that have this as parent
  def sub_dirs
    children.select { |c| c.is_a?(::Struct::Directory) }
  end
end

# Simple struct to track files
Struct.new('File', :name, :size)

# Root is the root of our system and keep a pointer to it as well.
ROOT = ::Struct::Directory.new('/', [], nil)
$current_directory = ROOT

# Loop over all operations and mimic the behavior we did on the device.
operations.each do |line|
  # Check if the line is a command, and execute it.
  if line.start_with?('$')
    command, args = line.delete('$').strip.split(' ')

    # We only care about "cd" commands, everything else is not important for us at this point.
    next unless command == 'cd'

    # If we we're jumping back to the root folder, update our pointer.
    if args == '/'
      $current_directory = ROOT
    # If we are jumping back to our parent directory, update the pointer
    elsif args == '..'
      $current_directory = $current_directory.parent
    else
      # check if the child we are jumping into exists in our structure.
      child = $current_directory.children.select { |child| child.is_a?(::Struct::Directory) && child.name == args }.first

      # Create the missing child
      if child.nil?
        child = ::Struct::Directory.new(args, [], $current_directory)
        $current_directory.children << child
      end

      # Update the reference
      $current_directory = child
    end
  else
    # In this case we need to parse the output, and add it to the correct structure.
    size, type = line.split(' ')

    next if size == 'dir' # Don't care about directory listings

    $current_directory.children << ::Struct::File.new(type, size.to_i)
  end
end

# Now that we have the structure, let's find the children that have a size below 100000
def get_children(directory)
  dirs = []

  dirs << directory if directory.size < 100000
  dirs << directory.sub_dirs.map { |dir| get_children(dir) }

  dirs
end

puts "sum of all directories below 100000: #{get_children(ROOT).flatten.sum { |c| c.size }}"

SYSTEM_SIZE = 70000000
REQUIRED_SIZE = 30000000
FREE_SIZE = SYSTEM_SIZE - ROOT.size
SIZE_TO_DELETE = REQUIRED_SIZE - FREE_SIZE

# Flattens all directories into a single array
def get_all_children(directory)
  dirs = directory.sub_dirs.map { |dir| get_all_children(dir) }
  dirs << directory unless directory.name == "/"
  dirs.flatten
end

directory = get_all_children(ROOT).sort_by(&:size).select { |c| c.size >= SIZE_TO_DELETE }.first
puts "smallest deletable directory to free enough space: #{directory.name} - #{directory.size}"
