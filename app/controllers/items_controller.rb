class ItemsController < ApplicationController
    def index
      if params[:user_id]
        user = User.find_by(id: params[:user_id])
        if user
          items = user.items
          render json: items
        else
          render json: { error: 'User not found' }, status: :not_found
        end
      else
        items = Item.all.to_a
        render json: items, include: :user
      end
    end
  
    def show
      item = Item.find_by(id: params[:id])
      if item
        render json: item
      else
        render json: { error: 'Item not found' }, status: :not_found
      end
    end
  
    def create
      item = Item.create(item_params)
      if item.persisted?
        render json: item, status: :created
      else
        render json: { error: 'Failed to create item' }, status: :unprocessable_entity
      end
    end
  
    private
  
    def item_params
      params.permit(:name, :description, :price, :user_id)
    end
  end