require 'sinatra'
require 'sinatra/activerecord'
require 'Haml'
require 'bundler/setup'
require 'sinatra/base'
require 'rack-flash'
require './models'
 
enable :sessions
use Rack::Flash
set :sessions => true
set :database, "sqlite3:exercise01_app.sqlite3"

 helpers do
	 def current_user
	    session[:user_id].nil? ? nil : User.find(session[:user_id])
		 #   if session[:user_id].nil?
			#  nil 
		 # else
		 #  User.find(session[:user_id])
		 # end
	 end

	  def title
	    if @title
	      "#{@title} -- My Post"
	    else
	      "My Blog"
	    end
	  end

 end

get '/' do
  flash[:notice] = 'Welcome to the homepage'
	erb :index
end

get '/sign_up' do
	erb :sign_up
end

post '/sign_up' do
 	# code below shows form collecting data
 	puts 'my params are' + params.inspect
   	@user = User.create(params[:user])
    flash[:notice] = 'New account created'
    session[:user_id] = @user.id
    redirect '/profile'
end

get '/sign_out' do
	session[:user_id] = nil
	flash[:notice] = "You’ve been signed out successfully."
	redirect '/'
end

get '/login' do
	erb :login
end

post '/login' do
#puts 'my params are' + params.inspect

    @user = User.where(username: params[:user][:username]).first
	 if @user
		  if @user.password == params[:user][:password]
		  	session[:user_id] = @user.id
		  	flash[:notice] = "You’ve been signed in successfully."
		  else
		  	flash[:notice] = "There was a problem signing you in."
			end
			redirect "/profile"

	 else 
	 	flash[:notice] = "You need to sign up."
             redirect "/login"
	 end
end

# ---------- This is the code for Posts ----------

get "/profile" do
erb :profile
end	

post "/profile" do
# New Post
#@user = current_user
@post = Post.new(params[:post])
@post.user = current_user

  @new_post = Post.new(params[:post])
  if @post.save
    flash[:notice] = "Yep."
    redirect '/profile'
  else
  	flash[:notice] = "Nope."
    erb :profile
  end

end

# Delete Post
delete "/profile" do
  @post = Post.find(params[:id]).destroy
  erb :profile
end

# ---------- This is the code for Following ----------

# get a user profile by their id
get '/user/:id' do
  @user = User.find(params[:id])
  # erb :profile
end
 
# follow a user example
get '/follow/:id' do
  @relationship = Relationship.new(follower_id: current_user.id, followed_id: params[:id])
  if @relationship.save
    flash[:notice] = "You've successfully followed #{User.find(params[:id]).fname}."
  else
    flash[:alert] = "There was an error following that user."
  end
  redirect back
end

get "/clear" do
session[:user_id] = nil
flash[:notice] = "Session ID has been set to nil. :("
redirect '/'
end 