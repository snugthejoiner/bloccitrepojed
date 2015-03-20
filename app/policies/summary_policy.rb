 class SummaryPolicy < ApplicationPolicy
  def create?
   user.present?
  end
 end