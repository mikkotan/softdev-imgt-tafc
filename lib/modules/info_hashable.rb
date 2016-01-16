module Modules
  module InfoHashable
    def info_hash
      attributes.delete_if { |key, value| %w(updated_at created_at id is_template transaction_id).include? key }
    end
    
    def ==(y)
      return false unless y.is_a? InfoHashable
      info_hash == y.info_hash
    end
  end
end
