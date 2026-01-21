function log(level, message, meta) {
  const payload = meta ? ` ${JSON.stringify(meta)}` : "";
  // Keep simple; production deploy platforms capture stdout
  console.log(`[${new Date().toISOString()}] [${level}] ${message}${payload}`);
}

module.exports = {
  info: (msg, meta) => log("INFO", msg, meta),
  warn: (msg, meta) => log("WARN", msg, meta),
  error: (msg, meta) => log("ERROR", msg, meta)
};
