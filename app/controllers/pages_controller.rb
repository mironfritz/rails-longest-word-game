require 'open-uri'
require 'json'

class PagesController < ApplicationController
  def get_input
    alphabet = ('A'..'Z').to_a
    @grid = alphabet.sample(10)
  end

  def show_result
    # @start_time = params[:start_time].to_datetime
    # @end_time = Time.now
    @attempt = params[:attempt]
    @grid = JSON.parse(params[:grid])
    filepath = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    file = open(filepath).read

    wagon_dictionary = JSON.parse(file)
    @result = { score: 0, message: '' }

    if wagon_dictionary['found'] == false
      @result[:score] = 0
      @result[:message] = 'Not an english word!'
    elsif !(@attempt.upcase.chars - @grid).empty?
      @result[:score] = 0
      @result[:message] = 'Not in the grid!'
    elsif !used_letters_check?
      @result[:score] = 0
      @result[:message] = 'Not enough letters!'
    else
      @result[:score] = wagon_dictionary['length']
      @result[:message] = 'Well done!'
    end
    @result
  end

  def used_letters_check?
    attempt_array = @attempt.upcase.chars
    attempt_array.each do |letter|
      if attempt_array.count(letter) == @grid.count(letter)
        true
      else
        false
      end
    end
  end
end
