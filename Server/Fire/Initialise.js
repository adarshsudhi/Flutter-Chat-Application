var admin = require("firebase-admin");

var serviceAccount = require("./serviceAccountKey.json");

const init  = async()=>{
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://practicechat-fe8e4-default-rtdb.firebaseio.com"
  });
}
/*const firebaseConfig = {
    apiKey: "AIzaSyBYwBvYLyt6XT4Xrpj6R4J6509HbNRlkYo",
    authDomain: "practicechat-fe8e4.firebaseapp.com",
    databaseURL: "https://practicechat-fe8e4-default-rtdb.firebaseio.com",
    projectId: "practicechat-fe8e4",
    storageBucket: "practicechat-fe8e4.appspot.com",
    messagingSenderId: "873938956800",
    appId: "1:873938956800:web:998ae17a73464292ec9ee5"
  };*/
  module.exports = {
    init,
    admin
  };





