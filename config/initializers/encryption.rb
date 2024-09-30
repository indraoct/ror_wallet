# config/initializers/encryption.rb

# Use Rails secret_key_base as the base for generating encryption keys
key = ActiveSupport::KeyGenerator.new(Rails.application.secret_key_base).generate_key('psCidtwpgwS-aErQq68sJqYMHWIFOa1l', 32)
salt = ActiveSupport::KeyGenerator.new(Rails.application.secret_key_base).generate_key('Ki3sSu6IAIdDz57F3UBSxSxQo_I50SQw', 32)

Rails.application.config.encryption = {
  key: key,
  salt: salt,
  encryptor: ActiveSupport::MessageEncryptor.new(key, salt)
}