require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array('A'..'Z').sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split
    @included = included?(@word.upcase, @letters)
    @english_word = english_word?(@word)

    if @included && @english_word
      result = "Congratulations! #{@word.upcase} is a valid English word!"
    elsif !@included
      result = "Sorry but #{@word.upcase} can't be built from #{@letters.join(', ')}"
    else
      result = "Sorry but #{@word.upcase} is not a valid English word"
    end

    redirect_to result_game_path(word: @word.upcase, result: result), status: :see_other
  end

  def result
    @word = params[:word]
    @result = params[:result]
  end

  private

  def included?(word, letters)
    word.chars.all? { |char| word.count(char) <= letters.count(char) }
  end

  def english_word?(word)
    url = "https://dictionary.lewagon.com/#{word.downcase}"
    response = URI.open(url).read
    json = JSON.parse(response)
    json['found']
  end
end
