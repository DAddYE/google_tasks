require 'httparty'

module GoogleTasks
  class Client
    include HTTParty

    API_URL      = 'https://www.googleapis.com/tasks/'
    API_VERSION  = 'v1'
    CONFIG       = File.expand_path("~/.google-tasks")

    base_uri "#{API_URL}#{API_VERSION}"
    format :json

    def initialize(client_id, client_secret, api_key)
      @client_id, @client_secret, @api_key = client_id, client_secret, api_key
      @token   = File.read(CONFIG) rescue Login.authenticate(@client_id, @client_secret)
      File.open(CONFIG, "w") { |f| f.write(@token) }
      self.class.headers.merge!("Authorization" => "OAuth #{@token}")
    end

    %w(get update post delete patch).each do |m|
      define_method(m) do |options|
        options.merge!(:api_key => @api_key)
        path = options.delete(:path)
        resp = parse_respose(self.class.send(m, path, :query => options))
        if resp[:error]
          if resp[:error][:code] == 401
            @token = Login.authenticate(@client_id, @client_secret)
            File.open(CONFIG, "w") { |f| f.write(@token) }
            self.class.headers.merge!("Authorization" => "OAuth #{@token}")
            resp = parse_respose self.class.send(m, path, :query => options)
          elsif resp[:error][:message]
            raise resp[:error][:message]
          end
        end
        resp
      end
    end

    def lists(method=:list, list_id=nil, options={})
      path  = "/users/@me/lists"
      path << "/#{list_id}" if list_id
      options.merge!(:path => path)
      send(operations[method], options)
    end

    def tasks(method, list_id, task_id=nil, options={})
      path  = "/lists/#{list_id}"
      path << case method
        when :clear then "/clear"
        when :move  then "/tasks/move"
        else "/tasks"
      end
      path << "/#{taks_id}" if task_id
      options.merge!(:path => path)
      send(operations[method], options)
    end

    private
      def parse_respose(response)
        GoogleTasks::Response.new(response.parsed_response)
      end

      def operations
        @_operations ||= {
          :delete => :delete,
          :get    => :get,
          :insert => :post,
          :list   => :get,
          :update => :update,
          :clear  => :post,
          :move   => :update
        }
      end
  end # Client
end # GoogleTasks