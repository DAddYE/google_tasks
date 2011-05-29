require 'signet/oauth_2/client'
require 'sinatra/base'
require 'launchy'

module GoogleTasks

  module Login
    extend self

    def authenticate(client_id, client_secret)
      server = Sinatra.new do
        set :code, ""
        get "/" do
          settings.code = params[:code]
          Process.kill(:INT, Process.pid)
          "Thanks! You may close this!"
        end
      end
      client = Signet::OAuth2::Client.new(
        :authorization_uri    => 'https://www.google.com/accounts/o8/oauth2/authorization',
        :token_credential_uri => 'https://www.google.com/accounts/o8/oauth2/token',
        :client_id            => client_id,
        :client_secret        => client_secret,
        :redirect_uri         => 'http://localhost:12736/',
        :scope                => 'https://www.googleapis.com/auth/tasks'
      )
      Launchy::Browser.run(client.authorization_uri.to_s)
      puts "... waiting browser"
      $stdout = $stderr = log_buffer = StringIO.new
      server.run!(:port => 12736, :host => '0.0.0.0')
      $stdout, $stderr = STDOUT, STDERR
      client.code = server.code
      client.fetch_access_token!
      client.access_token
    end
  end # ClientLogin
end # GoogleTasks