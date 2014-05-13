class ListsController < ApplicationController
  before_action :set_user
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def show
    @items = @list.items.completed
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @items }
    end
  end

  def new
    @list = List.new
  end

  def edit
  end

  def index
    @lists = @user.lists
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @lists }
    end
  end

  def create
    respond_to do |format|
      @list = List.new(list_params)
      @list.user_id = @user.id

      format.json {
        if @list.save
          render json: {message: "List was created successfully for #{@list.user_id}"}
        else
          render json: {message: 'Error creating list', errors: @list.errors}
        end         
      }

      format.html {
        if @list.save
          redirect_to user_list_path(@user, @list), notice: 'List was successfully created.'
        else
          render action: 'new'
        end        
      }

    end
  end

  def update
    respond_to do |format|
 
      format.html {
        if @list.update(list_params)
          redirect_to user_list_path(@user, @list), notice: 'List was successfully updated.'
        else
          render action: 'edit'
        end        
      }

      format.json {
        if @list.update(list_params)
          render json: {message: "List was updated successfully"}
        else
          render json: {message: "List update unsuccessful"}
        end        
      }

    end
  end

  def destroy
    respond_to do |format|
      @list.destroy

      format.json {
        render json: {message: "List destroyed successfully"}
      }

      format.html {
        redirect_to @user
      }
    end

    


    
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :user_id, :permissions)
  end
end
