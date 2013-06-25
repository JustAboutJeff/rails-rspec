class Post < ActiveRecord::Base
  attr_accessible :title, :content, :is_published, :slug

  scope :recent, order: "created_at DESC", limit: 5

  before_save :titleize_title, :slugify_title

  validates_presence_of :title, :content

  private

  def titleize_title
    self.title = title.titleize
  end

  def slugify_title
    #strip the string
    self.slug = self.title.strip.downcase

    #blow away apostrophes
    self.slug.gsub! /['`!]/,""

    # @ --> at, and & --> and
    self.slug.gsub! /\s*@\s*/, " at "
    self.slug.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric, underscore or periods with underscore
    self.slug.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'  

    #convert double underscores to single
    self.slug.gsub! /_+/,"-"

    #strip off leading/trailing underscore
    self.slug.gsub! /\A[_\.]+|[_\.]+\z/,""

    self.slug
  end
end
