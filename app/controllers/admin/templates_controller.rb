module Admin
  class TemplatesController < ApplicationController
    before_action :set_template, only: %i[edit update destroy]

    def index
      @templates = authorize(policy_scope(Template))
    end

    def new
      @template = authorize(Template.new)
    end

    def edit; end

    def create
      @template = authorize(Template.new(permitted_attributes(Template)))

      respond_to do |format|
        if @template.save
          format.html { redirect_to edit_admin_template_path(@template), notice: "Template has been created." }
        else
          format.html { render :new, status: :unprocessable_content }
        end
      end
    end

    def update
      respond_to do |format|
        if @template.update(permitted_attributes(@template))
          format.html { redirect_to admin_templates_path, notice: "Template has been updated." }
        else
          format.html { render :show, status: :unprocessable_content }
        end
      end
    end

    def destroy
      @template.destroy!
      redirect_to admin_templates_path
    end

    private

    def set_template
      @template = Template.find(params.expect(:id))
      authorize @template
    end
  end
end
