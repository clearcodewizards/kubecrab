module CrabHelper
  def password_type?(input_name)
    name = input_name.downcase
    return true if name.include?("password") ||
                   name.include?("token") ||
                   name.include?("key")

    false
  end
end
