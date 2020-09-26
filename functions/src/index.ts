import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();


// export const sendToDevice = functions.firestore
//   .document('orders/{orderId}')
//   .onCreate(async snapshot => {


//     const order = snapshot.data();

//     const querySnapshot = await db
//       .collection('users')
//       .doc(order.seller)
//       .collection('tokens')
//       .get();

//     const tokens = querySnapshot.docs.map(snap => snap.id);

//     const payload: admin.messaging.MessagingPayload = {
//       notification: {
//         title:  `${order.product}`,
//         //body: `you sold a ${order.product} for ${order.total}`,
//         body: `${order.total}`,
//         icon: 'your-icon-url',
//         click_action: 'FLUTTER_NOTIFICATION_CLICK'
//       }
//     };

//     return fcm.sendToDevice(tokens, payload);
//   });



export const sendToDevice = functions.firestore
  .document('contacts/{contactsId}/message/{messageId}/chats/{chatId}')
  .onCreate(async snapshot => {


    const order = snapshot.data();

    const querySnapshot = await db
      .collection('contacts')
      .doc(String(order.reciver))
      .collection('tokens')                       
      .get();
     console.log(String(order.sender));
    const tokens = querySnapshot.docs.map(snap => snap.id);

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title:  `${order.sender}`,
        //body: `you sold a ${order.product} for ${order.total}`,
        body: `${order.message}`,
        icon: 'your-icon-url',
        click_action: 'FLUTTER_NOTIFICATION_CLICK',
        sound: 'default',
         
      }
    };

    return fcm.sendToDevice(tokens, payload);
  });