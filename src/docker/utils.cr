require "json"
require "http/params"

module Docker
  class Utils
    module Params
      def self.build(options : Hash?)
        return "" unless options

        HTTP::Params.build do |form|
          options.each { |k, v| form.add(k, v) }
        end
      end
    end

    module Request
      CR_NL = "\r\n"

      def self.body(method, path, body)
        request = [
          method.upcase, " ",
          path, " ",
          "HTTP/1.1", CR_NL,
          "Host: localost", CR_NL,
          "User-Agent: docker.cr/", Docker::VERSION, CR_NL,
          "Accept: */*", CR_NL
        ]

        if body
          body = body.to_json

          request.concat([
            "Content-Type: application/json", CR_NL,
            "Content-Length: #{body.bytesize}", CR_NL, CR_NL,
            body
          ])
        end

        request
          .concat([CR_NL, CR_NL])
          .join
      end
    end

    module Response
      def self.parse(response)
        JSON.parse(response.match(/[\[|\{?].*[\]|\}]/m).not_nil![0])
      end
    end
  end
end
