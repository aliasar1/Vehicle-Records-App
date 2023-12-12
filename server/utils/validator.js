const { ObjectId } = require('mongodb');

function isValidObjectId(id) {
    return ObjectId.isValid(id);
}

function validateNameAndVariant(name, variant) {
    return !name || !variant;
}

module.exports = {
    isValidObjectId,
    validateNameAndVariant,
};
