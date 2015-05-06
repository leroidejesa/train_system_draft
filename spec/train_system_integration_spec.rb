require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)
require('spec_helper')

describe('path to add a new train', {:type => :feature}) do
  it('allows an operator to add a new train') do
    visit('/')
    click_link('Train Operators')
    click_link('Add a train')
    fill_in('train_name', :with =>'MAX White')
    click_button('Add')
    click_link('Home')
    expect(page).to have_content('MAX White')
  end
end

describe('path to add a new city', {:type => :feature}) do
  it('allows an operator to add a new city') do
    visit('/')
    click_link('Train Operators')
    click_link('Add a city')
    fill_in('city_name', :with =>'MAX City')
    click_button('Add')
    click_link('Home')
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
