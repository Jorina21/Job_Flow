const { AppError } = require("../utils/errors");

function validate(schema) {
  return (req, res, next) => {
    const parsed = schema.safeParse({
      body: req.body,
      query: req.query,
      params: req.params
    });

    if (!parsed.success) {
      return next(
        new AppError("Validation failed", 400, "VALIDATION_ERROR", parsed.error.flatten())
      );
    }

    // replace with sanitized values
    req.validated = parsed.data;
    next();
  };
}

module.exports = { validate };
