class PublicController < ApplicationController
  
  before_filter :find_or_create_cart, :except => [:list]
  
  layout "public"
  
  def list
    @albums = Album.find(:all, :order => 'title ASC')
  end
  
  def add_to_cart
    album = Album.find(params[:id])
    @cart.add_album(album)
    session[:cart] = @cart
    redirect_to(:action => 'show_cart')
  end
  
  def show_cart
  end
  
  def empty_cart
    @cart.empty_all_items
    flash[:notice] = "Your cart is now empty."
    redirect_to(:action => "list")
  end
  
  def remove_item
    album = Album.find(params[:id])
    @cart.remove_album(album)
    flash[:notice] = "One item was removed from your cart."
    redirect_to(:action => 'show_cart')
  end
  
  def checkout
    @customer = Customer.new
  end
  
  def save_order
    @customer = Customer.new(params[:customer])
    credit_card_number = params[:credit_card]
    @order = Order.new
    @order.invoice_number = '2'
    @order.line_items << @cart.items
    @customer.orders << @order
    if @customer.save
      @cart.empty_all_items
      flash[:notice] = "Your purchase was successfully completed."
      redirect_to(:action => "show_receipt", :id => @order.id)
    else
      render(:action => "checkout")
    end 
  end
  
  def show_receipt
    @order = Order.find(params[:id])
  end
  
  private #------------------------------------
  
  def find_or_create_cart
    @cart = session[:cart] ||= Cart.new
  end
  
end
