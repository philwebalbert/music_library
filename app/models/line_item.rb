class LineItem < ActiveRecord::Base
  
  belongs_to :album
  belongs_to :order
  
  def self.new_based_on( album )
    line_item = self.new
    line_item.album = album
    line_item.quantity = 1
    line_item.price = album.price
    return line_item
  end
end
