class Article < ApplicationRecord
  has_many :comments  # Since we created comments in reference to article, not vice-versa,
  # we have to add this ourselves
  has_many :taggings
  has_many :tags, through: :taggings # Makes it much easier to gather up all of an article's tags
  has_attached_file :image, styles: {  medium: "300x300>", thumb: "100x100>" }
  # The "styles" above will only work if ImageMagick is working. We can call @article.image.url(:medium) to display an image of a particular size.
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  # The above has_attached_file method is part of the paperclip library. 
  # With that declaration, paperclip will understand that this model should accept a file 
  # attachment and that there are fields to store information about that file which start with image_ in this model’s database table.

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ") # Grab the "name" attribute for all tags (the actual word), then join the results of the "do" statement
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq # .uniq lets us ignore duplicate tags
    all_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
    self.tags = all_tags
  end

end
