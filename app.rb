require 'sinatra/base'
require './lib/user'
require './lib/weapon'
require './lib/computer'
require './lib/game'

class RPS < Sinatra::Base
  enable :sessions

  get '/' do
    erb(:index)
  end

  post '/name' do
    $user = User.new(params[:user_name])
    redirect '/weapon'
  end

  get '/weapon' do
    @user = $user
    erb(:weapon)
  end

  post '/play' do
    user = $user
    $weapon = Weapon.new(params[:weapon_type])
    $computer = Computer.new
    $game = Game.new($weapon.type, $computer.weapon_choice)
    redirect '/game'
  end

  get '/game' do
    @game = $game
    @user = $user
    @computer = $computer
    erb(:game)
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
