class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  before_action :authenticate_user

  include Scraper

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # get news user interested in
  def my_interests
    @articles = Article.tagged_with(current_user.interest_list, :any =>true).to_a
    render 'index'
  end



  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end



  # refresh news
  def scrape
    scraper = Scraper.new
    articles = scraper.scrape
    articles.each do |article|
      article.save
    end
    redirect_to :articles
  end

  def search
    @articles = Article.search(params[:search]) if params[:search].present?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:source, :title, :date_of_public, :summary, :author, :image, :link,
                                      :tag_list)
    end
end
