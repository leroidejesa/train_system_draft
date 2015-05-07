class Stop
attr_reader(:time,:id)
  define_method(:initialize) do |attributes|
    @time = attributes[:time]
    @id = attributes[:id]

    define_singleton_method(:all) do
      returned_stops = DB.exec("SELECT * FROM stops;")
      stops = []
      returned_stops.each() do |stop|
        time = stop.fetch("time")
        id = stop.fetch("id").to_i()
        stops.push(Stop.new({:time => time, :id => id}))
      end
      stops
    end
