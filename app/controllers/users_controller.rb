# This is UserController
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    reset_session_users_id_list_after_a_period_of_time(3600)
    generate_new_session_users_id_list_size_in_argument(100) if users_id_list_is_nil?
    @user = User.find(session[:users_id].sample) if are_there_suitable_users?
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @current_user = current_user
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    @room = Room.new
    @message = Message.new
    @room_name = get_name(@user, @current_user)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, @current_user], @room_name)
    @messages = @single_room.messages

    render "rooms/index" if @user != current_user

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def matches
    @current_user_matches = User.find(current_user.liker_ids & current_user.likee_ids)
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :birth, :sex, :work_id, :yourself, :latitude, :longitude,
                                 foto: [])
  end

<<<<<<< HEAD
  def users_id_list_is_nil?
    !current_user.nil? && session[:users_id].nil?
  end

  def are_there_suitable_users?
    !current_user.nil? && !session[:users_id].empty?
  end

  def generate_new_session_users_id_list_size_in_argument(list_size)
    session[:date] = Time.now.to_i
    session[:users_id] = User.all.reject { |user| user.sex == current_user.sex }.shuffle.pluck(:id)[0..list_size - 1]
  end

  def reset_session_users_id_list_after_a_period_of_time(time)
    session[:users_id] = nil if current_user.nil? || (Time.now.to_i - session[:date].to_i) > time
=======
  def get_name(user1, user2)
    users = [user1, user2].sort
    "private_#{users[0].id}_#{users[1].id}"
>>>>>>> add private room
  end
end
