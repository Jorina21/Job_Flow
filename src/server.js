const { createApp } = require("./app");
const { env } = require("./config/env");
const logger = require("./utils/logger");

const app = createApp();

app.listen(env.PORT, () => {
  logger.info(`JobTrackr API running on port ${env.PORT}`, { env: env.NODE_ENV });
});
