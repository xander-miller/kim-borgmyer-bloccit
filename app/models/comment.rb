class Comment < ActiveRecord::Base

  after_create :send_favorite_emails

  belongs_to :post
  belongs_to :user

  default_scope{ order( 'created_at DESC' ) }

  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  private

  def send_favorite_emails

    post.favorites.each do | favorite |
      FavoriteMailer.new_comment( favorite.user, post, self ).deliver
    end

  end

end
