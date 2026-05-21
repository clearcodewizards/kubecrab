class StatusJob < ApplicationJob
  queue_as :default

  def perform
    Crab.find_each do |crab|
      logger.info "Status for #{crab.name}"

      crab_id = crab.id
      user_id = crab.user.id

      command = ERB.new(crab.template.engine.status_command).result(binding)
      output, status = Open3.capture2(command)

      next logger.error output unless status.exitstatus.zero?

      crab.update!(status: filter_status(output))
    end
  end

  def filter_status(output)
    return :creating if output.include?("Pending")
    return :stopping if output.include?("Terminating")
    return :stopped if output.include?("Succeeded")
    return :error if output.include?("Failed") || output.include?("Unknown")

    :running
  end
end
