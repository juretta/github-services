class Service::ScrumDo < Service
  string :username
  string :password
  string :project_slug

  def receive_push
    username = data["username"]
    password = data["password"]

    url = "http://www.scrumdo.com/hooks/github/#{data["project_slug"]}"
    res = http_post url do |req|
       req.body = {:payload => payload.to_json, :username=>username, :password=>password}
    end

    if res.status < 200 || res.status > 299
      raise_config_error
    end
    
  end
end

