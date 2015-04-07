 class PostPolicy < ApplicationPolicy
    class Scope
        attr_reader :user, :scope
        def initialize(user, scope)
          @user = user
          @scope = scope
        end
        
        def resolve
            if !user.present?
                scope.none
            elsif user.admin? || user.moderator?
                scope.all
            else
                scope.where(:id => user.id).exists?
            end
        end
    end
    
    def index?
        true
    end
  
    def destroy
        user.present? && (record.user == user || user.admin? || user.moderator?)
    end
 end