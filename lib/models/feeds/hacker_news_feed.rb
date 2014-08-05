require 'ruby-hackernews'
class HackerNewsFeed < Feed
  def update
    entries = RubyHackernews::Entry.all
    t = Time.now
    entries.each do |e|
      if Story.where(url: e.link.href).empty?
        s = Story.new
        s.feed = self
        s.author = e.user.name
        s.published = e.time
        s.story_content = e.text
        s.title = e.link.title
        s.fetched_at = t
        s.timestamp = e.time
        s.save!
      end
    end
  end
end
