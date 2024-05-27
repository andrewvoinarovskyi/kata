require 'rspec'

require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  def create_item(name, sell_in, quality)
    Item.new(name, sell_in, quality)
  end

  before(:each) do
    GildedRose.new(items).update_quality()
  end

  context "foo" do
    context "not last day" do
      let(:items) { [create_item("foo", 1, 2)] }

      it "does not change the name" do
        expect(items[0].name).to eq "foo"
      end

      it "decreases sell_in by 1" do
        expect(items[0].sell_in).to eq 0
      end
  
      it "decreases quality by 1" do
        expect(items[0].quality).to eq 1
      end
    end

    context "last day" do
      let(:items) { [create_item("foo", 0, 5)] }

      it "does not change the name" do
        expect(items[0].name).to eq "foo"
      end

      it "decreases sell_in by 1" do
        expect(items[0].sell_in).to eq -1
      end
  
      it "decreases quality by 2" do
        expect(items[0].quality).to eq 3
      end
    end
  end

  context "Sulfuras, Hand of Ragnaros" do
    let(:items) { [Item.new("Sulfuras, Hand of Ragnaros", 5, 80)] }

    it "does not change the name" do
      expect(items[0].name).to eq "Sulfuras, Hand of Ragnaros"
    end

    it "does not change the sell_in" do
      expect(items[0].sell_in).to eq 5
    end
  
    it "does not change the quality" do
      expect(items[0].quality).to eq 80
    end
  end

  context "Aged Brie" do
    context "before sell_in period" do 
      let(:items) { [Item.new("Aged Brie", 5, 0)] }

      it "does not change the name" do
        expect(items[0].name).to eq "Aged Brie"
      end
  
      it "decreases sell_in by 1" do
        expect(items[0].sell_in).to eq 4
      end
    
      it "increases quality by 1" do
        expect(items[0].quality).to eq 1
      end
    end

    context "after sell_in period" do 
      let(:items) { [Item.new("Aged Brie", 0, 0)] }

      it "does not change the name" do
        expect(items[0].name).to eq "Aged Brie"
      end
  
      it "decreases sell_in by 1" do
        expect(items[0].sell_in).to eq -1
      end
    
      it "increases quality by 2" do
        expect(items[0].quality).to eq 2
      end
    end
  end

  context "Backstage passes to a TAFKAL80ETC concert" do
    context "more than 10 days before" do
      let(:items) { [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 10)] }
      
      it "does not change the name" do
        expect(items[0].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      end

      it "decreases sell_in by 1" do
        expect(items[0].sell_in).to eq 14
      end
    
      it "increases quality by 1" do
        expect(items[0].quality).to eq 11
      end
    end

    context "more than 5 days before" do
      let(:items) { [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)] }

      it "does not change the name" do
        expect(items[0].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      end

      it "decreases sell_in by 1" do
        expect(items[0].sell_in).to eq 9
      end
    
      it "increases quality by 2" do
        expect(items[0].quality).to eq 12
      end
    end

    context "less than 5 days before" do
      let(:items) { [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)] }

      it "does not change the name" do
        expect(items[0].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      end

      it "decreases sell_in by 1" do
        expect(items[0].sell_in).to eq 4
      end
    
      it "increases quality by 3" do
        expect(items[0].quality).to eq 13
      end
    end

    context "after concert" do
      let(:items) { [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10)] }

      it "does not change the name" do
        expect(items[0].name).to eq "Backstage passes to a TAFKAL80ETC concert"
      end

      it "decreases sell_in by 1" do
        expect(items[0].sell_in).to eq -1
      end
    
      it "sets quality to 0" do
        expect(items[0].quality).to eq 0
      end
    end
  end
end
