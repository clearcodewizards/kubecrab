class ApplicationJob < ActiveJob::Base
  attr_reader :crab_id, :user_id, :options, :template, :secrets

  def crab_init(crab)
    @crab_id = crab.id
    @user_id = crab.user.id
    @options = crab.options
    @secrets = crab.template.template_options.where.not(provisioner: nil).to_h do |opt|
      [opt.name, opt.provisioner.constantize.new.call(crab)]
    end
    @tempfile = Tempfile.new
    @template = @tempfile.path
    @tempfile.write(ERB.new(crab.template.template).result(binding))
    @tempfile.close
  end

  def crab_cleanup
    @tempfile.unlink
  end
end
