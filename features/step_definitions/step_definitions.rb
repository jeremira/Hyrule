Given /^I am logged out$/ do
  visit root_path
  if page.has_content? 'Se déconnecter'
    click_link 'Se déconnecter'
  end
end

When /^I visit the (.+)$/ do |page_name|
  case page_name
  when "home page"
   visit root_path
  else
   fail "Invalid page name : #{page_name}"
  end
end

Then /^I must be on the (.+)/ do |page_name|
  case page_name
  when "home page"
   expect(page.current_url).to eq root_url
  else
   fail "Invalid page name : #{page_name}"
  end
end

Then /^I must see (.+)/ do |expected_stuff|
  case expected_stuff
  when 'the guest top menu'
    within '.navbar' do
      expect(page).to have_link 'Tokyhop!', href: root_path
      expect(page).to have_link 'Que faire à Tokyo ?', href: themes_path
      expect(page).to have_link 'Une question ?', href: root_path(anchor: 'contact-row')
      expect(page).to have_link 'Se connecter', href: new_user_session_path
      expect(page).to have_link 'Créer un compte', href: new_user_registration_path
    end
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
