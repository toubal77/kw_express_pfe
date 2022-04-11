import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const db = admin.firestore();

export const orderSend = functions.firestore.document("orders").onUpdate(async (snapshot, context) => {
  const userId = context.params.userId;

  const querySnapshot = await db.collection("orders").get();
  querySnapshot.forEach(async (orderDoc) => {
    console.log(orderDoc.data().createdBy);
    console.log(orderDoc.data().idResto);
    console.log(userId);
  });
});
