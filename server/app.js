const express = require('express');
const cors = require('cors');
const { connectToDatabase } = require('./config/db');
const vehcileRoutes = require('./routes/vehiclesRoutes');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

connectToDatabase();

app.use('/vehcile', vehcileRoutes);

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
