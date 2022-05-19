# frozen_string_literal: true

module Users
  # This is RegistrationsController
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]

    # GET /resource/sign_up

    # POST /resource
    def create
      build_resource(sign_up_params)

      resource.save
      yield resource if block_given?
      if resource.persisted?
        if @user.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)

        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end

    # GET /resource/edit

    # PUT /resource
    def update
      self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

      resource_updated = update_resource(resource, account_update_params)
      yield resource if block_given?
      if resource_updated
        set_flash_message_for_update(resource, prev_unconfirmed_email)
        bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?

        respond_with resource, location: after_update_path_for(resource)
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end

    # DELETE /resource

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    protected

    def after_sign_up_path_for(_resource)
      user_path(current_user)
    end

    def after_update_path_for(_resource)
      user_path(current_user)
    end

    def sign_up_params
      devise_parameter_sanitizer.sanitize(:sign_up)
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up,
                                        keys: [:first_name, :last_name, :birth, :sex, :work_id, :yourself, :latitude,
                                               :longitude, { foto: [] }])
    end

    def account_update_params
      devise_parameter_sanitizer.sanitize(:account_update)
    end

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update,
                                        keys: [:first_name, :last_name, :birth, :sex, :work_id, :yourself, :latitude,
                                               :longitude, { foto: [] }])
    end

    # The path used after sign up.

    private

    def sign_in_after_change_password?
      return true if account_update_params[:password].blank?

      Devise.sign_in_after_change_password
    end
    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end
  end
end
