const express = require('express');
const cors = require('cors');
const { connectToDatabase } = require('./config/db');
const vehicleRoutes = require('./routes/vehiclesRoutes');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

connectToDatabase();

app.use('/vehicle', vehicleRoutes);

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
