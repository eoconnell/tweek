require 'sinatra'
require 'json'
require 'sequel'

configure do
  DB = Sequel.connect(ENV["DATABASE_URL"] || "sqlite://db.sqlite3")
  DB.create_table? :scores do
      primary_key :id
      String :name
       Float :score
  end
end

before do
  headers 'Access-Control-Allow-Origin' => '*',
          'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST'],
          'Access-Control-Allow-Headers' => 'Content-Type'
end

set :protection, false

class Score < Sequel::Model
end

options '/score' do
  200
end

post '/score' do
  user = params['user']
  score = params['score']
  Score.create(name: user, score: score)
  "saved"
end

options '/leaderboard' do
  200
end

get '/leaderboard' do
  Score.order(:score).reverse.limit(10).naked.all.to_json
end
