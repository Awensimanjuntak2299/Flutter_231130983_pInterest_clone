const User = require('../models/User');
const bcrypt = require('bcrypt');

// Ambil semua user (opsional, bisa untuk admin)
exports.getAllUsers = async (req, res) => {
  try {
    const users = await User.find();
    res.json(users);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

// Buat user baru (register)
exports.registerUser = async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password)
    return res.status(400).json({ message: 'Username dan password wajib diisi' });

  try {
    const existing = await User.findOne({ username });
    if (existing) {
      return res.status(400).json({ message: 'Username sudah digunakan' });
    }

    const newUser = new User({ username, password });
    const savedUser = await newUser.save();
    res.status(201).json(savedUser);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
};

// Login user
exports.loginUser = async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password)
    return res.status(400).json({ message: 'Username dan password wajib diisi' });

  try {
    const user = await User.findOne({ username });
    if (!user) return res.status(404).json({ message: 'User tidak ditemukan' });

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(401).json({ message: 'Password salah' });

    res.status(200).json({ message: 'Login berhasil', user });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};
