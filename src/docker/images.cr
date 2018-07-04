module Docker
  class Image
    def initialize
      @connection = Connection.new
    end

    ##
    # List Images
    # https://docs.docker.com/engine/api/v1.27/#operation/ImageList
    # 
    def all(options : Hash?, all : Bool = false, digests : Bool = false)
      @connection.get("/networks?all=#{all.to_s}&digests=#{digests.to_s}&filters=#{Utils::Params.build(options)}")
    end
  end
end
