require 'sinatra'
require 'json'

get '/leaderboard' do
  (1..10).collect do |n|
    { name: "user#{n}", score: 100 - n }
  end.to_json
end

post '/score' do
  user = params['user']
  score = params['score']
  "#{user} #{score}"
end
