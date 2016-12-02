namespace :sync do
  task feeds: [:environment] do
    Feed.all.each do |feed|
      content = Feedjira::Feed.fetch_and_parse feed.url
      content.entries.each do |entry|
        local_entry = feed.entries.where(title: entry.title).first_or_initialize
        text = ''
        if entry.content.nil? then
          begin
            text = open(entry.url)
            rescue OpenURI::HTTPError
               puts "Couldn't retrieve the URL #{entry.url}"
               text = ''
          end
        else
          text = entry.content
        end
        content = Nokogiri::HTML(text)
        content.css('script, link').each { |node| node.remove }
        maincontent = 'body'
        if feed.name = 'Cnn' then maincontent = 'div#storytext' end
        mytext = content.css(maincontent).text
        mytext.gsub!(/[^0-9A-Za-z ]/, '')
        puts mytext
        local_entry.update_attributes(content: mytext, author: entry.author, url: entry.url, published: entry.published)
        p "Synced Entry - #{entry.title}"
      end
      p "Synced Feed - #{feed.name}"
    end
  end
end
