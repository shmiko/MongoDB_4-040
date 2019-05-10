Windows 10 MongoDB 4.0 Replica Set Setup

1. Setup the following directories as per Course M040:
C:\University\m040\repl\1
C:\University\m040\repl\2
C:\University\m040\repl\3

2. Run 3 separate CMD to run mongod using the folowing commands:  
mongod --replSet "M040" --dbpath "C:\University\m040\repl\1" --port 27017
mongod --replSet "M040" --dbpath "C:\University\m040\repl\2" --port 27027
mongod --replSet "M040" --dbpath "C:\University\m040\repl\3" --port 27037

3. Run a single mongo instance, then run the following commands:
mongo 	rs.initiate()
		rs.conf()
	 	rs.add("localhost:27027")
	 	rs.add("localhost:27037")
	 	rs.conf()

4. Run the validate script
C:\University\m040\environment_setup>mongo --quiet validate_lab1.js
Great Job! Your validation code is:
1602589782

Errors are likley to be:
Incorrect number of replica set members - Due to not running rs.add using localhost
Unable to get replica set config - Can be due to running commands with mongo eval