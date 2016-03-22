class TinNumValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless value =~ /\A[0-9]{3}-[0-9]{3}-[0-9]{3}-[0-9]{3}$\z/i
      record.errors.add(:tin_num, 'Invalid tin number.')
    end
  end
end
