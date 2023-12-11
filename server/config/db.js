const { MongoClient } = require('mongodb');

const mongoUrl = 'mongodb://127.0.0.1';
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