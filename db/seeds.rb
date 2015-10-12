# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## Create sources



s1 = Source.create!(source_name: "guardian",
                    url: "http://content.guardianapis.com/",
                    source_format: 'json')
s2 = Source.create!(source_name: "news au",
                    url: "http://feeds.news.com.au/public/rss/2.0/news_national_3354.xml",
                    source_format: 'rss')
s3 = Source.create!(source_name: "The Times Newswire",
                    url: "http://api.nytimes.com/svc/news/v3/content/all/all/1.json?"\
                    "api-key=366cba91e78cc7097e46397d14963dff:15:72728981",
                    source_format: 'json')
s4 = Source.create!(source_name: "Herald Sun Breaking News",
                    url: "http://feeds.news.com.au/heraldsun/rss/heraldsun_news_breakingnews_2800.xml",
                    source_format: 'rss')
s5 = Source.create!(source_name: "Herald Sun Technology",
                    url: "http://feeds.news.com.au/heraldsun/rss/heraldsun_news_technology_2790.xml",
                    source_format: 'rss')
s6 = Source.create!(source_name: "Herald Sun Sport News",
                    url: "http://feeds.news.com.au/heraldsun/rss/heraldsun_news_sport_2789.xml",
                    source_format: 'rss')


