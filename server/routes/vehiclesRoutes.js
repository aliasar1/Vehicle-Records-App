const express = require('express');
const controllers = require('../controllers/vehicleController');

const router = express.Router();

router.post('/', controllers.addVehicle);
router.get('/', controllers.getAllVehicles);
router.get('/:id', controllers.getVehicle);
router.put('/:id', controllers.updateVehicle);
router.delete('/:id', controllers.deleteVehicle);

module.exports = router;
