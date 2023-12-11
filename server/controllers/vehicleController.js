const { getDatabase } = require('../config/db');
const { generateObjectId } = require('../utils/utils');

const collectionName = "vehicles";

const addVehicle = async (req, res) => {
    const { name, variant } = req.body;
    if(!name || !variant){
        res.status(400);
        throw new Error("All fields are mandatory.");
    }
    const result = await getDatabase().collection(collectionName).insertOne({name, variant});
    res.status(200).json(result);
};

const getAllVehicles = async (req, res) => {
  return await getDatabase().collection(collectionName).find({}).toArray();
};

const getVehicle = async (req, res) => {
  return await getDatabase().collection(collectionName).findOne({ _id: generateObjectId(id) });
};

const updateVehicle = async (req, res) => {
    const {name, description} = req.body;
    if(!name || !description){
        res.status(400);
        throw new Error("All fields are mandatory.");
    }
  const result = await getDatabase().collection(collectionName).updateOne(
    { _id: generateObjectId(id) },
    { $set: data }
  );
  return result.modifiedCount > 0;
};

const deleteVehicle = async (req, res) => {
  const result = await getDatabase().collection(collectionName).deleteOne({ _id: generateObjectId(id) });
  return result.deletedCount > 0;
};

module.exports = {
    addVehicle,
    getAllVehicles,
    getVehicle,
    updateVehicle,
    deleteVehicle,
};