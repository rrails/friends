require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require "pg"

get '/' do
  query = "SELECT * from friendsdetails"
  conn = PG.connect(:dbname => 'friends', :host => 'localhost')
  @result = conn.exec(query)
  binding.pry
  conn.close
  erb :listfriends
end

get '/new' do
  query = "SELECT name from friendsdetails"
  conn = PG.connect(:dbname => 'friends', :host => 'localhost')
  @result = conn.exec(query)
  conn.close
  erb :addfriend
end

post '/new' do
  @name = params[:name]
  @age = params[:age]
  @gender = params[:gender]
  @photo = params[:photo]
  @facebook = params[:facebook]
  binding.pry
  if (@name.nil? || @name == '')
    @message = '' # put in logic to display an image and say this movie does not exist.
  else
      friendadd = "INSERT INTO friendsdetails (name,age,gender,photo,facebook)
      values ('#{@name}', '#{@age}', '#{@gender}', '#{@photo}','#{@facebook}')";
      conn = PG.connect(:dbname => 'friends', :host => 'localhost')
      conn.exec(friendadd)
      conn.close
  end
  redirect to ('/new')
end


