class Post < ActiveRecord::Base

  has_many   :comments, dependent: :destroy
  has_many   :votes, dependent: :destroy
  has_many   :favorites, dependent: :destroy

  belongs_to :user
  belongs_to :topic

  default_scope{ order( 'rank DESC' ) }
  scope :visible_to, -> ( user ) { user ? all : joins( :topic ).where( 'topics.public' => true ) }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  mount_uploader :image, ImageUploader

  def up_votes
    self.votes.where( value: 1 ).count
  end

  def down_votes
    self.votes.where( value: -1 ).count
  end

  def points
    self.votes.sum( :value )
  end

  def update_rank

    age = ( created_at - Time.new( 1970, 1, 1 ) ) / ( 60 * 60 * 24 )
    new_rank = points + age

    update_attribute( :rank, new_rank )

  end

  def create_vote
    user.votes.create( value: 1, post: self )
  end

end
