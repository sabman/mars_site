require 'crypt/blowfish'
namespace :mars do
  desc "set the password for oraprod in ROOT/opt/lib/config/database.yml"
  task :set_oraprod do
    puts ENV["username"]
    puts ENV["password"]
  end

  desc "generate encrypted password using the blowfish algorithm"
  task :generate_encrypted_password => "../../config/key" do
    puts Crypt::Blowfish.new(File.read("../../config/key")).encrypt_block(ENV["password"])
  end
  
  desc "decrypt password using the key from RAILS_ROOT/config/key"
  task :decrypt_password do
    puts Crypt::Blowfish.new(File.read("../../config/key")).decrypt_block(ENV["password"])
  end
end
