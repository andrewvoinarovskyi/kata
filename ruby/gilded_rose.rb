class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      next if item.name == "Sulfuras, Hand of Ragnaros"

      if item.name == "Aged Brie" or item.name == "Backstage passes to a TAFKAL80ETC concert"
        increase_quality item
      else
        decrease_quality item
      end

      decrease_sell_in item
      update_quality_for_overdue item if item.sell_in < 0
    end
  end

  private

  def update_quality_for_overdue(item)
    if item.name != "Aged Brie"
      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        item.quality = 0
      else
        decrease_quality item
      end
    else
      increase_quality item
    end
  end

  def increase_quality(item)
    if item.quality < 50
      item.quality += 1

      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        item.quality += 1 if item.sell_in < 11 and item.quality < 50
        item.quality += 1 if item.sell_in < 6 and item.quality < 50
      end
    end
  end

  def decrease_quality(item)
    item.quality -= 1 if item.quality > 0
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
