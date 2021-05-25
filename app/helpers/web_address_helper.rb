module WebAddressHelper
  def shortened_url(url)
    ENV["HOST_URL"].to_s+"/"+url
  end
end
