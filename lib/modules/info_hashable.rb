module Modules
  module InfoHashable
    def info_hash
      attributes.delete_if { |key, _value| %w(updated_at created_at id is_template).include? key }
    end

    def ==(y)
      info_hash == y.info_hash
    end
  end
end
