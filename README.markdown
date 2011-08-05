Compare all of the images on an HTML page and sort them according to how well
they represent what the page is about. The top image could be used as a
thumbnail to represent the entire page.

Basic usage:

```ruby
require 'plumnailer'

chooser = Plumnailer::Chooser.new
choice = chooser.choose('http://urls.matthewm.boedicker.org/')
puts choice.source_url

choice.resize_to_fill(64, 64).write('thumb.jpg')
```

Alternate fetcher that caches images on local filesystem:

```ruby
require 'plumnailer'

chooser = Plumnailer::Chooser.new
chooser.fetcher = chooser.img_parser.fetcher =
  Plumnailer::CachingFetcher.new('/tmp/plumnailer-test')

choice = chooser.choose('http://urls.matthewm.boedicker.org/')
puts choice.source_url
```

Top five images:

```ruby
require 'plumnailer'

chooser = Plumnailer::Chooser.new
chooser.choose('http://urls.matthewm.boedicker.org/', :top => 5).each do |i|
  puts i.source_url
end
```

Questions and comments: <matthewm@boedicker.org>
