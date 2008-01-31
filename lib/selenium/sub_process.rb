module Selenium
  class SubProcess
    def initialize command
      @command = command
    end
    
    def start
      # puts "Starting: #{command}"
      @pid = fork do
        # Since we can't use shell redirects without screwing up the pid, we'll reopen stdin and stdout instead to get the same effect.
        [STDOUT,STDERR].each {|f| f.reopen '/dev/null', 'w' }
        exec @command
      end
    end

    def stop
      # puts "Stopping: #{@command} (pid=#{@pid})"
      Process.kill 15, @pid
    # rescue Errno::EPERM #such as the process is already closed (tabbed browser)
    end
        
    def self.start(*args)
      process = new(*args)
      process.start
      process
    end
  end
end