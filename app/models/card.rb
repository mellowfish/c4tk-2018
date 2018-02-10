class Card < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :source, presence: true

  def self.as_type(type)
    type ||= "quote"
    type = type.camelize
    type = "Quote" unless Kernel.const_defined?(type)
    klass = Kernel.const_get(type)
    klass = Quote if klass.is_a?(Card)
    klass.new
  end

  def type_identifier
    type.downcase
  end

  def display_title
    title || default_display_title
  end

  def default_display_title
    "A #{type}" if persisted?
  end
end

class Audio < Card
  validates :url, presence: true

  def default_display_title
    "An Audio File" if persisted?
  end
end

class Song < Card
  validates :url, presence: true
end

class Video < Card
  validates :url, presence: true
end

class Picture < Card
  validates :url, presence: true
end

class Quote < Card
  validates :quote, presence: true
end

class Passage < Card
  validates :quote, presence: true
end

class Joke < Card
  validates :quote, presence: true
end

class Story < Card
  validates :quote, presence: true
end