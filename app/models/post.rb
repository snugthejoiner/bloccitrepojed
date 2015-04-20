class Post < ActiveRecord::Base
    has_one :summary
    has_many :votes, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    belongs_to :user
    belongs_to :topic
    
    default_scope { order('rank DESC') }
    mount_uploader :image, ImageUploader
    
    
    validates :title, length: { minimum: 5 }, presence: true
    validates :body, length: { minimum: 20 }, presence: true
    validates :topic, presence: true
    validates :user, presence: true

    
    def up_votes
        self.votes.where(value: 1).count  
    end
    
    def down_votes
        self.votes.where(value: -1).count  
    end
        
    def points
        self.votes.sum(:value).to_i
    end
    
    def update_rank
        age_in_days = (self.created_at - Time.new(1970,1,1)) / (60 * 60 * 24) #1 day in seconds
        new_rank = self.points + age_in_days
        
        self.update_attribute(:rank, new_rank)
    end
    
    
    def create_vote
        user.votes.create(value: 1, post: self)
    end
    
    def save_with_initial_vote
        ActiveRecord::Base.transaction do 
            self.save
            self.create_vote
        end
    end
    
end
