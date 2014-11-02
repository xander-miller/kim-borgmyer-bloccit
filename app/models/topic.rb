class Topic < ActiveRecord::Base

  has_many   :posts, dependent: :destroy

  scope :privately_viewable, -> { where( public: false ) }
  scope :publicly_viewable, -> { where( public: true ) }
  scope :visible_to, -> ( user ) { publicly_viewable }
  
end
