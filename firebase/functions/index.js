const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(functions.config().firebase);

exports.createHelloKishanUser = functions.auth.user().onCreate((user) => {
  var helloKishanUser = JSON.parse(JSON.stringify(user));
  return admin
    .firestore()
    .collection("users")
    .doc(user.uid)
    .set(helloKishanUser);
});

exports.deleteHelloKishanUser = functions.auth.user().onDelete((user) => {
  return admin.firestore().collection("users").doc(user.uid).delete();
});

exports.transactionAdded = functions.firestore
  .document("/transaction/{transaction}")
  .onCreate((snapshot, context) => {
    var tokens = [];
    /*  admin
      .firestore()
      .collection("token")
      .get()
      .then((snapshot) => {
        if (snapshot.empty) {
          console.log("Error getting tokens");
        } else {
          for (var token of snapshot.docs) {
            tokens.push(token.data().token); // TODO: Pushing empty string 
          }
        }
        return null; // TODO 2
      })
      .catch((error) => {
        console.log("Error getting tokens");
      }); */
    console.log("Pushing token...");
    tokens.push(
      "ccQ5FYJnvnY:APA91bFgrRSeZIPrul9z-bXh-6ACmN2PDc_SgkSPBBRQTrSFNotd9c7xUvW04LfR4IsQj7leFzkrC4xKsWeZaSE3cF4OzOXWQaandQdehDN3Gcdna0QGUYoCCgmifi_ggfdAIi3uE-O-"
    );

    var payload = {
      notification: {
        title: "Transaction added",
        body: "New transaction added [TODO]",
        sound: "default",
      },
      data: {
        sendername: "Swarupananda Dhua",
        message: "New transaction added [TODO]",
      },
    };
    console.log(tokens);
    return admin
      .messaging()
      .sendToDevice(tokens, payload)
      .then((response) => {
        console.log("Pushed notification...\nResponse:::");
        console.log(response);
        return null; // TODO 2
      })
      .catch((error) => {
        console.log("Error pushing notification");
      });
  });
