const {RtcTokenBuilder, RtmTokenBuilder, RtcRole, RtmRole} = require('agora-token');
const express = require('express')
const router = express.Router();
const app = express();
const {init,admin} = require('./Fire/Initialise');

init();

const db = admin.firestore();

app.use(express.json());
app.use('/',router);
 
const PORT = 3000;
const APPID = 'd6e2285f6e0340839e18c4fecf3ddc46';
const APPCERTIFICATE = '862e6112230640808517e94ea45a9406';

const Setuseronline = async(req,res)=>{
   let uid = req.params.uid; 
   if(!uid){
      return res.status(404).json({'error':'the user uid is not specified'})
   }else{

      let Homeusers = await db.collection('users').doc(uid).collection('Homeusers').get();
      await db.collection('users').doc(uid).update({'online':true});
      if (Homeusers.docs.length != 0) {
         for (let i = 0; i < Homeusers.docs.length; i++) {
            let Searchuser = await db.collection('users').doc(Homeusers.docs[i].data()
            .frienduid).collection('Homeusers').where('frienduid','==',Homeusers.docs[i].data().currentuseruid).get();
             Searchuser.docs.forEach((element)=>{
                element.ref.update({
                   'online':true
                })
             })
            
          }
   }
   return res.status(200).json({'msg':'Updated succesfully'})

} 
}
 
const setoffline =async (req,res) =>{
  let uid = req.params.uid;
   if (!uid) {
    return res.status(404).json({'error':'user uid is not specified'})
   }else{
   await db.collection('users').doc(uid).update({'online':false});
   let Homeusers = await db.collection('users').doc(uid).collection('Homeusers').get();
   if (Homeusers.docs.length != 0) {
      for (let i = 0; i < Homeusers.docs.length; i++) {
         let Searchuser = await db.collection('users').doc(Homeusers.docs[i].data()
         .frienduid).collection('Homeusers').where('frienduid','==',Homeusers.docs[i].data().currentuseruid).get();
            Searchuser.docs.forEach((element)=>{
               element.ref.update({
                  'online':false
            })
         })
       }
   }
   return res.status(200).json({'msg':'user set to offlineS'}) 
  }
}


const GenerateTokenWithuid = (req,res)=>{
    let channelName = req.params.channelName;
    if (!channelName) {
         return res.status(404).json({'error':'Channelname is empty or Somthings went wrong'})
    }

    let role;
     if (req.params.role === 'audience') {
        role = RtcRole.SUBSCRIBER;
     }else if(req.params.role === 'publisher'){
         role = RtcRole.PUBLISHER;
     }else{
        return res.status(400).json({'error':'role is empty'})
     }

     let uid;
     if (!req.params.uid) {
        return res.status(404).json({'error':'uid is empty'})
     }else{
        uid = req.params.uid;
     }

     const expireTime = 3600;
     const currentTime = Math.floor(Date.now() / 1000);
     const privilegeExpireTime = currentTime + expireTime;

     let token;

     if (req.params.tokenType === "userAccount") {
         token = RtcTokenBuilder.buildTokenWithUserAccount(APPID,APPCERTIFICATE,channelName,uid,role,privilegeExpireTime)
     }else if(req.params.tokenType === 'uid'){
        token = RtcTokenBuilder.buildTokenWithUid(APPID,APPCERTIFICATE,channelName,uid,role,privilegeExpireTime)
     }else{
        return res.status(404).json({'error':'tokentype is empty'})
     }

     console.log(role)
     console.log(uid)
     console.log(channelName)

     return res.status(200).json({"rtcToken":token})
}

app.listen(PORT,"0.0.0.0",(()=>{
  return console.log(`Connected and listening to port ${PORT}`);
}))



router.route('/generate/rtc/:channelName/:role/:tokenType/:uid').get(GenerateTokenWithuid)
router.route('/offline/:uid').put(setoffline)
router.route('/online/:uid').put(Setuseronline)
//app.get('/generate/rtc/:channelName/:role/:tokenType/:uid',GenerateTokenWithuid);