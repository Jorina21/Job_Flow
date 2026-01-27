const express = require("express");
const helmet = require("helmet");
const cors = require("cors");
const morgan = require("morgan");

const { env } = require("./config/env");
const { errorHandler } = require("./middleware/errorHandler");
const { notFound } = require("./middleware/notFound");

function createApp() {
  const app = express();

  // Security + platform middleware
  app.use(helmet());
  app.use(
    cors({
      origin: env.CORS_ORIGIN === "*" ? true : env.CORS_ORIGIN,
      credentials: true
    })
  );

  // Body parsing
  app.use(express.json({ limit: "1mb" }));

  // Request logging
  app.use(morgan(env.NODE_ENV === "production" ? "combined" : "dev"));

  // Health
  app.get("/health", (req, res) => res.json({ ok: true }));

  // (Routes will get mounted later: /auth, /applications, /activity, /dashboard)

  // 404 + error handler MUST be last
  app.use(notFound);
  app.use(errorHandler);

  return app;
}

module.exports = { createApp };
