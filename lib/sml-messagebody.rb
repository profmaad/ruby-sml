require 'sml-publicopen'
require 'sml-publicclose'
require 'sml-getprofilepack'
require 'sml-getprofilelist'
require 'sml-getprocparameter'
require 'sml-setprocparameter'
require 'sml-getlist'
require 'sml-attention'

module SML

  class MessageBody
    def self.construct(array_rep)
      return nil if array_rep.nil?
      choice = array_rep.shift
      body_array = array_rep.shift
      return case choice
             when 0x0100
               SML::PublicOpen::Request.construct(body_array)
             when 0x0101
               SML::PublicOpen::Response.construct(body_array)
             when 0x0200
               SML::PublicClose::Request.construct(body_array)
             when 0x0201
               SML::PublicClose::Response.construct(body_array)
             when 0x0300
               SML::GetProfilePack::Request.construct(body_array)
             when 0x0301
               SML::GetProfilePack::Response.construct(body_array)
             when 0x0400
               SML::GetProfileList::Request.construct(body_array)
             when 0x0401
               SML::GetProfileList::Response.construct(body_array)
             when 0x0500
               SML::GetProcParameter::Request.construct(body_array)
             when 0x0501
               SML::GetProcParameter::Response.construct(body_array)
             when 0x0600
               SML::SetProcParameter::Request.construct(body_array)
             when 0x0601
               nil
               # SML::SetProcParameter::Response.construct(body_array)
               # SML_SetProcParameter.Res is supposed to exist, but the standard doesn't define it
               # respones to SetProcParameter.Req are supposed to be SML_Attention.Res'
             when 0x0700
               SML::GetList::Request.construct(body_array)
             when 0x0701
               SML::GetList::Response.construct(body_array)
             when 0xff01
               SML::Attention::Response.construct(body_array)
             end      
    end
  end

end
