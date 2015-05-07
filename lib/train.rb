class Train
  attr_reader(:name,:id,:stop)

  define_method(:initialize) do |attributes|
    @name = attributes[:name]
    @id = attributes[:id]
    @stop = attributes[:stop]
  end

  define_singleton_method(:all) do
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      name = train.fetch("name")
      id = train.fetch("id").to_i()
      trains.push(Train.new({:name => name, :id => id}))
    end
    trains
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM trains WHERE id = #{@id};")
    @name = result.first().fetch("name")
    Train.new({:name => @name, :id => @id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO trains (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_train|
    self.name().==(another_train.name()).&(self.id().==(another_train.id()))
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE trains SET name = '#{@name}' WHERE id = #{self.id()};")
    stop = attributes.fetch(:stop_time, [])
    attributes.fetch(:city_ids, []).each() do |city_id|

      DB.exec("INSERT INTO trains_cities (train_id, city_id, stop_time) VALUES (#{self.id()}, #{city_id}, '#{stop}');")
    end
  end

  define_method(:cities) do
    train_cities = []
    results = DB.exec("SELECT city_id FROM trains_cities WHERE train_id = #{self.id()};")
    results.each() do |result|
      city_id = result.fetch("city_id").to_i()
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id};")
      name = city.first().fetch("name")
      
      train_cities.push(City.new({:name => name, :id => city_id}))
    end
    train_cities
  end

  define_method(:stop_time) do
    train_stop = []
    results = DB.exec("SELECT stop_time FROM trains_cities WHERE train_id = #{self.id()};")
    results.each() do |result|
      city_id = result.fetch("city_id").to_i()
      city = DB.exec("SELECT * FROM t WHERE id = #{city_id};")
      stop_time = result.fetch("")
      train_stop.push(stop_time)
    end
    train_stop
  end

  define_method(:delete) do
      DB.exec("DELETE FROM trains_cities WHERE train_id = #{self.id()};")
      DB.exec("DELETE FROM trains WHERE id = #{self.id()};")
    end
end
