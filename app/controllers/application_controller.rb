class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Method

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!, unless: :devise_controller?
  before_action :authorize_mission_control, if: :mission_control_controller?
  after_action :verify_authorized, unless: :devise_controller?

  layout :set_layout

  private

  def authorize_mission_control
    authorize ApplicationJob, :index?
  end

  def mission_control_controller?
    is_a? ::MissionControl::Jobs::ApplicationController
  end

  def set_layout
    if user_signed_in?
      "application"
    else
      "devise"
    end
  end
end
