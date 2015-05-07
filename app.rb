require("sinatra")
require("sinatra/reloader")
require('./lib/train')
also_reload("lib/**/*.rb")
require("./lib/city")
require("pg")

DB = PG.connect({:dbname => "train_system"})

get('/') do
  @trains = Train.all()
  @cities = City.all()
  erb(:index)
end

get('/operators/new') do
  @trains = Train.all()
  @cities = City.all()
  erb(:operator)
end

get('/trains') do
  @trains = Train.all()
  erb(:trains)
end

get('/cities') do
  @cities = City.all()
  erb(:cities)
end

post('/trains') do
  @trains = Train.all()
  train_name = params.fetch('train_name')
  new_train = Train.new({:name => train_name, :id => nil})
  new_train.save()
  erb(:success)
end

post('/cities') do
  @cities = City.all()
  city_name = params.fetch('city_name')
  new_city = City.new({:name => city_name, :id => nil})
  new_city.save()
  erb(:success)
end

get("/trains/:id") do
  @train = Train.find(params.fetch("id").to_i())
  @cities = City.all()
  erb(:user_train_info)
end

get("/operator_trains/:id") do
  @train = Train.find(params.fetch("id").to_i())
  @cities = City.all()
  erb(:train_info)
end

get("/operator_cities/:id") do
  @city = City.find(params.fetch("id").to_i())
  @trains = Train.all()
  erb(:city_info)
end

patch("/trains/:id") do
  train_id = params.fetch("id").to_i()
  @train = Train.find(train_id)
  city_ids = params.fetch("city_ids")
  @train.update({:city_ids => city_ids})
  @cities = City.all()
  erb(:train_info)
end

patch("/cities/:id") do
  city_id = params.fetch("id").to_i()
  @city = City.find(city_id)
  train_ids = params.fetch("train_ids")
  @city.update({:train_ids => train_ids})
  @trains = Train.all()
  erb(:city_info)
end

get("/cities/:id") do
  @city = City.find(params.fetch("id").to_i())
  @trains = Train.all()
  erb(:user_city_info)
end
