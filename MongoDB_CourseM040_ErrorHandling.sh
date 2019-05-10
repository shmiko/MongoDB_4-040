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

# Windows 10 MongoDB 4.0 Error Handling Setup

# Install Python 3 https://www.python.org/ftp/python/3.7.3/python-3.7.3-amd64.exe
# Add to path for Python dir and scripts dir - then restart cmd windows

# Creates the directories for the servers if not already doone via the first lab.
# get MongoDB URI change the below to include localhost on line 119 - replace m040
    uri = 'mongodb://localhost:27017/m040?replicaSet=M040' 

# Add Error handling code snippets A and B

def handle_commit(s):
    """
    Handles the commit operation.
    """
    # LAB - needs error handling
    while True:
        try:
            s.commit_transaction()
            break
        except (pymongo.errors.OperationFailure, pymongo.errors.ConnectionFailure) as exc:
            if exc.has_error_label("UnknownTransactionCommitResult"):
                print("Commit error: {} retrying commit ... ".format(exc))
                continue
            else:
                raise

def load_data(q, batch, uri):
    """
    Inserts the `batch` of documents into collections.
    """
    mc = pymongo.MongoClient(uri)
    batch_total_population = 0
    batch_docs = 0
    try:
        # LAB - needs error handling
        with mc.start_session() as s:
            while True:
                try:
                    batch_total_population,batch_docs = write_batch(batch, mc, s)
                    break
                except (pymongo.errors.OperationFailure, pymongo.errors.ConnectionFailure) as exc:
                    if exc.has_error_label("TransientTransactionError"):
                        print("Error detected: {} - abort".format(exc))
                        s.abort_transaction()
                        continue
                    else:
                        raise

            q.put({"batch_pop": batch_total_population, "batch_docs": batch_docs})

    except Exception as e:
        print("Unexpected error found: {}".format(e))

# Executes the error handling script. In windows change python3 to just python
	python loader.py