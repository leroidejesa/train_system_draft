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
