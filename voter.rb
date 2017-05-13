require 'sinatra'

votes = {}

get '/' do
  images = [
     "https://strictlyboardrm.files.wordpress.com/2014/12/fun.gif",
     "http://funandsunbg.com/wp-content/uploads/2015/03/logo.png"
      ]
  prng1 = Random.new()
  @my_image = images[prng1.rand(2)]
  erb :index
end

get '/about' do
  "Страничка за гласуване за следващото ВАЖНО събитие, организирано от милейди ЛЦ за любимите и приятелки."
end


get '/cast' do
  @title = 'Благодарим за вашия глас!'
  @vote  = params['vote']
  
  votes[@vote] = votes.fetch(@vote, 0) + 1
  
  erb :cast
end

get '/results' do
  @title = 'Резултати'
  @votes = votes
  erb :results
end