require 'singleton'
    class MyLogger
    include Singleton
    def initialize
        @log = File.open("log.txt", "a")
    end
    def logInformation(information)
        @log.puts(information)
        @log.flush
    end
end