require "test_helper"

class ApplicationJobTest < ActiveSupport::TestCase
  class TestJob < ApplicationJob
    queue_as :default

    def perform; end
  end

  setup do
    @job = TestJob.new
    @crab = crabs(:default)
  end

  test "crab_init populates secrets for template options with a provisioner" do
    @job.crab_init(@crab)

    assert_not_nil @job.secrets["timestamp"]
  end

  test "crab_init excludes template options without a provisioner" do
    @job.crab_init(@crab)

    assert_not @job.options.key?("api_url")
  end
end
