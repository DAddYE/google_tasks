module GoogleTasks
  autoload :Client,   'google_tasks/client'
  autoload :Login,    'google_tasks/login'
  autoload :Error,    'google_tasks/error'
  autoload :Response, 'google_tasks/response'

  def self.new(client_id, client_secret, api_key)
    Client.new(client_id, client_secret, api_key)
  end
end # GoogleTasks