class CommentPolicy < ApplicationPolicy

  def create?
    user.present?
  end

  def destroy?
    user.present? && can_moderate?( user, record )
  end

end
