require 'sinatra'
require 'sinatra/reloader'

set :number, rand(100)

get '/' do
  guess = params["guess"]
  message = check_guess(guess)
  erb :index, :locals => {:number => number, :message => message}
end

def number
  settings.number
end

def check_guess(guess)
  if guess == nil
    "Enter a guess"
  elsif guess.to_i > number && guess.to_i > number + 5
    "Way too high!"
  elsif guess.to_i > number
    "Too high!"
  elsif guess.to_i < number && 5 + guess.to_i < number
    "Way too low!"
  elsif guess.to_i < number
    'Too low!'
  else
    "You got it right! \nThe SECRET NUMBER is #{number}"
  end
end
