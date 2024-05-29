class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      next if item.name == 'Sulfuras, Hand of Ragnaros'

      decrease_sell_in item
      calculate_quality item
    end
  end

  private

  def calculate_quality(item)
    if item.name == 'Aged Brie' || item.name == 'Backstage passes to a TAFKAL80ETC concert'
      increase_quality item
    else
      decrease_quality item
    end
  end

  def increase_quality(item)
    return if item.quality >= 50

    item.quality += item.sell_in.negative? ? 2 : 1

    if item.name == 'Backstage passes to a TAFKAL80ETC concert'
      item.quality += 1 if item.sell_in < 11
      item.quality += 1 if item.sell_in < 6
      item.quality = 0 if item.sell_in < 0
    end

    item.quality = 50 if item.quality > 50
  end

  def decrease_quality(item)
    return if item.quality <= 0

    decrement = item.sell_in.negative? ? 2 : 1
    decrement *= 2 if item.name == 'Conjured Mana Cake'

    item.quality -= decrement

    item.quality = 0 if item.quality < 0
  end

  def decrease_sell_in(item)
    item.sell_in -= 1
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
