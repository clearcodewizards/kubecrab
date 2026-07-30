module Admin
  class EnginesController < ApplicationController
    before_action :set_engine, only: %i[update destroy]

    def index
      @engines = authorize(policy_scope(Engine))
    end

    def new
      @engine = authorize(Engine.new)
    end

    def create
      @engine = authorize(Engine.new(permitted_attributes(Engine)))

      respond_to do |format|
        if @engine.save
          format.html { redirect_to admin_engines_path, notice: "Engine has been created." }
        else
          format.html { render :new, status: :unprocessable_content }
        end
      end
    end

    def update
      respond_to do |format|
        if @engine.update(permitted_attributes(@engine))
          format.html { redirect_to admin_engines_path, notice: "Engine has been updated." }
        else
          format.html { render :show, status: :unprocessable_content }
        end
      end
    end

    def destroy
      @engine.destroy!
      redirect_to admin_engines_path
    end

    private

    def set_engine
      @engine = Engine.find(params.expect(:id))
      authorize @engine
    end
  end
end
