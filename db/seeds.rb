# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(first_name: 'Example', last_name: 'User',
     email: 'a@a.com', bio: 'Some really awesome author that wrote some stuff',
     username: 'user', password: 'pass', interest_list: 'technology')

User.create!(first_name: 'User', last_name: 'Two',
     email: 'b@b.com', bio: 'Bio for user 2',
     username: 'user2', password: 'pass', interest_list: 'victoria')

Source.create!([
     { 
          name: 'The New York Times',
          description: 'The New York Times: Find breaking news, multimedia, reviews & opinion on 
                    Washington, business, sports, movies, travel, books, jobs, education, real estate...',
          url: 'http://www.nytimes.com', 
     },
     { 
          name: 'The Age', 
          description: 'The Age has the latest local news on Melbourne, Victoria. Read National 
                    News from Australia, World News, Business News and Breaking News stories.',
          url: 'http://www.theage.com.au',
     },
     { 
          name: 'News.com.au', 
          description: 'News headlines from Australia and the world. The latest national, world,
                     business, sport, entertainment and technology news from News Limited news papers.',
          url: 'http://www.news.com.au',
     },
     { 
          name: 'Herald Sun', 
          description: 'News headlines from Melbourne & Victoria. The latest national, world, 
                    business, sport, entertainment and technology news from the Herald Sun.',
          url: 'http://www.heraldsun.com.au',
     },
     { 
          name: 'ABC', 
          description: 'Australia\'s most trusted source of local, national and world news.',
          url: 'http://www.abc.net.au/news'
     },
     { 
          name: 'The Australian', 
          description: 'The Australian National and International News with in-depth Business News 
                    and Political coverage including Lifestyle, Arts and Sports and more.',
          url: 'http://www.theaustralian.com.au'
     }
     ])
