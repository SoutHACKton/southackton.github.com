#! /usr/bin/env ruby

require 'nokogiri'

# Parsed results in wordpress.xml

# Change your octopress feed template in source/atom.xml
# Change the limit in {% for post in site.posts limit: to a value higher than your postcount to ensure the creation of the feed of
# ALL your posts
# Add a line "<categories>{{post.categories}}</categories>" in the <entry> Tag.
# rake generate and copy the public/atom.xml to the folder where you saved this script.

# Change your wordpress permalink format to user defined /%year%/%monthnum%/%day%/%postname%/


# Enter the specifics of your wordpress blog here:
BLOGTITLE     = "SoutHACKton"
BLOGADDRESS   = "http://southackton.org.uk/"
BLOGDESCRIPTION = "Hackers and makers of Southampton, part of the So Make It Makerspace"
PUBDATE     = "Tue, 1 May 2013 15:12:48 +0000"
LANGUAGE    = "en-GB"

# Enter your specifics here. Make sure that the author exists and that it is the only one registered user
AUTHOR_LOGIN  = "southackton"
AUTHOR_MAIL   = "southackton@southackton.org.uk"

# Open the file
ip = Nokogiri::XML(File.open(File.join(File.dirname(__FILE__), "atom.xml"), "r"))
op = File.open(File.join(File.dirname(__FILE__), "wordpress.xml"), "w")

# Get a list of the categories.
# If you have multiple categories with more than 5 letters,
# some CamelCase split magic will happen.
catarray = Array.new
ip.css('categories').each do |cat|
  if cat.text.length > 5
    temparray = cat.text.split /(?=[A-Z])/
    temparray.each do |splitcat|
      if splitcat.length > 5
        catarray.push(splitcat)
      end
    end
  else
    catarray.push(cat.text)
  end
end
catarray.uniq!

op.puts '<?xml version="1.0" encoding="UTF-8" ?>'
op.puts '<rss version="2.0"'
op.puts 'xmlns:excerpt="http://wordpress.org/export/1.2/excerpt/"'
op.puts 'xmlns:content="http://purl.org/rss/1.0/modules/content/"'
op.puts 'xmlns:wfw="http://wellformedweb.org/CommentAPI/"'
op.puts 'xmlns:dc="http://purl.org/dc/elements/1.1/"'
op.puts 'xmlns:wp="http://wordpress.org/export/1.2/"'
op.puts '>'
op.puts ''
op.puts '<channel>'

# The general blog specifics goes here
op.puts '<title>' + BLOGTITLE + '</title>'
op.puts '<link>' + BLOGADDRESS + '</link>'
op.puts '<description>' + BLOGDESCRIPTION + '</description>'
op.puts '<pubDate>' + PUBDATE + '</pubdate>'
op.puts '<language>'+ LANGUAGE + '</language>'
op.puts '<wp:wxr_version>1.2</wp:wxr_version>'
op.puts '<wp:base_site_url>' + BLOGADDRESS + '</wp:base_site_url>'
op.puts '<wp:base_blog_url>' + BLOGADDRESS + '</wp:base_blog_url>'
op.puts ''

# The category tag generation goes here
catarray.each do |cat|
  if (cat != "")
    op.puts '<wp:category><wp:category_nicename>' + cat.downcase + '</wp:category_nicename><wp:category_parent></wp:category_parent><wp:cat_name><![CDATA[' + cat + ']]></wp:cat_name></wp:category>'
  end
end
op.puts ''

# The author specifics goes here
op.puts '<wp:author>'
op.puts '<wp:author_id>1</wp:author_id>' # MAKE SURE YOU ARE THE ONLY REGISTERED USER !!!!!
op.puts '<wp:author_login>' + AUTHOR_LOGIN + '</wp:author_login>'
op.puts '<wp:author_email>' + AUTHOR_MAIL + '</wp:author_email>'
op.puts '<wp:author_display_name><![CDATA[' + AUTHOR_LOGIN + ']]></wp:author_display_name>'
op.puts '<wp:author_first_name><![CDATA[]]></wp:author_first_name>' # You can change this later in the backend
op.puts '<wp:author_last_name><![CDATA[]]></wp:author_last_name>' # This too
op.puts '</wp_author>'
op.puts ''

# General stuff
op.puts '<generator>http://wordpress.org/?v=3.5.1</generator>'
op.puts ''

# The post generation foo goes here
postlist_length = ip.css('entry').length
ip.css('entry').each_with_index do |entry, index|
  op.puts '<item>'

  # Post title
  entry.css('title').each do |title|
    op.puts '<title>' + title.text + '</title>'
  end

  # Post link
  entry.css('link').each do |link|
    op.puts '<link>' +link['href'].chomp + '</link>'
  end

  # Post time 
  entry.css('updated').each do |updated|
    updated.text.match(/(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})\+(\d{2}):(\d{2})/)
    year = $1
    month = $2
    day = $3
    hour = $4
    minute = $5
    $timestamp = Time.new(year, month, day, hour, minute, 0, "+01:00")
    op.puts '<pubDate>' + $timestamp.strftime("%a, %d %b %Y %H:%M:%S +0000") + '</pubDate>' # Timestamp like Mon, 02 Apr 2007 22:00:00 +0000
  end

  # Post author
  op.puts'<dc:creator>' + AUTHOR_LOGIN + '</dc:creator>'

  # Post categories
  entry.css('categories').each do |cat|
    if (cat.text.length > 5)
      temparray = cat.text.split /(?=[A-Z])/
      temparray.each do |category|
        op.puts '<category><![CDATA[' + category + ']]></category>'
        op.puts '<category domain="category" nicename="' + category.downcase + '"><![CDATA[' + category + ']]></category>'
      end
    else
      op.puts '<category><![CDATA[' + cat.text + ']]></category>'
      op.puts '<category domain="category" nicename="' + cat.text.downcase + '"><![CDATA[' + cat.text + ']]></category>'
    end
  end

  # Post link
  entry.css('link').each do |link|
    op.puts '<guid isPermaLink="false">' +link['href'].chomp('/') + '</guid>'
  end

  # Post description
  op.puts '<description></description>'

  # Post content
  entry.css('content').each do |content|
    op.puts '<content:encoded><![CDATA[' + content.text + ']]></content:encoded>'
  end

  # Post excerpt
  op.puts '<excerpt:encoded><![CDATA[]]></excerpt:encoded>'

  # Post id
  op.puts '<wp:post_id>' + (postlist_length-index).to_s + '</wp:post_id>'

  # Post date
  op.puts '<wp:post_date>' + $timestamp.strftime("%Y-%m-%d %H:%M:%S") + '</wp:post_date>'
  op.puts '<wp:post_date_gmt>' + $timestamp.strftime("%Y-%m-%d %H:%M:%S") + '</wp:post_date_gmt>'

  # Metainfos about the post
  op.puts '<wp:comment_status>open</wp:comment_status>'
  op.puts '<wp:ping_status>open</wp:ping_status>'

  # Postname for permalinks
  entry.css('title').each do |title|
    op.puts '<wp:post_name>' + title.text.downcase.gsub(/\W/, "-") + '</wp:post_name>'
  end

  # Even more metainfos
  op.puts '<wp:status>publish</wp:status>'
  op.puts '<wp:post_parent>0</wp:post_parent>'
  op.puts '<wp:menu_order>0</wp:menu_order>'
  op.puts '<wp:post_type>post</wp:post_type>'
  op.puts '<wp:post_password></wp:post_password>'
  op.puts '<wp:is_sticky>0</wp:is_sticky>'

  op.puts '</item>'
  op.puts ''
end

# Close the last tags
op.puts '</channel>'
op.puts '</rss>'
