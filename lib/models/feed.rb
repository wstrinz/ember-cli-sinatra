require_relative '../mixins/feed'
class Feed < ActiveRecord::Base
  has_many :stories
  include Mixins::Feed
end
