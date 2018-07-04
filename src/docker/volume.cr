module Docker
  class Volume
    def initialize
      @connection = Connection.new
    end

    ##
    # List volumes
    # https://docs.docker.com/engine/api/v1.27/#operation/VolumeList
    #
    def all
      @connection.get("/volumes")
    end

    ##
    # Inspect a volume
    # https://docs.docker.com/engine/api/v1.27/#operation/VolumeInspect
    # 
    def inspect(name : String)
      @connection.get("/volumes/#{name}")
    end

    ##
    # Create a volume
    # https://docs.docker.com/engine/api/v1.27/#operation/VolumeCreate
    # 
    def create(name : String, body : Hash?)
      @connection.post("/volumes/create", body: body)
    end

    ##
    # Remove a volume
    # https://docs.docker.com/engine/api/v1.27/#operation/VolumeDelete
    # 
    def remove(name : String, force : Bool = false)
      @connection.delete("/volumes/#{name}?force=#{force.to_s}")
    end

    ##
    # Delete unused volumes
    # https://docs.docker.com/engine/api/v1.27/#operation/VolumePrune
    # 
    def prune(options : Hash?)
      @connection.post("/volumes/prune?filters=#{Utils::Params.build(options)}")
    end
  end
end
