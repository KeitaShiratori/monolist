class Item < ActiveRecord::Base
  serialize :raw_info , Hash

  has_many :ownerships  , foreign_key: "item_id" , dependent: :destroy
  has_many :users , through: :ownerships
  has_many :wants, class_name: "Want", foreign_key: "item_id", dependent: :destroy
  has_many :want_users , through: :wants, source: :user
  has_many :haves, class_name: "Have", foreign_key: "item_id", dependent: :destroy
  has_many :have_users , through: :haves, source: :user

  def self.ranking type_string
    Item.joins("Left Join ownerships on items.id = ownerships.item_id")
        .select('items.*, count(ownerships.type) as cnt')
        .where("ownerships.type = '#{type_string}'")
        .group("ownerships.item_id")
        .order("cnt DESC")
        .limit(10)
  end
end
