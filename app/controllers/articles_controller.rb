class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /articles or /articles.json
  def index
    @categories = Category.all.order(priority: "asc")

    top_count = Vote.group(:article_id).count.map {|art| art[1] }.sort.max
    count_id_key = Vote.group(:article_id).count.map {|art| [art[1],art[0]] }

    top_id = count_id_key.select { |key_id_pair| key_id_pair[0] == top_count }       
    
    @top_article = Article.find(top_id[0][1])

    @random_article = Article.find(rand(Article.all.count))
  end

  # GET /articles/1 or /articles/1.json
  def show
    @id = params[:id]
    @votee = Vote.where(["user_id = ? AND article_id = ?", "#{session[:current_user]["id"]}", "#{@id}"])
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    u = User.find(session[:current_user]["id"])
    @article = u.articles.build(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to articles_path, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: articles_path }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :text, :image, :author_id, :category_id)
    end
end
