require 'sinatra'
require 'sinatra/cross_origin'
require 'json'
require 'sequel'

configure do
  DB = Sequel.connect(ENV["DATABASE_URL"] || "sqlite://db.sqlite3")
  DB.create_table? :scores do
      primary_key :id
      String :name
       Float :score
  end

  enable :cross_origin
end

set :allow_origin, :any
set :allow_methods, [:get, :post, :options]
set :expose_headers, ['X-PINGOTHER', 'Content-Type']

class Score < Sequel::Model
end

options '*' do
  200
end

post '/score' do
  body = JSON.parse request.body.read
  user = body['user']
  score = body['score']
  Score.create(name: user, score: score)
  status 201
end

get '/leaderboard' do
  content_type :json
  Score.order(:score).reverse.limit(10).naked.all.to_json
end
