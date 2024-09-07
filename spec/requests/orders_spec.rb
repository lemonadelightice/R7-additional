require 'rails_helper'

RSpec.describe "OrdersControllers", type: :request do
  let!(:order) { FactoryBot.create(:order) }

  describe "GET /index" do
    it "returns a successful response" do
      get orders_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns a successful response" do
      get order_path(order)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns a successful response" do
      get new_order_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new order and redirects to the show page" do
      customer = FactoryBot.create(:customer)
      order_attributes = FactoryBot.attributes_for(:order, customer_id: customer.id)
      expect {
        post orders_path, params: { order: order_attributes }
      }.to change(Order, :count).by(1)
      
      expect(response).to redirect_to(order_path(Order.last))
    end

    it "renders the new template if the order is not valid" do
      customer = FactoryBot.create(:customer)
      invalid_attributes = FactoryBot.attributes_for(:order, product_name: "", customer_id: customer.id)
      post orders_path, params: { order: invalid_attributes}
      expect(response).to render_template(:show)
    end
  end

  describe "GET /edit" do
    it "returns a successful response" do
      get edit_order_path(order)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    it "updates an existing order and redirects to the show page" do
      patch order_path(order), params: { order: { product_name: "Updated Product" } }
      expect(response).to redirect_to(order_path(order))
      expect(order.reload.product_name).to eq("Updated Product")
    end

    it "renders the edit template if the update is invalid" do
      patch order_path(order), params: { order: { product_name: "" } }
      expect(response).to render_template(:edit)
    end
  end

  describe "DELETE /destroy" do
    it "deletes the order and redirects to the index page" do
      expect {
        delete order_path(order)
      }.to change(Order, :count).by(-1)
      expect(response).to redirect_to(orders_path)
    end
  end
end
