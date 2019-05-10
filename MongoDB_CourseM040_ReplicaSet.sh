#!/bin/bash

# ============================================================================== #
# MIT License                                                                    #
#                                                                                #
# Copyright (c) 2019 Paul Jones                                              #
#                                                                                #
# Permission is hereby granted, free of charge, to any person obtaining a copy   #
# of this software and associated documentation files (the "Software"), to deal  #
# in the Software without restriction, including without limitation the rights   #
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell      #
# copies of the Software, and to permit persons to whom the Software is          #
# furnished to do so, subject to the following conditions:                       #
#                                                                                #
# The above copyright notice and this permission notice shall be included in     #
# all copies or substantial portions of the Software.                            #
#                                                                                #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR     #
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,       #
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE    #
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER         #
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  #
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  #
# SOFTWARE.                                                                      #
# ============================================================================== #
#                                                                                #
# DESCRIPTION : Solution for MongoDB University M040's Lab 0.                    #
# AUTHOR : Paul Jones                                                        #
# COPYRIGHT : Copyright (c) 2019 Paul Jones                                  #
# LICENSE : MIT                                                                  #
#                                                                                #
# ============================================================================== #

# Windows 10 MongoDB 4.0 Replica Set Setup

# 1. Setup the following directories as per Course M040 Folder Structure:
mkdir -p /data/db/m040/repl/{1,2,3}
# Alternatively create them manually
# C:\University\m040\repl\1
# C:\University\m040\repl\2
# C:\University\m040\repl\3

# 2. Run 3 separate CMD to run mongod using the folowing commands:  
mongod --replSet "M040" --dbpath "C:\University\m040\repl\1" --port 27017
mongod --replSet "M040" --dbpath "C:\University\m040\repl\2" --port 27027
mongod --replSet "M040" --dbpath "C:\University\m040\repl\3" --port 27037

# 3. Run a single mongo instance, then run the following commands:
mongo 	rs.initiate()
		rs.conf()
	 	rs.add("localhost:27027")
	 	rs.add("localhost:27037")
	 	rs.conf()

# 4. Run the validate script
C:\University\m040\environment_setup>mongo --quiet validate_lab1.js
# Success:
# Great Job! Your validation code is:
# 1602589782

# Errors are likley to be:
# Incorrect number of replica set members - Due to not running rs.add using localhost
# Unable to get replica set config - Can be due to running commands with mongo eval

