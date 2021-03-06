require 'socket'
require 'byebug'
require 'timeout'
class Server

  def initialize(port,ip)
    @server= TCPServer.open("localhost",2345)
    run
  end


  def parse_path(path,method,client,payload)
    @status,c,@connId,t,@timeout = path.split(/\W+/).drop(1)
    response(@status,@connId,@timeout,method,client,payload)
  end



  def time_out(t,client)
    puts t.status
    begin
     Timeout.timeout(t[:time].to_i) do
       #.gets
       @server.accept.gets


     end

   rescue Timeout::Error

             puts "ok"#{status:"ok"}
             t.kill
           end
           t
         end





         def response(status,connId,time,method,client,payload)

          if status.downcase.eql?("request") && method.downcase.eql?("get")
            @clients << create_client(time,connId)
            @clients.each do |t|

             if t[:time] && t[:time]>0

               @clients.delete(time_out(t,client))
             end


           end

         elsif status.downcase.eql?("serverstatus") && method.downcase.eql?("get")
          @clients.each do |t|
           t.status
           if t && (r_time = t[:created_at]-Time.now+t[:time])>0
            puts t[:connId]
            puts r_time
          end
        end

      elsif status.downcase.eql?("kill") && method.downcase.eql?("put")
       conn,id = payload.split(":")
       if !@clients.nil?
        @clients.each do |t|
          if t[:connId] == id
            puts "killed"
            t.kill
          end
        end
      else
       puts "invalidConnectionId"
     end
   end
 end




 def create_client(time,connId)
  Thread.new {
   Thread.current[:connId]=connId
   Thread.current[:time]=time.to_i
   Thread.current[:created_at] = Time.now
 }
end

def run

 @clients=[]
 loop do
  @socket =@server.accept
  request = @socket.gets
  client=""
  method, path, payload = request.split(' ')
  puts method
  #puts path
 # puts payload

  parse_path(path,method,client,payload)
end
end


end
Server.new(2345,"localhost")
