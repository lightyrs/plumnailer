$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'sinatra'

require 'plumnailer'

# sinatra web application for testing

get '/' do
  page_link = img = ''
  url = params[:url]

  if url
    chooser = Plumnailer::Chooser.new
    chooser.fetcher = chooser.img_parser.fetcher =
      Plumnailer::CachingFetcher.new('/tmp/plumnailer-test')
    if choice = chooser.choose(url)
      img_url = choice.source_url
      page_link = "<p><a href=\"#{url}\">#{url}</a></p>"
      img = "<p><img src=\"#{img_url}\" /></p>"
    else
      img = '<p>No images found</p>'
    end
  end

  <<-eos
<form method="get" action="">
<input type="text" name="url" size="50" />
<input type="submit" />
</form>

#{page_link}

#{img}
  eos
end
