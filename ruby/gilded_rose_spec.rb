require 'rspec'

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  def create_item(name, sell_in, quality)
    Item.new(name, sell_in, quality)
  end

  let(:name) { 'foo' }
  let(:sell_in) { 5 }
  let(:quality) { 5 }

  before(:each) do
    @items = [create_item(name, sell_in, quality)]
    GildedRose.new(@items).update_quality
  end

  shared_examples 'a normal item' do |quality_changes|
    it 'does not change the name' do
      expect(@items[0].name).to eq name
    end

    it 'decreases sell_in by 1' do
      expect(@items[0].sell_in).to eq sell_in - 1
    end

    it "changes quality by #{quality_changes}" do
      expect(@items[0].quality).to eq quality + quality_changes
    end
  end

  context 'foo' do
    context 'not overdue' do
      include_examples 'a normal item', -1
    end

    context 'overdue' do
      let(:sell_in) { 0 }
      include_examples 'a normal item', -2
    end

    context 'with zero quality' do
      let(:quality) { 0 }
      include_examples 'a normal item', 0
      context 'and overdue' do
        let(:sell_in) { 0 }
        include_examples 'a normal item', 0
      end
    end
  end

  context 'Conjured Mana Cake' do
    let(:name) { 'Conjured Mana Cake' }
    context 'not overdue' do
      include_examples 'a normal item', -2
    end

    context 'overdue' do
      let(:sell_in) { 0 }
      include_examples 'a normal item', -4
    end

    context 'with zero quality' do
      let(:quality) { 0 }
      include_examples 'a normal item', 0
      context 'and overdue' do
        let(:sell_in) { 0 }
        include_examples 'a normal item', 0
      end
    end

    context 'with quality = 1 ' do
      let(:quality) { 1 }
      include_examples 'a normal item', -1
      context 'and overdue' do
        let(:sell_in) { 0 }
        include_examples 'a normal item', -1
      end
    end
  end

  context 'Aged Brie' do
    let(:name) { 'Aged Brie' }

    context 'before sell_in period' do
      include_examples 'a normal item', 1
    end

    context 'after sell_in period' do
      let(:sell_in) { 0 }
      include_examples 'a normal item', 2
    end

    context 'with high quality' do
      let(:sell_in) { 5 }
      let(:quality) { 50 }
      include_examples 'a normal item', 0
    end
  end

  context 'Backstage passes to a TAFKAL80ETC concert' do
    let(:name) { 'Backstage passes to a TAFKAL80ETC concert' }

    context 'more than 10 days before concert' do
      let(:sell_in) { 15 }
      include_examples 'a normal item', 1
    end

    context 'more than 5 days before concert' do
      let(:sell_in) { 10 }
      include_examples 'a normal item', 2
    end

    context 'less than 5 days before concert' do
      let(:sell_in) { 5 }
      include_examples 'a normal item', 3
    end

    context 'after concert' do
      let(:sell_in) { 0 }

      it 'does not change the name' do
        expect(@items[0].name).to eq name
      end

      it 'decreases sell_in by 1' do
        expect(@items[0].sell_in).to eq sell_in - 1
      end

      it 'sets quality to 0' do
        expect(@items[0].quality).to eq 0
      end
    end

    context 'with high quality' do
      let(:sell_in) { 5 }
      let(:quality) { 49 }
      include_examples 'a normal item', 1
    end
  end

  context 'Sulfuras, Hand of Ragnaros' do
    let(:name) { 'Sulfuras, Hand of Ragnaros' }
    let(:quality) { 80 }

    it 'does not change the name' do
      expect(@items[0].name).to eq name
    end

    it 'does not change the sell_in' do
      expect(@items[0].sell_in).to eq sell_in
    end

    it 'does not change the quality' do
      expect(@items[0].quality).to eq quality
    end
  end
end
