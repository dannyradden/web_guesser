require 'sinatra'
require 'sinatra/reloader'



@@secret = rand(100)
@@count = 5


get '/' do
  guess = params["guess"]
  @cheat = params["cheat"]
  message = check_guess(guess)
  p @cheat
  erb :index, :locals => { :message => message, :color => @color }
end

def number
  @@secret
end

def color(input)
  @color = input
end

def check_guess(guess)
  if @@count == 0
    @@count = 5
    @@secret = rand(100)
    "You have lost! A new number has been generated"
  elsif guess == nil
    color('white')
    if @cheat == 'true'
      "Enter a guess<br>  The SECRET NUMBER is #{@@secret}"
    else
      "Enter a guess"
    end
  elsif guess.to_i > number && guess.to_i > number + 5
    @@count -= 1
    color('red')
    if @cheat == 'true'
      "Way too high! <br> The SECRET NUMBER is #{@@secret}"
    else
      "Way too high!"
    end
  elsif guess.to_i > number
    @@count -= 1
    color('#E8ADAA')
    if @cheat == 'true'
      "Too high! <br> The SECRET NUMBER is #{@@secret}"
    else
      "Too high!"
    end
  elsif guess.to_i < number && 5 + guess.to_i < number
    @@count -= 1
    color('red')
    if @cheat == 'true'
      "Way too low! <br> The SECRET NUMBER is #{@@secret}"
    else
      "Way too low!"
    end
  elsif guess.to_i < number
    @@count -= 1
    color('#E8ADAA')
    if @cheat == 'true'
      "Too Low! <br> The SECRET NUMBER is #{@@secret}"
    else
      'Too low!'
    end
  else
    color('green')
    correct = @@secret
    @@secret = rand(100)
    @@count = 5
    "You got it right! <br> The SECRET NUMBER is #{correct} <br> A new number has been generated."
  end
end
