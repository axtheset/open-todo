class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  def index
    @users = User.all
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @users }
    end
  end

  def show
    @lists = @user.lists
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @lists }
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    respond_to do |format|
      format.html {
        @user = User.new(user_params)

        if @user.save
          redirect_to @user, notice: 'User was successfully created.'
        else
          render action: 'new'
        end        
      }

      format.json {
        @user = User.new()
        @user.username = params[:username]
        @user.password = params[:password]

        if @user.save
          render json: {message: 'User was created successfully'}
        else
          render json: {message: 'Error creating user'}
        end         
      }
    end

  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
