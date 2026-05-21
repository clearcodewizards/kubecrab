# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

ActiveRecord::Migration.say_with_time("Creating admin user...") do
  next if User.find_by(email: "admin@localhost")

  user = User.find_or_create_by(
    email: "admin@localhost",
    name: "Admin",
    role: :admin
  )
  user.password = "changeme"
  user.save!
end

ActiveRecord::Migration.say_with_time("Creating engines...") do
  Engine.find_or_create_by(
    name: "kubernetes",
    deploy_command: "kubectl apply -f <%= template %>",
    status_command: "kubectl -n ns<%= user_id %> get pod -l app=app<%= crab_id %>",
    upgrade_command: "kubectl apply -f <%= template %>",
    restart_command: "kubectl -n ns<%= user_id %> rollout restart deployment app<%= crab_id %>",
    destroy_command: "kubectl delete -f <%= template %>"
  )
end
