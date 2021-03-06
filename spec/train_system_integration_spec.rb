require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('spec_helper')

describe('path to add a new train', {:type => :feature}) do
  it('allows an operator to add a new train') do
    visit('/')
    click_link('Click here!')
    click_link('Add a train')
    fill_in('train_name', :with =>'MAX White')
    click_button('Add')
    click_link('Return to main page')
    expect(page).to have_content('MAX White')
  end
end

describe('path to add a new city', {:type => :feature}) do
  it('allows an operator to add a new city') do
    visit('/')
    click_link('Click here!')
    click_link('Add a city')
    fill_in('city_name', :with =>'MAX City')
    click_button('Add')
    click_link('Return to main page')
    expect(page).to have_content('MAX City')
  end
end

describe('path to view train info', {:type => :feature}) do
  it('allows user to view a list of cities where train stops') do
    pickle_train = Train.new({ :name => "pickle train", :id => nil })
    pickle_train.save()
    visit('/')
    click_link('pickle train')
    expect(page).to have_content('pickle train')
  end
end

describe('path to view city info', {:type => :feature}) do
  it('allows user to view a list of trains that stop at that city') do
    pickle_city = City.new({ :name => "pickle city", :id => nil })
    pickle_city.save()
    visit('/')
    click_link('pickle city')
    expect(page).to have_content('pickle city')
  end
end
