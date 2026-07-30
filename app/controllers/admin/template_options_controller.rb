module Admin
  class TemplateOptionsController < ApplicationController
    before_action :set_template
    before_action :set_template_option, only: %i[edit update destroy]

    def index
      @template_options = @template.template_options
    end

    def new
      @template_option = @template.template_options.build
    end

    def edit; end

    def create
      @template_option = @template.template_options.build(permitted_attributes(TemplateOption))

      respond_to do |format|
        if @template_option.save
          format.html { redirect_to admin_template_options_path(@template), notice: "Template option has been created." }
          format.turbo_stream
        else
          format.html { render :new, status: :unprocessable_content }
        end
      end
    end

    def update
      respond_to do |format|
        if @template_option.update(permitted_attributes(@template_option))
          format.html { redirect_to admin_template_options_path(@template), notice: "Template option has been updated." }
        else
          format.html { render :show, status: :unprocessable_content }
        end
      end
    end

    def destroy
      @template_option.destroy!

      respond_to do |format|
        format.html { redirect_to admin_template_options_path(@template) }
        format.turbo_stream
      end
    end

    private

    def set_template
      @template = Template.find(params.expect(:template_id))
      authorize @template
    end

    def set_template_option
      @template_option = @template.template_options.find(params.expect(:id))
    end
  end
end
