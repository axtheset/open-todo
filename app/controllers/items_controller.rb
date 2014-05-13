class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :set_list

  def create
    respond_to do |format|

      format.html {
        if @list.add(item_params[:description])
          redirect_to user_list_path(@list.user, @list), notice: 'Item was successfully created.'
        else
          render action: 'new'
        end        
      }

      format.json {
        if @list.add(item_params[:description])
          render json: {message: "Item was updated successfully"}
        else
          render json: {message: "Item was not successfully added"}
        end        
      }

    end


  end

  def new
    @item = Item.new
  end

  def destroy
    respond_to do |format|
      @item.mark_complete
      format.html {
        redirect_to user_list_path(@list.user, @list)
      }

      format.json {
        render json: {message: "Item marked as complete successfully"}
      }
    end
    
    
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def set_list
    @list = @item ? @item.list : List.find(params[:list_id])
  end

  def item_params
    params.require(:item).permit(:description, :list_id, :completed)
  end
end
