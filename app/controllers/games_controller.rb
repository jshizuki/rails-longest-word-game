require 'open-uri'

class GamesController < ApplicationController
  def new
    @vowels = Array.new(3) { %w[A E I O U].sample }
    @consonents = Array.new(7) { (('A'..'Z').to_a - @vowels).sample }
    @random_letters = [@vowels, @consonents].flatten.shuffle
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    data = URI.open(url).read
    @test = JSON.parse(data)

    @check_grid = params[:word].chars.all? { |char| params[:letters].include?(char) }

    if @check_grid && @test['found']
      @result = "Congratulations! #{params[:word]} is a valid English word!"
    elsif @check_grid == false
      @result = "Sorry but #{params[:word]} can't be built out of #{params[:letters]}"
    elsif @check_grid && @test['found'] == false
      @result = "Sorry but #{params[:word]} does not seem to be a valid English word"
    end
  end
end
