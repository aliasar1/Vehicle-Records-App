const { getDatabase } = require('../config/db');
const { ObjectId } = require('mongodb');
const { isValidObjectId, validateNameAndVariant } = require('../utils/validator');

const collectionName = "vehicles";

const addVehicle = async (req, res) => {
    const { name, variant } = req.body;
    if (validateNameAndVariant(name, variant)) {
        res.status(400).json({ message: "All fields are mandatory" });
        return;
    }
    const result = await getDatabase().collection(collectionName).insertOne({ name, variant });
    res.status(200).json(result);
};

const getAllVehicles = async (req, res) => {
    const vehicles = await getDatabase().collection(collectionName).find({}).toArray();
    res.status(200).json(vehicles);
};

const getVehicle = async (req, res) => {
    const id = req.params.id;
    if (!isValidObjectId(id)) {
        res.status(400).json({ message: "Invalid Vehicle ID" });
        return;
    }
    const vehicle = await getDatabase().collection(collectionName).findOne({ _id: new ObjectId(req.params.id) });
    if (!vehicle) {
        res.status(404).json({ message: "Vehicle not found with the given ID." });
        return;
    }
    res.status(200).json(vehicle);
};

const updateVehicle = async (req, res) => {
    const { name, variant } = req.body;
    if (validateNameAndVariant(name, variant)) {
        res.status(400).json({ message: "All fields are mandatory." });
        return;
    }
    const id = req.params.id;
    if (!isValidObjectId(id)) {
        res.status(400).json({ message: "Invalid Vehicle ID" });
        return;
    }
    const vehicle = await getDatabase().collection(collectionName).findOne({ _id: new ObjectId(req.params.id) });
    if (!vehicle) {
        res.status(404).json({ message: "Vehicle not found with the given ID." });
        return;
    }
    const result = await getDatabase().collection(collectionName).updateOne(
        { _id: new ObjectId(req.params.id) },
        { $set: { name, variant } }
    );
    res.status(200).json(result);
};

const deleteVehicle = async (req, res) => {
    const id = req.params.id;
    if (!isValidObjectId(id)) {
        res.status(400).json({ message: "Invalid Vehicle ID" });
        return;
    }
    const vehicle = await getDatabase().collection(collectionName).findOne({ _id: new ObjectId(req.params.id) });
    if (!vehicle) {
        res.status(404).json({ message: "Vehicle not found with the given ID." });
        return;
    }
    const result = await getDatabase().collection(collectionName).deleteOne({ _id: new ObjectId(req.params.id) });
    res.status(200).json(result);
};

module.exports = {
    addVehicle,
    getAllVehicles,
    getVehicle,
    updateVehicle,
    deleteVehicle,
};
