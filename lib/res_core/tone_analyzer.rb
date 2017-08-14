module ResCore
  class ToneAnalyzer
    attr_accessor :positive_words, :negative_words, :text
    def initialize
      @positive_words = load_words(:positive)
      @negative_words = load_words(:negative)
    end

    def calculate_score text
      positive_words_count = 0
      negative_words_count = 0
      previous_word = ''
      text.scan(/\w+/) do |word|
        positive = positive_words.include? word
        negative = negative_words.include? word
        if previous_word == 'not'
          if positive
            negative = true
            positive = false
          elsif negative
            positive = true
            negative = false
          end
        end
        negative_words_count += 1 if negative
        positive_words_count += 1 if positive
        previous_word = word
      end
      known_words_count = positive_words_count + negative_words_count

      return 50 if positive_words_count == negative_words_count
      return ( (  positive_words_count.to_f / known_words_count.to_f ) * 100).round
    end

    private

    def load_words(kind)
      file_name = File.join(File.dirname(__FILE__), 'tone_analyzer', "#{kind}-words.txt")
      File.readlines(file_name).map(&:strip)
    end
  end
end
