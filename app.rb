require("sinatra")
require("sinatra/reloader")
require('./lib/task')
also_reload("lib/**/*.rb")
require("./lib/list")
require("pg")

DB = PG.connect({:dbname => "todo_test"})
