module Selenium
  class CommandError < RuntimeError
  end
  
  class InvalidCommand < Exception
  end
  
  class ServerError < Exception
  end
end
