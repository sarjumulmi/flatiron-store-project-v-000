class Cart < ActiveRecord::Base

  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def total
    self.line_items.joins(:item).sum('price*quantity')
  end

  def add_item(item_id)
    line_item = self.line_items.find_by(item_id:item_id)
    if !line_item
      self.line_items.build(item_id:item_id)
    else
      line_item.quantity +=1
      line_item
    end
  end

  def checkout
    self.line_items.each do |line_item|
      # binding.pry
      line_item.item.inventory -= line_item.quantity

      line_item.item.save
      # binding.pry
    end
    self.status = "submitted"
    self.save
  end

end
