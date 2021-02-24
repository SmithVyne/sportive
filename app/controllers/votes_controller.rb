class VotesController < ApplicationController
  before_action :set_vote, only: %i[ show edit update destroy ]

  # GET /votes or /votes.json
 

  # GET /votes/1 or /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @vote = Vote.new
  end

  # GET /votes/1/edit
  def edit
  end


  def create
  end

  # POST /votes or /votes.json
  def vote_up
    u = User.find(session[:current_user]["id"])
    id = params[:id]
    @vote = Vote.where(["user_id = ? AND article_id = ?", "#{session[:current_user]["id"]}", "#{id}"])

    if @vote.empty?
      @vote = u.votes.build(article_id: id)
      if @vote.save
        redirect_to request.referrer
      end
    else
      redirect_to articles_path
    end
  end

  # PATCH/PUT /votes/1 or /votes/1.json
  def update
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to @vote, notice: "Vote was successfully updated." }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1 or /votes/1.json
  def destroy
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to votes_url, notice: "Vote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vote_params
      params.require(:vote).permit(:article_id)
    end
end
