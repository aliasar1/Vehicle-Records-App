const { MongoClient } = require('mongodb');

const mongoUrl = 'mongodb://localhost:27017';
const dbName = 'VehicleCRUD';

let db;

const connectToDatabase = async () => {
  const client = await MongoClient.connect(mongoUrl);
  db = client.db(dbName);
  console.log('Connected to MongoDB');
};

const getDatabase = () => {
  if (!db) {
    throw new Error('Database not connected...');
  }
  return db;
};

module.exports = {
  connectToDatabase,
  getDatabase,
};