class ApplicationPolicy

  attr_reader :user, :record

  def initialize( user, record )

    @user = user
    @record = record

  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present? && ( record.user == user || user.admin? )
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def scope
    record.class
  end

  class Scope

    attr_reader :user, :scope

    def initialize( user, scope )

      @user = user
      @scope = scope

    end

    def resolve
      scope
    end

  end

  private

  def can_moderate?( user, record )
    record.user == user || user.admin? || user.moderator?
  end

end
