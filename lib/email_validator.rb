class EmailValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    if value = nil
      
    else value =~ /([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})/i
      record.errors.add(:email, 'Invalid Email')
    end
  end
end
