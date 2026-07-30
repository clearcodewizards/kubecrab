class CrabsController < ApplicationController
  before_action :set_crab, only: %i[show destroy restart upgrade]

  def index
    @pagy, @crabs = pagy(:offset, authorize(policy_scope(Crab)))
  end

  def show; end

  def new
    @crab = Crab.new
    @crab.template_id = params[:template_id]
    authorize(@crab)
  end

  def create
    @crab = Crab.new(permitted_attributes(Crab))
    @crab.user = current_user
    authorize(@crab)

    raise "Limit reached" unless current_user.crabs.where(template_id: @crab.template.id).count < @crab.template.limit
    raise "No payment found" if @crab.template.stripe? && !current_user.templates.exists?(@crab.template.id)

    return redirect_to new_crab_path(template_id: @crab.template.id), alert: "Name already taken" \
      if Crab.find_by(name: @crab.name) || Rails.application.config.x.exclude_names.include?(@crab.name)

    respond_to do |format|
      if @crab.save
        DeployJob.perform_later(@crab)
        format.html { redirect_to crabs_path, notice: "Crab has been created." }
      else
        format.html { render :new, status: :unprocessable_content }
      end
    end
  end

  def destroy
    DestroyJob.perform_later(@crab)
    @crab.update!(status: :deleting)
    redirect_to crabs_path, notice: "Crab is scheduled for deletion."
  end

  def restart
    RestartJob.perform_later(@crab)
    @crab.update!(status: :restarting)
    redirect_to crab_path(@crab), notice: "Crab is scheduled for restart."
  end

  def upgrade
    UpgradeJob.perform_later(@crab)
    @crab.update!(status: :upgrading)
    redirect_to crab_path(@crab), notice: "Crab is scheduled for upgrade."
  end

  private

  def set_crab
    @crab = Crab.find(params.expect(:id))
    authorize @crab
  end
end
