class Article < ApplicationRecord
  has_many :comments  # Since we created comments in reference to article, not vice-versa,
  # we have to add this ourselves
  has_many :taggings
  has_many :tags, through: :taggings # Makes it much easier to gather up all of an article's tags

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
