require 'sinatra'
require 'sinatra/reloader'

class WebGuesser
  attr_accessor :number

  def initialize
    @number = rand(100)
    @count = 5
  end

  def find_message(guess, cheat = nil)
    if @count.zero?
      @count = 5
      @number = rand(100)
      "You have lost! A new number has been generated"
    elsif guess == nil
      if cheat == 'true'
        "Enter a guess<br>  The SECRET NUMBER is #{number}"
      else
        "Enter a guess"
      end
    elsif guess.to_i > number && guess.to_i > number + 5
      @count -= 1
      if cheat == 'true'
        "Way too high! <br> The SECRET NUMBER is #{number}"
      else
        "Way too high!"
      end
    elsif guess.to_i > number
      @count -= 1
      if cheat == 'true'
        "Too high! <br> The SECRET NUMBER is #{number}"
      else
        "Too high!"
      end
    elsif guess.to_i < number && 5 + guess.to_i < number
      @count -= 1
      if cheat == 'true'
        "Way too low! <br> The SECRET NUMBER is #{number}"
      else
        "Way too low!"
      end
    elsif guess.to_i < number
      @count -= 1
      if cheat == 'true'
        "Too Low! <br> The SECRET NUMBER is #{number}"
      else
        'Too low!'
      end
    else
      correct = number
      @number = rand(100)
      @count = 5
      "You got it right! <br> The SECRET NUMBER is #{correct} <br> A new number has been generated."
    end
  end

  def find_color(guess = nil)
    if guess == nil
      'white'
    elsif guess.to_i > number && guess.to_i > number + 5
      'red'
    elsif guess.to_i > number
      '#E8ADAA'
    elsif guess.to_i < number && 5 + guess.to_i < number
      'red'
    elsif guess.to_i < number
      '#E8ADAA'
    else
      'green'
    end
  end
end

wg = WebGuesser.new

get '/' do
  guess = params["guess"]
  cheat = params["cheat"]

  erb :index, :locals => { :color => wg.find_color(guess),
                           :message => wg.find_message(guess, cheat)
                          }
end
