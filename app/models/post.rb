class Post < ActiveRecord::Base
    has_one :summary
    has_many :comments
    belongs_to :user
        belongs_to :topic
    scope :ordered_by_title, -> { order('title ASC') }
    scope :ordered_by_reverse_created_at, -> { order('created_at ASC') }
    default_scope { order('created_at DESC') }
end
