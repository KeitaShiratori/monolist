class RankingController < ApplicationController
  before_action :logged_in_user

  def have
    @items = Item.ranking "Have"
  end

  def want
    @items = Item.ranking "Want"
  end
end
