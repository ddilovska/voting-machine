require 'yaml/store'
require 'sinatra'

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
  
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    if @store['votes'] == nil
      @store['votes'] = {}
    end

    @store['votes'][@vote] = @store['votes'].fetch(@vote, 0) + 1
  end
  
  erb :cast
end

get '/results' do
  @title = 'Резултати'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end

get '/reset' do
   @store = YAML::Store.new 'votes.yml'
   @store.transaction do
       if @store['votes'] !=nil
           @store['votes'] = {}
       end
   end
      redirect '/results'
end