class Supports::Product
  attr_reader :product

  def initialize product
    @product = product
  end

  def relate
    @relate ||= Product.take_relate @product
  end

  def hot
    @hot = Product.take_hot @product
  end

  def randomizes
    @randomizes = Product.take_random
  end
end
