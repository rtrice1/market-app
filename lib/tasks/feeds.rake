require 'open-uri'
require 'open_uri_redirections'

desc "Go get a feed"
task :get_feeds do
  rss = SimpleRSS.parse open('http://rss.slashdot.org/Slashdot/slashdot/to',:allow_redirections => :safe)

  rss.channel.title # => "Slashdot"
  rss.channel.link # => "http://slashdot.org/"
  puts rss.items.first.link # => "http://books.slashdot.org/article.pl?sid=05/08/29/1319236&amp;from=rss"

end
