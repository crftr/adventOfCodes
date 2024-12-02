class PassphraseVerifier

  def initialize(input_file = './input.txt')
    @file = input_file
  end

  def number_of_valid_phrases(strict = false)
    valid_phrases = 0

    File.open(@file, 'r') do |f|
      f.each_line do |line|

        @words = line.split(/\s/)
        @words.map! { |w| w.chars.sort.join } if strict

        valid_phrases += 1 if has_no_duplicate_words
      end
    end

    valid_phrases
  end

  private

  def has_no_duplicate_words
    @words.count == @words.uniq.count
  end
end

puts "Part 1: #{PassphraseVerifier.new.number_of_valid_phrases}"
puts "Part 2: #{PassphraseVerifier.new.number_of_valid_phrases(true)}"