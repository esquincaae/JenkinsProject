const express = require('express');
const sequelize = require('./config/database');
const authRoutes = require('./routes/auth');
const dotenv = require('dotenv');
dotenv.config();

const app = express();
app.use(express.json());

app.get('/', (req, res) => {
  res.json({
    app: process.env.APP_NAME ?? 'Unknow'
  });
});

app.use('/auth', authRoutes);

// Sincroniza y levanta el servidor
sequelize.sync({ alter: true }) // Puedes usar { force: true } para reiniciar estructura
  .then(() => {
    console.log('Base de datos sincronizada.');
    app.listen(3000, () => {
      console.log('Servidor corriendo en http://localhost:3000');
    });
  })
  .catch(err => {
    console.error('Error al conectar con la base de datos:', err);
  });
