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
        return answer if answer == nil

        new_answer = nil
        case resolution_type
        when :array
          new_answer = decrypt_array(answer)
        when :hash
          new_answer = decrypt_hash(answer)
        else
          new_answer = decrypt(answer)
        end
        return new_answer
      end

      def decrypt_hash(hash)
        hash.each do |key, value|
          value.is_a?(Hash) ? decrypt_hash(value) : ( value.is_a?(Array) ? (hash[key] = decrypt_array(value) || value) : (hash[key] = decrypt(value) || value) )
        end
      end

      def decrypt_array(array)
        array.map do |value|
          value.is_a?(Array) ? decrypt_array(value) : ( value.is_a?(Hash) ? decrypt_hash(value) : decrypt(value) || value )
        end
      end

      def decrypt(value)  
        if value != nil and value.is_a?(String) and /\[(gosecret(\|[^\]\|]*){4})\]/.match(value)
          Hiera.debug("Decrypting gosecret encrypted value: #{value}")
          return `gosecret-decrypt "#{Config[:gosecret][:keydir]}" "#{value}"`
        end
      end
    end
  end
end