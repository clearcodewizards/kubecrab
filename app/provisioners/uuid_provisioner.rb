class UuidProvisioner
  def call(_)
    SecureRandom.uuid
  end
end
