# frozen_string_literal: true

class TemplateOptionPolicy < ApplicationPolicy
  def permitted_attributes
    %i[name provisioner]
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.none
      end
    end
  end
end
