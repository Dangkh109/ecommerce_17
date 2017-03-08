class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  enum status: [:wait, :success, :delay]
  before_update :check_product_quantity_before_update

  private
  def check_product_quantity_before_update
    if status == Settings.success
      order_details.each do |order_detail|
        if order_detail.check_product_quantity
          throw :abort
        end
      end
      order_details.each do |order_detail|
        order_detail.update_product_quantity
      end
    end
  end
end
