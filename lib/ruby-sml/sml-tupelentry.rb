require 'ruby-sml/nilclass-mixin'
require 'ruby-sml/sml-time'

module SML

  class TupelEntry
    attr_accessor :server_id, :seconds_index, :status, :unit_pa, :scaler_pa, :value_pa, :unit_r1, :scaler_r1, :value_r1, :unit_r4, :scaler_r4, :value_r4, :signature_pa_r1_r4, :unit_ma, :scaler_ma, :value_ma, :unit_r2, :scaler_r2, :value_r2, :unit_r3, :scaler_r3, :value_r3, :signature_ma_r2_r3

    def initialize(server_id, seconds_index, status, unit_pa, scaler_pa, value_pa, unit_r1, scaler_r1, value_r1, unit_r4, scaler_r4, value_r4, signature_pa_r1_r4, unit_ma, scaler_ma, value_ma, unit_r2, scaler_r2, value_r2, unit_r3, scaler_r3, value_r3, signature_ma_r2_r3)
      @server_id = server_id
      @seconds_index = seconds_index
      @status = status

      @unit_pa = unit_pa
      @scaler_pa = scaler_pa
      @value_pa = value_pa

      @unit_r1 = unit_r1
      @scaler_r1 = scaler_r1
      @value_r1 = value_r1

      @unit_r4 = unit_r4
      @scaler_r4 = scaler_r4
      @value_r4 = value_r4

      @signature_pa_r1_r4 = signature_pa_r1_r4

      @unit_ma = unit_ma
      @scaler_ma = scaler_ma
      @value_ma = value_ma
      
      @unit_r2 = unit_r2
      @scaler_r2 = scaler_r2
      @value_r2 = value_r2
      
      @unit_r3 = unit_r3
      @scaler_r3 = scaler_r3
      @value_r3 = value_r3

      @signature_ma_r2_r3 = signature_ma_r2_r3
    end

    def self.construct(array_rep)
      return nil if array_rep.nil?
      server_id = array_rep.shift
      seconds_index = SML::Time.construct(array_rep.shift)
      status = array_rep.shift
      array_rep.shift

      unit_pa = array_rep.shift
      array_rep.shift
      scaler_pa = array_rep.shift
      array_rep.shift
      value_pa = array_rep.shift
      array_rep.shift

      unit_r1 = array_rep.shift
      array_rep.shift
      scaler_r1 = array_rep.shift
      array_rep.shift
      value_r1 = array_rep.shift
      array_rep.shift

      unit_r4 = array_rep.shift
      array_rep.shift
      scaler_r4 = array_rep.shift
      array_rep.shift
      value_r4 = array_rep.shift
      array_rep.shift

      signature_pa_r1_r4 = array_rep.shift

      unit_ma = array_rep.shift
      array_rep.shift
      scaler_ma = array_rep.shift
      array_rep.shift
      value_ma = array_rep.shift
      array_rep.shift
      
      unit_r2 = array_rep.shift
      array_rep.shift
      scaler_r2 = array_rep.shift
      array_rep.shift
      value_r2 = array_rep.shift
      array_rep.shift
      
      unit_r3 = array_rep.shift
      array_rep.shift
      scaler_r3 = array_rep.shift
      array_rep.shift
      value_r3 = array_rep.shift
      array_rep.shift

      signature_ma_r2_r3 = array_rep.shift

      return nil if seconds_index.nil?
      return SML::TupelEntry.new(server_id, seconds_index, status, unit_pa, scaler_pa, value_pa, unit_r1, scaler_r1, value_r1, unit_r4, scaler_r4, value_r4, signature_pa_r1_r4, unit_ma, scaler_ma, value_ma, unit_r2, scaler_r2, value_r2, unit_r3, scaler_r3, value_r3, signature_ma_r2_r3)
    end
    def to_a
      return [] << server_id << seconds_index.to_a << status << :uint64 << unit_pa << :uint8 << scaler_pa << :int8 << value_pa << :int64 << unit_r1 << :uint8 << scaler_r1 << :int8 << value_r1 << :int64 << unit_r4 << :uint8 << scaler_r4 << :int8 << value_r4 << :int64 << signature_pa_r1_r4 << unit_ma << :uint8 << scaler_ma << :int8 << value_ma << :int64 << unit_r2 << :uint8 << scaler_r2 << :int8 << value_r2 << :int64 << unit_r3 << :uint8 << scaler_r3 << :int8 << value_r3 << :int64 << signature_ma_r2_r3
    end

  end

end
