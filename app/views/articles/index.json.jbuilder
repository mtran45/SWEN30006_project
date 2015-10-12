json.array!(@articles) do |article|
  json.extract! article, :id, :source, :title, :date_of_public, :summary, :author, :image, :link
  json.url article_url(article, format: :json)
end
