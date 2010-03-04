class GaUser  
  @@reset = nil
  attr_accessor :username, :password
  def initialize
    @username = nil
    @password = nil
  end

  def self.reset?
    @@reset
  end

  def self.reset_connection(params)
    begin
      ProdDb.establish_connection(params)
      #self.logger = Logger.new(STDOUT)
      ProdDb.connection.execute("ALTER SESSION set NLS_DATE_FORMAT ='DD-MON-FXYYYY'")
      @@reset = true 
      return "Login successful"
    rescue Exception => e
      @@reset = false 
      return "#{e.message}: might I recommend SQL+ to fix this" if e.is_a?(OCISuccessWithInfo) 
      return e.message
    end
  end
end

