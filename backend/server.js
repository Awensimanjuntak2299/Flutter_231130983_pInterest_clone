const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

// Import routes
const postRoutes = require('./routes/posts');
const userRoutes = require('./routes/auth');

const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/posts', (req, res, next) => {
  console.log(`[API] ${req.method} ${req.originalUrl}`);
  next();
}, postRoutes);

app.use('/api/users', (req, res, next) => {
  console.log(`[API] ${req.method} ${req.originalUrl}`);
  next();
}, userRoutes);

// MongoDB Connection
mongoose.connect('mongodb://127.0.0.1:27017/pinterest_clone', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
}).then(() => {
  console.log('✅ MongoDB Connected');
  app.listen(PORT, () => console.log(`🚀 Server running at http://localhost:${PORT}`));
}).catch(err => {
  console.error('❌ MongoDB connection error:', err);
});
