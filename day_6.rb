# frozen_string_literal: true

cryptic_message = ::File.readlines('inputs/day_6.txt', chomp: true).first

# This method loops over the provided message and searches for the amount of unique characters in sequence.
# When found, it returns the amount of processed characters for finding the marker.
def find_marker(amount, message)
  buffer = []
  processed_characters = 0

  # Loop over each character, and check the situation for the packet we're trying to discover.
  # At each loop iteration, we assume the buffer doesn't contain the marker yet
  message.chars.each do |char|
    processed_characters += 1 # Keep track of the character being processed.

    # If the character is in the buffer, pop out all proceeding characters from the matching character,
    # including the match from the buffer, because we're looking for unique amount sequence characters in our string
    if buffer.include?(char)
      buffer = buffer[(buffer.index(char) + 1)..]
    end

    # Add the character the the buffer, and break if we found the marker.
    # The marker is found when we have the required non-repeating characters in the buffer.
    buffer << char
    break if buffer.length == amount
  end

  processed_characters
end

puts "start-of-packet-marker processed characters: #{find_marker(4, cryptic_message)}"
puts "start-of-message-marker processed characters: #{find_marker(14, cryptic_message)}"
