class City
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
  end

  define_singleton_method(:all) do
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each() do |city|
      name = city.fetch("name")
      id = city.fetch("id").to_i()
      cities.push(City.new({:name => name, :id => id}))
    end
    cities
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM cities WHERE id = #{@id};")
    @name = result.first().fetch("name")
    City.new({:name => @name, :id => @id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_city|
    self.name().==(another_city.name()).&(self.id().==(another_city.id()))
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{self.id()};")

    attributes.fetch(:train_ids, []).each() do |train_id|
      DB.exec("INSERT INTO trains_cities (train_id, city_id) VALUES (#{train_id}, #{self.id()});")
    end
  end

  define_method(:trains) do
    cities_trains = []
    results = DB.exec("SELECT train_id FROM trains_cities WHERE city_id = #{self.id()};")
    results.each() do |result|
      train_id = result.fetch("train_id").to_i()
      train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")
      name = train.first().fetch("name")
      cities_trains.push(Train.new({:name => name, :id => train_id}))
    end
    cities_trains
  end

end
