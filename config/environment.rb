# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address            => "smtp.gmail.com",
  :port               => "587",
  :domain             => "gmail.com",
  :authentication     => :plain,
  :user_name          => Rails.application.credentials.gmail_user_name, #should be you@domain.com
  :password           => Rails.application.credentials.gmail_password
}
