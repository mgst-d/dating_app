# class UsersGenerator generates new users for users#index
class UsersGenerator
  def self.call(current_user, session)
    session[:count] ||= -1
    if users_id_list_is_nil_or_count_is_full?(current_user, session)
      generate_new_session_users_id_list(current_user, session, 100)
    end
    session[:count] += 1
    User.find(session[:users_id][session[:count]]) if are_there_suitable_users?(current_user, session)
  end

  def self.users_id_list_is_nil_or_count_is_full?(current_user, session)
    !current_user.nil? && (session[:users_id].blank? || ((session[:count]) + 1) >= session[:users_id].size)
  end

  def self.are_there_suitable_users?(current_user, session)
    !current_user.nil? && !session[:users_id].empty?
  end

  def self.generate_new_session_users_id_list(current_user, session, list_size)
    session[:users_id] = User.where.not(sex: current_user.sex).limit(list_size).shuffle.pluck(:id)
    session[:count] = -1
  end
end
