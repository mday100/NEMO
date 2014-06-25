require 'sinatra'
require 'sinatra/activerecord'
require './models'

set :database, "sqlite3:exercise01_app.sqlite3"

get '/' do
	User.create
	@user = User.last
	erb :index
end

get '/users' do
	User.create(name: params[:name]) if params[:name]
	# if params[:name]
	# 	User.create(name: params[:name])
	# end
	@user = User.last
	erb :users
end

get '/counter' do
	#create an new user and set the user's name to their id
	# example: fname: "User 2"
	new_id = User.last.id + 1
	new_name = "User #{new_id}"
	User.create(name: new_name)
	@user = User.last
	erb :users
end


