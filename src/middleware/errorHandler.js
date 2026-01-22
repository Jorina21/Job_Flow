const { AppError } = require("../utils/errors"); //message, statuscode, code, details 
const logger = require("../utils/logger"); //access to info, warn, error

function errorHandler(err, req, res, next) {
  const isAppError = err instanceof AppError; //has access to all properties

  const status = isAppError ? err.statusCode : 500;// is status a err.status a known error? yes = statuscode No = 500 aka internal server error.
  const code = isAppError ? err.code : "INTERNAL_ERROR";
  const message = isAppError ? err.message : "Internal server error";

  if (!isAppError) {
    logger.error("Unhandled error", { message: err.message, stack: err.stack });
  }

  res.status(status).json({
    error: {
      code,
      message,
      ...(isAppError && err.details ? { details: err.details } : {}) //if an apperror & has details and it to key detaisl else leve it {empty}
    }
  });
}

module.exports = { errorHandler }; 

//handles the dirty work of communcating with the user instead of writting try catch blocks in each file. 
