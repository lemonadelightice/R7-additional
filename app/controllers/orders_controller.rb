class OrdersController < ApplicationController
    def index
        @orders = Order.all 
    end

    def show 
        @order = Order.find(params[:id])
    end 

    def new
        @order = Order.new
    end

    def create 
        @order = Order.new(order_params)
        if @order.save 
            redirect_to @order, notice: 'Order was successfully created.'
        else 
            render :new
        end
    end 

    def edit 
        @order = Order.find(params[:id])
    end 

    def update 
        @order = Order.find(params[:id])
        if @order.update(order_params)
            redirect_to @order, notice: 'Order was succesfully updated.'
        else
            render :edit
        end
    end 

    def destroy  
        @order = Order.find(params[:id]) 
        @order.destroy
        redirect_to orders_url, notice: 'Order was successfully destroyed'
    end  

    private

    def order_params
        params.require(:order).permit(:product_name, :product_count, :customer_id)
    end
end 