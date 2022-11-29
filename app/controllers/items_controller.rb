class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if user
        items = user.items
        if items
          render json: items, include: :user
        else
          render json: { error: 'Items not found' }, status: :not_found
        end
      else
        render json: { error: 'User not found' }, status: :not_found
      end


    else
      items = Item.all
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
    user = User.find_by(id: params[:user_id])

    if user
      item = Item.create({
        name: params[:name],
        description: params[:description],
        price: params[:price],
        user_id: params[:user_id]
      })
      render json: item, status: :created
    else
      render json: { error: 'User not found' }, status: :not_found
    end

  end

end
