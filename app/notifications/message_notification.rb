# To deliver this notification:

class MessageNotification < Noticed::Base
  deliver_by :database
end
