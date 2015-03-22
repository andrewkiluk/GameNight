class FriendsController < ApplicationController
  def index
    @friends = @current_user.get_friends
  end


  def search_form

  end


  def search_action
    search_string = params["search_string"]
    @search_results = User.search(search_string)
  end


  def show
    id = params[:id]
    @shown_user = User.find_by(id: id)

    @friend_status = @shown_user && @current_user.get_friend_status(@shown_user)

    friend = User.find(id)
    @my_games, @our_games, @their_games = @current_user.compare_collections(friend)

  end


  def add
    id = params[:id]
    Relation.create(user_id: @current_user.id, related_user_id: id, status: Status::PENDING)

    flash[:success] = "Friend request sent!"
    render text: 'success'
  end


  def confirm
    id = params[:id]
    friend_request = Relation.find_friend_request_from(@current_user, id)
    if friend_request
      friend_request.confirm_request(id)
      flash[:success] = 'Friendship confirmed!'
    else
      flash[:error] = 'No such request to confirm.'
    end

    render text: 'success'
  end


  def delete
    id = params[:id]
    status = Relation.delete_friend(@current_user, id)

    if status == Status::PENDING
      flash[:success] = "Request cancelled."
    else
      flash[:success] = "Friendship deleted."
    end

    render text: 'success'
  end
end