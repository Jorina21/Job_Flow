const rateLimit = require("express-rate-limit");

const authLimiter = rateLimit({
  windowMs: 10 * 60 * 1000, // 10 minutes, 60 seconds, 1000 milliseconds 
  limit: 20,  //20 requests withing that 10 minute window. 
  standardHeaders: true,
  legacyHeaders: false,
  message: {
    error: { code: "RATE_LIMITED", message: "Too many requests, try again later." }
  }
});

module.exports = { authLimiter };
