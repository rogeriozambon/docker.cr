module Docker
  class Network
    def initialize
      @connection = Connection.new
    end

    ##
    # List networks
    # https://docs.docker.com/engine/api/v1.27/#operation/NetworkList
    # 
    def all
      @connection.get("/networks")
    end

    ##
    # Inspect a network
    # https://docs.docker.com/engine/api/v1.27/#operation/NetworkInspect
    # 
    def inspect(name : String)
      @connection.get("/networks/#{name}")
    end

    ##
    # Create a network
    # https://docs.docker.com/engine/api/v1.27/#operation/NetworkCreate
    # 
    def create(body : Hash?)
      @connection.post("/networks/create", body: body)
    end

    ##
    # Remove a network
    # https://docs.docker.com/engine/api/v1.27/#operation/NetworkDelete
    # 
    def remove(name : String)
      @connection.delete("/networks/#{name}")
    end

    ##
    # Connect a container to a network
    # https://docs.docker.com/engine/api/v1.27/#operation/NetworkConnect
    # 
    def connect(id : String, body : Hash?)
      @connection.post("/networks/#{id}/connect", body: body)
    end

    ##
    # Disconnect a container from a network
    # https://docs.docker.com/engine/api/v1.27/#operation/NetworkDisconnect
    # 
    def disconnect(id : String, body : Hash?)
      @connection.post("/networks/#{id}/disconnect", body: body)
    end

    ##
    # Delete unused networks
    # https://docs.docker.com/engine/api/v1.27/#operation/NetworkPrune
    # 
    def prune
      @connection.post("/networks/prune")
    end
  end
end
