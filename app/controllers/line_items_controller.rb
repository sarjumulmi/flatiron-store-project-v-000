class LineItemsController < ApplicationController

  def create
    current_user.current_cart = Cart.new unless current_user.current_cart
    current_user.save
    line_item = current_user.current_cart.add_item(params[:item_id])
    if line_item.save
      redirect_to cart_path(current_user.current_cart), {notice: "Item Added!!"}
    else
      redirect_to store_path, {notice: 'Unable to add item!!'}
    end
  end

end
