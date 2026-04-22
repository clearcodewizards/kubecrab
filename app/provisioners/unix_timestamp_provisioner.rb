class UnixTimestampProvisioner
  def call(_)
    Time.now.to_i
  end
end
