class Scraper
  require 'open-uri'
  require 'net/http'
  require 'uri'

  #we get a random user-agent to send with the open command
  #so that youtube thinks we're making requests from different apps and not scraping
  USER_AGENTS = ["Mozilla/3.0 (Win95; I)", 
                 "Mozilla/3.01 (Macintosh; PPC)",
                 "Mozilla/4.0 (compatible; MSIE 4.01; AOL 4.0; Windows 98)",
                 "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)",
                 "Mozilla/5.0 (compatible; Konqueror/2.2.2; Linux 2.4.14-xfs; X11; i686)",
                 "Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1",
                 "Opera/6.x (Windows NT 4.0; U) [de]",
                 "Opera/7.x (Windows NT 5.1; U) [en]"]
  

  def self.metacafe(vid_id)

    # Make sure you put the trailing slash on! 
    url = URI.parse('http://www.metacafe.com/watch/'+vid_id+'/') 

    found = false 
    until found 
      host, port = url.host, url.port if url.host && url.port 
      req = Net::HTTP::Get.new(url.path) 
      res = Net::HTTP.start(host, port) {|http|  http.request(req) } 
      res.header['location'] ? url = URI.parse(res.header['location']) : 
    found = true 
    end 
    
    fs = res.body.index("mediaURL")
    fe = res.body.index("flv")
    
    ss = "http://akvideos.metacafe.com/ItemFiles/%5BFrom%20www.metacafe.com%5D%20780031.4722192.11.flv"
    
    fe = fe - fs
    link = res.body.slice(fs+9, fe)
    
    server_arr = "metacafe"
    
    link = "server=#{server_arr}&video_id=#{vid_id}&sk=#{link.to_s}"

    if fs > 0
      return link
    else
      return "success=false&status=page_not_found"
    end
  end
      
end
