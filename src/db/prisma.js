const { PrismaClient } = require("@prisma/client");
const { env } = require("../config/env");

let prisma;

// In tests we want a fresh client per process and a separate DB.
function getDatabaseUrl() {
  if (env.NODE_ENV === "test") {
    return env.DATABASE_URL_TEST || env.DATABASE_URL;
  }
  return env.DATABASE_URL;
}

if (!getDatabaseUrl()) {
  throw new Error(
    "DATABASE_URL is not set. Provide DATABASE_URL (and DATABASE_URL_TEST for tests)."
  );
}

// Pass datasource override so test DB is used even if DATABASE_URL exists.
prisma = new PrismaClient({
  datasources: { db: { url: getDatabaseUrl() } } //reads from DATABASE_URL defualt but use function incase of tests. 
});

module.exports = { prisma }; //export prisma so that It can be used in other files. 
