Given /^I am logged out$/ do
  visit destroy_user_session_url
end

Given /^I am a registered (user|admin)$/ do |user_quality|
  if user_quality == 'admin'
    admin = true
    email = 'admin@cucumber.com'
    password = 'password1234'
  else
    admin = false
    email = 'valid@cucumber.com'
    password = 'password1234'
  end
  @user = User.new(email: email, password: password, password_confirmation: password, admin: admin)
  expect{ @user.save! }.to change(User, :count).by 1
end

Given /^I log in with email : '(.+)' and password : '(.+)'$/ do |email, password|
  visit new_user_session_url
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  click_button "Se connecter !"
  expect(page).to have_text 'Vous êtes connecté(e).'
  @current_user = User.find_by_email email
end

Given /^A '(.+)' theme exist$/ do |theme|
  expect{
    Theme.create(name: theme, descr: 'Cucumber test theme', style: 'test', image: 'test.jpg', gallery: 'testgal.jpg')
  }.to change(Theme, :count).by 1
end

When /^I create a new trip$/ do
  expect(page).to have_current_path new_trip_path
  fill_in :trip_name, with: 'Mon test trip'
  fill_in :trip_pickup_place, with: 'Test pickup place'
  fill_in :trip_adults, with: 2
  fill_in "budget-range", with: 2
  fill_in "rythme-range", with: 2
  click_button "Enregistrer mon voyage !"
end

When /^I add a day '(.+)' to a trip$/ do |theme|
  theme = "day_theme_id_#{Theme.where(name: theme).first.id}"
  expect(page).to have_text('Date de votre journée')
  fill_in :day_date, with: "2100/01/01"
  choose  theme
  click_button 'Enregistrer'
end

When /^I pay my trip$/ do
  expect(page).to have_css('script.stripe-button', visible: false)
  #expect JS stripe to be ok, if one day selenium can work mock and stub that
  trip_id = page.find_by_id('trip_id', visible: false).value
  trip_value = page.find_by_id('amount', visible: false).value.to_i
  trip = Trip.find(trip_id)
  StripeMock.start
    stripe_helper = StripeMock.create_test_helper
    trip.gestion.process_stripe_charge(trip_value, 'test@strip.com', stripe_helper.generate_card_token)
  StripeMock.stop
  expect(trip.gestion.status).to eq 'payed'
  visit trip_path(trip)
end

When /^I fill in login form with (.+) and (.+)$/ do |email, password|
  fill_in :user_email, with: email
  fill_in :user_password, with: password
end

When /^I visit the (.+)$/ do |page_name|
  case page_name
  when "home page"
   visit root_path
  else
   fail "Invalid page name : #{page_name}"
  end
end

When /^I click on link (.+)/ do |link|
  if page.has_link? link
    click_link link, match: :first
  else
    fail "#{link} is not present"
  end
end

When /^I click on button (.+)/ do |button|
  if page.has_button? button
    click_button button, match: :first
  else
    fail "#{button} is not present"
  end
end

When /^(?:I create a new account via Facebook|I log in via Facebook)$/ do
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    'provider' => 'facebook',
    'uid' => '123545',
    'info' => {
      'email' => 'test@test.fr',
    },
    'credentials' => {
      'token' => 'mock_token',
      'secret' => 'mock_secret'
    }
  })
 click_link 'Se connecter via Facebook'
end


When /^I register my new account with (invalid|valid) credential$/ do |credential|
  if credential == 'valid'
    email = 'valid@cucumber.com'
    password = 'password1234'
    password_confirmation = 'password1234'
  else
    email = 'valid@cucumber.com'
    password = 'password1234'
    password_confirmation = 'invalid'
  end
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  fill_in :user_password_confirmation, with: password_confirmation
  click_button 'Créer mon compte'
end

Then /^I should be logged out$/ do
  expect(page).to have_text 'Vous êtes déconnecté(e).'
  expect(page.current_url).to eq root_url
end

Then /^I should be on the (.+)/ do |page_name|
  case page_name
  when "home page"
   expect(page.current_url).to eq root_url
  when "Themes#Index"
   expect(page.current_url).to eq themes_url
 when "Trips#Index"
    expect(page.current_url).to eq trips_url
  when "admin control center"
   expect(page.current_url).to eq setup_index_url
  when "user profile page"
   expect(page.current_url).to eq user_url(id: @current_user)
  when "contact form"
   expect(page.current_url).to eq root_url
 when "sign up page"
   expect(page.current_url).to eq new_user_registration_url
  when "sign-in page"
   expect(page.current_url).to eq new_user_session_url
  when "sign-up page"
   expect(page.current_url).to eq new_user_registration_url
  else
   fail "Invalid page name : #{page_name}"
  end
end

Then /^I should see (.+)/ do |expected_stuff|
  case expected_stuff
  when 'the guest top menu'
    within '.navbar' do
      expect(page).to have_link 'Tokyhop!', href: root_path
      expect(page).to have_link 'Que faire à Tokyo ?', href: themes_path
      expect(page).to have_link 'Une question ?', href: root_path(anchor: 'contact-row')
      expect(page).to have_link 'Se connecter', href: new_user_session_path
      expect(page).to have_link 'Créer un compte', href: new_user_registration_path
      expect(page).to_not have_link 'Mon profil'
      expect(page).to_not have_link 'Mes voyages'
      expect(page).to_not have_link 'Se déconnecter'
      expect(page).to_not have_link 'Admin'
    end
  when 'the user top menu'
    within '.navbar' do
      expect(page).to have_link 'Tokyhop!', href: root_path
      expect(page).to have_link 'Que faire à Tokyo ?'
      expect(page).to have_link 'Une question ?'
      expect(page).to have_link 'Mon profil'
      expect(page).to have_link 'Mes voyages'
      expect(page).to have_link 'Se déconnecter'
      expect(page).to_not have_link 'Se connecter'
      expect(page).to_not have_link 'Créer un compte'
      expect(page).to_not have_link 'Admin'
    end
  when 'the admin top menu'
    within '.navbar' do
      expect(page).to have_link 'Tokyhop!', href: root_path
      expect(page).to have_link 'Que faire à Tokyo ?'
      expect(page).to have_link 'Une question ?'
      expect(page).to have_link 'Mon profil'
      expect(page).to have_link 'Mes voyages'
      expect(page).to have_link 'Se déconnecter'
      expect(page).to have_link 'Admin'
      expect(page).to_not have_link 'Se connecter'
      expect(page).to_not have_link 'Créer un compte'
    end
  when 'themes select list'
    expect(page).to have_css('#themes_select_list')
  else
    fail "Dont know what you're looking for : #{expected_stuff}"
  end
end

Then /^The page should have a (.+) : '(.+)'/ do |element, name|
  if element == 'text'
    regex = Regexp.new(name)
    expect(page.text).to match regex
  else
    expect(page).to have_selector element.to_sym, name
  end
end


#=====================================================
#=====================================================
#=====================================================
#=====================================================
#=====================================================

Given /^(?:|I )am on (.+)$/ do |page_name|
  case page_name
  when "the RottenPotatoes home page"
   visit('/movies')
  else
   fail "Invalid page name : #{page_name}"
  end
end

When /I check "(.*)"$/ do |checkbox|
  check(checkbox)
end

When /I uncheck "(.*)"$/ do |checkbox|
  uncheck(checkbox)
end

When /I press "(.*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

Then /I should see \/(.*)\/ inside the movies table$/ do |regexp|
  regexp = Regexp.new(regexp)
  table = find(:css, "#movies")
  expect(table).to have_selector('td', text: regexp)
end

Then /^I should not see \/(.*)\/ inside the movies table$/ do |regexp|
  regexp = Regexp.new(regexp)
  table = find(:css, "#movies")
  expect(table).to_not have_selector('td', text: regexp)
end

Then /^I should( not)? see the following ratings: (.*)/ do |not_to_be_seen, rating_list|
  rating_list = rating_list.split(',')
  rating_list = rating_list.map { |rating|  rating.gsub(/\s+/, "") }
  if not_to_be_seen
    rating_list.each {|rating| step %Q{I should not see /^#{rating}$/ inside the movies table}}
  else
    rating_list.each {|rating| step %Q{I should see /^#{rating}$/ inside the movies table}}
  end
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list = rating_list.split(',')
  rating_list = rating_list.map { |rating| rating.gsub(/\s+/, "") }
  if uncheck
    rating_list.each { |rating|  step %Q{When I uncheck "ratings_#{rating}"} }
  else
    rating_list.each { |rating|  step %Q{When I check "ratings_#{rating}"} }
  end
end

# Add a declarative step here for populating the DB with movies.
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    new_movie = Movie.new(movie)
    fail "Could not create movie : #{movie}" unless new_movie.save
  end
end

Then /I should see all the movies/ do
  total_movie_count = Movie.all.count
  expect(page).to have_css("tr", :count => total_movie_count + 1)
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  expect(page.body.split(e2)[0].include?(e1)).to be true
end

Then /movies should be sorted by release date/ do
  sorted_movies = Movie.order('release_date ASC')
  x, y = 0, 1
  (sorted_movies.length - 1).times do
    step %Q{Then I should see "#{sorted_movies[x].title}" before "#{sorted_movies[y].title}"}
    x += 1
    y += 1
  end
end

Then /movies should be sorted alphabetically/ do
  sorted_movies = Movie.order('title ASC')
  x, y = 0, 1
  (sorted_movies.length - 1).times do
    step %Q{Then I should see "#{sorted_movies[x].title}" before "#{sorted_movies[y].title}"}
    x += 1
    y += 1
  end
end
