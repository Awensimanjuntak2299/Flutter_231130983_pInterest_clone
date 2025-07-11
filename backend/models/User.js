const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
    unique: true, // username harus unik
  },
  password: {
    type: String,
    required: true,
  },
}, {
  timestamps: true,
  toJSON: {
    virtuals: true,
    versionKey: false,
    transform: function (doc, ret) {
      ret.id = ret._id;
      delete ret._id;
      delete ret.password; // jaga-jaga supaya password tidak dikirim
    }
  }
});

module.exports = mongoose.model('User', userSchema);
