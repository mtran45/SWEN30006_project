require 'json'
require 'net/http'


require_relative 'article.rb'


# Import from Guardian JSON API
class GuardianImporter < Importer
  def initialize(start_date, end_date)
    super
  end

  def self.source_name
    'guardian'
  end

  # import news from guardian
  def scrape
    url = 'http://content.guardianapis.com/'
    source_name = 'guardian'
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    path = '/search?api-key=a8cmjya9kseh5cvx2k2t6dqn&show-fields=all'
    response = http.send_request('GET', path)
    json_data = JSON.parse(response.body)
    article_list = json_data['response']['results']
    re = /<("[^"]*"|'[^']*'|[^'">])*>/
    article_list.each do |item|
      a_title = item['webTitle']
      a_summary = item['fields']['body']
      a_summary.gsub!(re, '')
      a_summary = a_summary[0...400]
      a_source = Source.find_by(source_name: source_name)
      a_link = item['webUrl']
      a_date = DateTime.parse(item['webPublicationDate'])
      a_author = item['fields']['byline']
      a_images = item['fields']['thumbnail']
      tag_list = item['sectionId']
      tags = a_title.scan(/[A-Z][a-zA-Z0-9]+/)
      if tags
        tags.shift
        tags.each do |tag|
          tag_list = tag_list + ",#{tag}"
        end
      end
      article = Article.new(title: a_title, summary: a_summary,
                            source: a_source, date_of_public: a_date,
                            image: a_images, author: a_author, link: a_link, tag_list: tag_list)
      article.save
    end
  end
end
