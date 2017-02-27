class Supports::Product
  attr_reader :product

  def initialize product
    @product = product
  end

  def relate
    @relate ||= Product.take_relate_product @product
  end

  def hot
    @hot = Product.take_hot_product @product
  end

  def randomizes
    @randomizes = Product.take_random_product
  end
end
