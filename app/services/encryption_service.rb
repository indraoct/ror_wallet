# app/services/encryption_service.rb

class EncryptionService
  # Encrypt data
  def self.encrypt(data)
    Rails.application.config.encryption[:encryptor].encrypt_and_sign(data)
  end

  # Decrypt data
  def self.decrypt(data)
    Rails.application.config.encryption[:encryptor].decrypt_and_verify(data)
  end
end
