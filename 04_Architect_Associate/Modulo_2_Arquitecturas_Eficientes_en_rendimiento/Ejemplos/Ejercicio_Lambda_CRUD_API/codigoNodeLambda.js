
const AWS = require("aws-sdk");

const dynamo = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event, context) => {
  let body;
  let statusCode = 200;
  const headers = {
    "Content-Type": "application/json"
  };

  try {
    switch (event.routeKey) {
      case "DELETE /items/{id}":
        await dynamo
          .delete({
            TableName: "lambda-crud-api",
            Key: {
              id: event.pathParameters.id
            }
          })
          .promise();
        body = "Item borrado ${event.pathParameters.id}";
        break;
      case "GET /items/{id}":
        body = await dynamo
          .get({
            TableName: "lambda-crud-api",
            Key: {
              id: event.pathParameters.id
            }
          })
          .promise();
        break;
      case "GET /items":
        body = await dynamo.scan({ TableName: "lambda-crud-api" }).promise();
        break;
      case "PUT /items":
        let requestJSON = JSON.parse(event.body);
        await dynamo
          .put({
            TableName: "lambda-crud-api",
            Item: {
              id: requestJSON.id,
              price: requestJSON.price,
              name: requestJSON.name
            }
          })
          .promise();
        body = "Item creado ${requestJSON.id}";
        break;
      default:
        throw new Error('Ruta incorrecta: "${event.routeKey}"');
    }
  } catch (err) {
    statusCode = 400;
    body = err.message;
  } finally {
    body = JSON.stringify(body);
  }

  return {
    statusCode,
    body,
    headers
  };
};

