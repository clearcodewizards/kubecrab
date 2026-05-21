# frozen_string_literal: true

class TemplatePolicy < ApplicationPolicy
  def index?
    true
  end

  def permitted_attributes
    %i[name avatar limit base_url stripe_payment_link description instruction template status engine_id]
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
