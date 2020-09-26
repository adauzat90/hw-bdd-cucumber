# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    add_movie = Movie.new
    add_movie.title = movie['title']
    add_movie.rating = movie['rating']
    add_movie.release_date = movie['release_date']
    add_movie.save()
  end
  #fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  index_1 = page.body.index (/(#{e1}.+)/)
  index_2 = page.body.index (/(#{e2}.+)/)
  expect index_1 < index_2
  
  #page.body.match(/(#{e1})+.(#{e2})/).should be true
  
  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list = rating_list.split(", ")
  if uncheck
    rating_list.each do |rating|
      uncheck(rating)
    end
  else
    rating_list.each do |rating|
      check(rating)
    end
  end
  #fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  Movie.count.should be page.all(:css, 'table tr').size.to_i-1
  #fail "Unimplemented"
end
