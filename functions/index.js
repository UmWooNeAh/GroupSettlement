const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();
// const db = admin.firestore();

exports.sendNotification = functions.region("asia-northeast3").firestore
.document("userlist/{docId}").onUpdate(async (change, context) => {

    const prev = change.before.data().name;
    const now = change.after.data().name;

    if (prev != now) {
        try {
            const message = {
                notification: {
                    title: "회원 이름 변경 알림",
                    body: "한 회원님의 이름이 변경되었어요! 지금 확인해보세요.",
                  },
                  token: "edfTkZmPQ3eJ40REenNe9J:APA91bG21F2LhGAwIy0j1dBlfdREdu46uRYEQ6-7rxEdNLJ9VLbQIv4cumLX8Ng9OrY40l_h3GPbwSreAHfefhY23mF9KgmxqazKFoM6kK3Sr9zfOsEcjUhA1KYnYeCCsJ6bsm0gsnHO",
            };
            admin.messaging().send(message).then((response) => {
                  console.log("Successfully sent message:", response);
                })
                .catch((error) => {
                  console.log("Error sending message:", error);
                });
        }
        catch (err) {
                console.error(err);
        }
    }
  });
