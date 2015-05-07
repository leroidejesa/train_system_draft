require("rspec")
require("pg")
require("city")
require("train")

DB = PG.connect({:dbname => "train_system"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM cities *;")
    DB.exec("DELETE FROM trains *;")
  end
end
