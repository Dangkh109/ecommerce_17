class Supports::Product
  attr_reader :product

  def initialize product
    @product = product
  end

  def relate
    @relate ||= Product.get_relate @product
  end

  def hot
    @hot = Product.get_hot @product
  end

  def randomizes
    @randomizes = Product.get_random
  end
end
