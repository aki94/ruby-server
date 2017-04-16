Instruction for running file

api request format

1. curl --verbose -Xget 'http://localhost:2345/request?connId=10&timeout=2'
2.  curl --verbose -Xget http://localhost:2345/serverStatus
3. curl --verbose -Xput 'http://localhost:2345/kill-d {connId:10}'

to change localhost:2345 to 'api' please map localhost to api in etc/host (for linux)

to run server file
1.install ruby
2.cd into the folder where file is located and then run ruby server.rb
3. then use curl to generate request as mention above.
4.use multiple request for better result.

