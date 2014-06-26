require 'sinatra'
require 'sinatra/activerecord'
require 'Haml'
require 'bundler/setup'
require 'sinatra/base'
require 'rack-flash'
require './models'
 
# enable :sessions
# use Rack::Flash
# set :sessions => true
set :database, "sqlite3:exercise01_app.sqlite3"

# helpers do
#   def current_user
#     session[:user_id].nil? ? nil : User.find(session[:user_id])
#     # if session[:user_id].nil?
#     #   nil 
#     # else
#     #   User.find(session[:user_id])
#     # end
#   end
#   def display_one
#     "1"
#   end
# end

get '/' do
  # flash[:notice] = 'Welcome to the homepage'
	erb :index
  # redirect '/index'
end
get '/sign_up' do
	erb :sign_up
end



 post '/sign_up' do
 	# code below shows form collecting data
 	puts 'my params are' + params.inspect
   @user = User.create(params[:user])
	   if @user
	   	redirect '/'
	   else
	   	puts "error"
	   end
  # flash[:notice] = 'New account created'
  # session[:user_id] = @user.id
  # redirect '/login'
end

get '/login' do
	erb :login
end

post '/login' do

puts 'my params are' + params.inspect

  @user = User.where(params[:user])
	  if @user.password == params[:user][:password]
	  	redirect '/'
	  else
	  	puts "error"
	  end
end
# # get '/sign_out' do
# #   session[:user_id] = nil
# #   redirect '/'
# # end 


