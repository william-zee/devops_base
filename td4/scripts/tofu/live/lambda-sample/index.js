exports.handler = async (event) => {
    return {
        statusCode: 200,
        body: JSON.stringify({ status: "ok", message: "Hello from JSON" }),
    };
};
