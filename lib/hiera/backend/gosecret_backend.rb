##
## Look up key in other backends and return decrypted value if it's a gosecret
## otherwise return nil
##
## :gosecret:keydir must be defined in config
##
require "base64"

class Hiera
  module Backend
    class Gosecret_backend

      @backends = nil

      def initialize(cache=nil)
        @backends = []
        Config[:backends].each do |p|
          next if p == "gosecret"
          backend = p.slice(0,1).capitalize + p.slice(1..-1) + "_backend"
          @backends.push(Hiera::Backend.const_get(backend).new()) if Hiera::Backend.const_defined?(backend)
        end
      end

      def lookup(key, scope, order_override, resolution_type)
        answer = nil
        @backends.each do |b|
          answer = b.lookup(key, scope, order_override, resolution_type)
          break if answer != nil
        end
        decrypt(answer) if answer != nil and answer.is_a? String and answer.start_with? "[gosecret|"
      end

      GOSECRET_REGEX = /\[(gosecret(\|[^\]\|]*){4})\]/

      def decrypt(value)
        `gosecret -keystore=#{Config[:gosecret][:keydir]} -mode=decrypt -value="#{value}"`
      end

    end
  end
end