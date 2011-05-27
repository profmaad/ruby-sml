require 'digest/sha2'
require 'openssl'

require 'ruby-sml/nilclass-mixin'
require 'ruby-sml/sml-time'

module SML

  class ListEntry
    attr_accessor :name, :status, :status_type, :value_time, :unit, :scaler, :value, :value_type, :signature

    def initialize(name, status, status_type, value_time, unit, scaler, value, value_type, signature)
      @name = name
      @status = status
      @status_type = status_type
      @value_time = value_time
      @unit = unit
      @scaler = scaler
      @value = value
      @value_type = value_type
      @signature = signature
    end

    def self.construct(array_rep)
      return nil if array_rep.nil?
      name = array_rep.shift
      status = array_rep.shift
      status_type = array_rep.shift
      value_time = SML::Time.construct(array_rep.shift)
      unit = array_rep.shift
      scaler = array_rep.shift
      value = array_rep.shift
      value_type = array_rep.shift
      signature = array_rep.shift

      return nil if value.nil?
      return SML::ListEntry.new(name, status, status_type, value_time, unit, scaler, value, value_type, signature)
    end

    def self.pconstruct(o={})
      return SML::ListEntry.construct([o[:name], o[:status], o[:status_type], o[:value_time], o[:unit], o[:scaler], o[:value], o[:value_type], o[:signature]])
    end

    def to_a
      return [] << name << status << status_type << value_time.to_a << unit << scaler << value << value_type << signature
    end

    def calculate_hash(server_id)
      return nil unless [:int8, :int16, :int32, :int64, :uint8, :uint16, :uint32, :uint64].include?(@value_type)
      return nil unless @value_time.type == :timestamp
      return nil unless @name.length == 6

      bytes = String.new
      bytes += server_id
      (10-server_id.length).times do
        bytes += [0x00].pack('c')
      end
      bytes += [@value_time.value].pack('N')
      bytes += [@status].pack('c')
      bytes += @name
      bytes += [@unit].pack('c')
      bytes += [@scaler].pack('c')
      bytes += [(@value & 0xffff0000) >> 32,(@value & 0x0000ffff)].pack('NN')
      17.times do
        bytes += [0x00].pack('c')
      end

      hash = Digest::SHA2.new(256).digest(bytes)[0,24]
      
      return hash
    end
    def sign(server_id, private_key)
      hash = calculate_hash(server_id)
      return nil if hash.nil?

      signature = OpenSSL::PKey::EC.new(private_key).dsa_sign_asn1(hash)

      @signature = signature
    end
    def verify(server_id, public_key)
      hash = calculate_hash(server_id)
      return nil if hash.nil?
      
      return OpenSSL::PKey::EC.new(public_key).dsa_verify_asn1(hash,@signature)
    end
        
  end

end
