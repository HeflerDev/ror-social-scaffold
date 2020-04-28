
class FriendshipsController < ApplicationController

  #<%= form_for current_user.friendships.build(friend: user) do |f| %>
  #  <%= f.hidden_field :friend_id %>
  #  <%= f.hidden_field :confirmed, value: false %>
  #  <button>Request Friend</button>
  #<% end %>

  def create
    current_user.friendships.create!(friendship_params)
    redirect_to users_path
  end

  def destroy
    another_user = User.find params[:user_id]
    current_user.friends.delete(another_user)
    redirect_to users_path
  end

  def update
    another_user = User.find params[:user_id]
    current_user.confirm_friend(another_user)
  end

  private
    def friendship_params
      params.require(:friendship).permit(:user_id, :friend_id, :confirmed)
    end
end
