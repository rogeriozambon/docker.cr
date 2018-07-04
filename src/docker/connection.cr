require "socket"

module Docker
  class Connection
    HTTP_VERBS = %w(get put post delete)
    HTTP_CHUNK_SIZE = 1048576

    def initialize
      @socket = Socket.unix
      @socket.connect(Socket::UNIXAddress.new(Docker.socket_address))
    end

    {% for method in HTTP_VERBS %}
      def {{method.id}}(path : String, body : Hash(String, String) = {} of String => String)
        @socket.send(Utils::Request.body({{method}}, path, body))
        @socket.flush
        response, _ = @socket.receive(HTTP_CHUNK_SIZE)
        @socket.close
  
        Utils::Response.parse(response) unless "{{method.id}}" == "delete"
      end
    {% end %}
  end
end
