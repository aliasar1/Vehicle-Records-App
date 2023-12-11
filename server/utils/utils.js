const generateObjectId = () => {
    return new require('mongodb').ObjectID();
};

module.exports = {
    generateObjectId,
};