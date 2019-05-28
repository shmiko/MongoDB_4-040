const MongoClient = require("mongodb").MongoClient
const NodeEnvironment = require("jest-environment-node")
module.exports = class MongoEnvironment extends NodeEnvironment {
  async setup() {
    if (!this.global.mflixClient) {
      this.global.mflixClient = await MongoClient.connect(
        // TODO: Connection Pooling
        // Set the poolSize to 50 connections.
        // TODO: Timeouts
        // Set the write timeout limit to 2500 milliseconds.
        process.env.MFLIX_DB_URI, {
          poolSize: 50, ssl: true,
          useNewUrlParser: true ,
          wtimeout : 2500,
        }
      )
      await super.setup()
    }
  }

  async teardown() {
    await this.global.mflixClient.close()
    await super.teardown()
  }

  runScript(script) {
    return super.runScript(script)
  }
}

const baseballPlayers2 = [
  { insertOne: { '_id': 11, 'name': 'Edgar Martinez', 'salary': "8.5M" }},    // Insert #1
  { insertOne: { '_id': 3, 'name': 'Alex Rodriguez', 'salary': "18.3M" }},    // Insert #2
  { insertOne: { '_id': 24, 'name': 'Ken Griffey Jr.', 'salary': "12.4M" }},  // Insert #3
  { insertOne: { '_id': 11, 'name': 'David Bell', 'salary': "2.5M" }},        // Insert #4
  { insertOne: { '_id': 19, 'name': 'Jay Buhner', 'salary': "5.1M" }}         // Insert #5
]

const bulkWriteResponse = db.employees.bulkWrite([
  { insertOne: { '_id': 11, 'name': 'Edgar Martinez', 'salary': "8.5M" }},    
  { insertOne: { '_id': 3, 'name': 'Alex Rodriguez', 'salary': "18.3M" }},    
  { insertOne: { '_id': 24, 'name': 'Ken Griffey Jr.', 'salary': "12.4M" }},  
  { insertOne: { '_id': 11, 'name': 'David Bell', 'salary': "2.5M" }},        
  { insertOne: { '_id': 19, 'name': 'Jay Buhner', 'salary': "5.1M" }}         
])