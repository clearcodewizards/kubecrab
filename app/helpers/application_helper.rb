module ApplicationHelper
  def current_controller?(path)
    path[1..].eql?(controller.controller_path)
  end

  def available_provisioners
    Rails.root.glob("app/provisioners/*.rb")
         .map { |f| File.basename(f, ".rb").camelize }
         .sort
  end
end
