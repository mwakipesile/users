require 'yaml'
require 'tilt/erubis'
require 'sinatra'
require 'sinatra/reloader'

before do 
  @users_db = YAML.load_file('users.yaml')
  @title = 'Users and Interests'
end

get '/' do
  redirect('/users')
end

not_found do
  redirect('/users')
end

get '/users' do
  @names = @users_db.keys.map { |username| username.to_s.capitalize }

  erb :users
end

get '/users/:name' do |name|
  username = name.downcase.to_sym
  @name = name.capitalize
  @email = @users_db[username][:email]
  @interests = @users_db[username][:interests]

  erb :user_page
end