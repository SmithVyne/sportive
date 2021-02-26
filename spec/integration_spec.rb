require 'rails_helper'

RSpec.describe 'login followed by logout', type: :feature do
  # The user must exist so we are creating it here
  let(:user) { User.create(name: 'maruk') }

  scenario 'login page' do
    # First we need to be in the root path
    visit articles_path
    # Secondly fill in the fields in this case only the username
    fill_in 'user_name', with: user.name
    # Third we have to click the Log in button
    click_button 'LOGIN / SIGNUP'
    # We give it some time to load
    sleep(3)
    # Logging out it's much simplier after this
    click_on 'LOGOUT'
    sleep(3)
    expect(page).to have_content('Login')
  end
end

RSpec.describe 'Article management', type: :feature do
  # We need to create an user to authenticate
  let(:user) { User.create(name: 'marukas') }

  scenario 'Create valid work' do
    # First we need to be in the root path
    visit articles_path
    # Secondly fill in the fields in this case only the username
    fill_in 'user_name', with: user.name
    # Third we have to click the Log in button
    click_button 'LOGIN / SIGNUP'
    # We give it some time to load
    sleep(3)

    # if succesfull we'll be in the main page
    expect(page).to have_content('NEW ARTICLE')
    click_link 'NEW ARTICLE'

    sleep(3)

    # Enter article things
    fill_in 'article_title', with: 'Messi the great!'
    fill_in 'article_text', with: 'Football cannot leave any day without messi because he is a great plaaaayer!'

    # click on the Post button
    click_button 'Post Article'
    # We let the page load for a while
    sleep(3)

    # If everything went well it's expecting the success message to display on screen
    expect(page).to have_content('NEW ARTICLE')
  end
end
