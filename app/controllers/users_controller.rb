# This is UserController
class UsersController < ApplicationController
  def index
    @user = UsersGenerator.call(current_user, session)
  end

  def show
    if acces_to_profile?
      @user = User.find(params[:id]) if user_exist?
      @message = Message.new
      @room_name = get_name(@user, current_user)
      @single_room = room_create(@room_name, @user)
      set_notifications_to_read
      render 'rooms/index' if @user != current_user
    else
      redirect_to matches_user_path(current_user)
    end
  end

  def matches
    @current_user_matches = User.find(current_user.liker_ids & current_user.likee_ids)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def acces_to_profile?
    (current_user.liker_ids & current_user.likee_ids).push(current_user.id).include?(params[:id].to_i)
  end

  def user_exist?
    User.find(params[:id])
  end

  def get_name(user1, user2)
    users = [user1, user2].sort
    "private_#{users[0].id}_#{users[1].id}"
  end

  def set_notifications_to_read
    notifications = @single_room.notifications_as_room.where(recipient: @user).unread
    notifications.update_all(read_at: Time.zone.now) # rubocop:disable Rails/SkipsModelValidations
  end

  def room_create(room_name, user)
    Room.find_by(name: room_name) || Room.create_private_room([user, current_user], room_name)
  end
end
