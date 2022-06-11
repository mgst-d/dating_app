# This is UserHelper
module UsersHelper
  def full_name(user)
		"#{user.first_name} #{user.last_name}"
	end

	def age(user)
    (Time.zone.today.strftime('%Y%m%d').to_i - user.birth.strftime('%Y%m%d').to_i) / 10_000
  end
end
