# This is UserController
class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]

  def index
    session[:count] ||= 0
    generate_new_session_users_id_list_size_in_argument(100) if users_id_list_is_nil_or_count_is_full?
    @user = User.find(session[:users_id][session[:count]]) if are_there_suitable_users?
    session[:count] += 1
  end

  # GET /users/1 or /users/1.json
  def show
    if acces_to_profile?
      @user = User.find(params[:id]) if user_exist?
      @message = Message.new
      @room_name = get_name(@user, current_user)
      @single_room = Room.find_by(name: @room_name) || Room.create_private_room([@user, @current_user], @room_name)
      render 'rooms/index' if @user != current_user
    else
      redirect_to matches_user_path(current_user)
    end
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

  def users_id_list_is_nil_or_count_is_full?
    !current_user.nil? && (session[:users_id].blank? || session[:count] == session[:users_id].size)
  end

  def acces_to_profile?
    (current_user.liker_ids & current_user.likee_ids).push(current_user.id).include?(params[:id].to_i)
  end

  def are_there_suitable_users?
    !current_user.nil? && !session[:users_id].empty?
  end

  def user_exist?
    User.find(params[:id])
  end

  def generate_new_session_users_id_list_size_in_argument(list_size)
    session[:users_id] = User.where.not('sex = ?', current_user.sex).shuffle.pluck(:id)[0..list_size - 1]
    session[:count] = 0
  end

  def get_name(user1, user2)
    users = [user1, user2].sort
    "private_#{users[0].id}_#{users[1].id}"
  end
end
