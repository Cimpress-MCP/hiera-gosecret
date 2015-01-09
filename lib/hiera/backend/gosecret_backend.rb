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
        Hiera.debug("Found gosecret encrypted value at #{key}: #{answer}")
        # decrypt(answer)
        case resolution_type
        when :array
          new_answer ||= []
          answer.each do |item|
            new_answer << decrypt(item) || item
          end
          return new_answer
        when :hash
          # TODO: Verify if this works for nested hashes
          new_answer ||= {}
          answer.each do |key, value|
            new_answer[key] = decrypt(value) || value
          end
          return new_answer
        else
          return decrypt(answer)
        end
      end

      def decrypt(value)
        if value != nil and value.is_a?(String) and /\[(gosecret(\|[^\]\|]*){4})\]/.match(value)
          `gosecret-decrypt "#{Config[:gosecret][:keydir]}" "#{value}"`
        end
      end
    end
  end
end