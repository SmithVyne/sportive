class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    # rubocop:disable Lint/AssignmentInCondition
    if u = User.find_by(name: @user.name.to_s)
      # rubocop:enable Lint/AssignmentInCondition
      session[:current_user] = u
      redirect_to articles_path

    else
      respond_to do |format|
        if @user.save
          u = User.find_by(name: @user.name.to_s)
          session[:current_user] = u
          format.html { redirect_to articles_path, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: articles_path }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def logout
    session[:current_user] = nil
    redirect_to new_user_path
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(session[:current_user_id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name)
  end
end
