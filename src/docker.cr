require "base64"
require "./docker/*"

module Docker
  extend self

  def socket_address
    @@address || "/var/run/docker.sock"
  end

  def socket_address=(address : String)
    @@address = address
  end

  def credentials
    @@credentials || nil
  end

  ##
  # Authentication
  # https://docs.docker.com/engine/api/v1.27/#section/Authentication
  #
  def login(body : Hash?)
    @@credentials = Base64.encode(body.to_json)

    connection = Connection.new
    connection.post("/auth", body: body)
  end

  def logout
    @@credentials = nil
  end
end
