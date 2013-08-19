require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require "pg"

get '/' do
  query = "SELECT * from friendsdetails"
  conn = PG.connect(:dbname => 'friends', :host => 'localhost')
  binding.pry
  @result = conn.exec(query)
  conn.close
  erb :listfriends
end

get '/new' do
  query = "SELECT name from friendsdetails"
  conn = PG.connect(:dbname => 'friends', :host => 'localhost')
  @result = conn.exec(query)
  conn.close
  binding.pry
  erb :addfriend
end

get '/new' do
  @name = params[:name]
  @age = params[:age]
  @gender = params[:gender]
  @imgurl = params[:imgurl]
  @socialurl = params[:socialurl]
  if (@name.nil? || @name == '')
    @message = '' # put in logic to display an image and say this movie does not exist.
  else
      friendadd = "INSERT INTO friendsdetails (name,age,gender,imgurl,socialurl)
      values ('#{@name}', '#{@age}', '#{@gender}', '#{@imgurl}','#{@socialurl}')";
      conn = PG.connect(:dbname => 'friends', :host => 'localhost')
      conn.exec(friendadd)
      conn.close
      binding.pry
  end
  redirect to ('/')
end


