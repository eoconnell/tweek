require 'sinatra'

get '/leaderboard' do
  (1..10).collect do |n|
    { name: "user#{n}", score: 100 - n }
  end
end

post '/score' do
  user = params['user']
  score = params['score']
  "#{user} #{score}"
end
