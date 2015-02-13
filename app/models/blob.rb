class Blob

  attr_reader :data

  def initialize(hash={})
    @data = hash
  end
  
  def update(new_hash)
    new_hash.keys.each do |key|
      if @data.key?(key)
        update_data(new_hash, key)
      else
        @data[key] = new_hash[key]
      end
    end
  end

  def update_data(new_hash, key)
    if @data[key].is_a?(Hash)
      blob = Blob.new(@data[key])
      blob.update(new_hash[key])
      @data[key] = blob.data
    else
      @data[key] = new_hash[key]
    end
  end

end