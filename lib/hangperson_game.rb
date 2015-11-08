class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    raise ArgumentError if not letter =~ /^[[:alpha:]]$/
    letter.downcase!
    if @word.include? letter
      # Abort operation if letter was already guessed
      return false if @guesses.include? letter
      @guesses << letter
    else
      return false if @wrong_guesses.include? letter
      @wrong_guesses << letter
    end
  end
  
  def word_with_guesses
    result = ''
    @word.each_char do |char|
      if @guesses.include? char
        result<<char
      else
        result<<'-'
      end
    end
    result
  end
  
  def check_win_or_lose
    win_flag = true
    @word.each_char do |char|
      win_flag=false if not @guesses.include? char
    end
    return :win if win_flag
    return :lose if @wrong_guesses.size>=7
    :play
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
end
