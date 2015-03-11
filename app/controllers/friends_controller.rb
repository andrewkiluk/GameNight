class FriendsController < ApplicationController
  def index
    @friends = User
      .joins("JOIN relations AS rel
              ON rel.user_id = users.id")
      .joins("JOIN relations AS inv
              ON rel.inverse_id = inv.id")
      .where("rel.related_user_id == ?", @current_user)
      .where("rel.status == ?", Status::ACCEPTED)
      .where("inv.status == ?", Status::ACCEPTED)
      .order("users.name")
  end


  def search_form

  end


  def show

  end


  def add

  end


  def delete

  end
end