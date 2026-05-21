# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    # POST /resource
    def create
      user = User.new(email: user_params[:email])
      user.password = SecureRandom.uuid
      return render :new, locals: { resource: user }, status: :unprocessable_content unless user.save

      auto_deploy_crab(user)
      user.send_reset_password_instructions
      redirect_to session_path(user), notice: "You will receive an email with instructions on how to set your password in a few seconds."
    end

    private

    def user_params
      params.expect(user: %i[email])
    end

    def auto_deploy_crab(user)
      template_id = Rails.application.config.x.auto_deploy_template
      return unless template_id.present? && user.crabs.where(template_id: template_id).none?

      crab = Crab.create!(name: Haikunator.haikunate(1000), user: user, template_id: template_id)
      DeployJob.perform_later(crab)
    end
  end
end
