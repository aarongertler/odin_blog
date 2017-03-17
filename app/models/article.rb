class Article < ApplicationRecord
  has_many :comments  # Since we created comments in reference to article, not vice-versa,
  # we have to add this ourselves
end
