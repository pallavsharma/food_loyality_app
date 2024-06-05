# lib/validators/url_validator.rb
class UrlValidator < ActiveModel::EachValidator
  URL_REGEX = /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/

  def validate_each(record, attribute, value)
    unless value =~ URL_REGEX
      record.errors.add(attribute, "is not a valid URL")
    end
  end
end
