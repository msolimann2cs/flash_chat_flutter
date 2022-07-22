const functions = require("firebase-functions");
const express = require("express");
const Agora = require("agora-access-token");

const app = express();
app.use(express.json());

app.get("/", (req, res) => res.send("Agora Auth Token Server"));

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Agora Auth Token Server listening at Port ${port}`));

app.post("/rtctoken", (req, res) => {
    // Generate Token Here
    const appID = "be503467d4a24a64a19be028749340d0";
    const appCertificate = "87f28bece77240929dacb9bc16fa4e44";
    const uid = Math.floor(Math.random() * 100000);
    const expirationTimeInSeconds = 3600;
    const currentTimestamp = Math.floor(Date.now() / 1000);
    const privilegeExpiredTs = currentTimestamp + expirationTimeInSeconds;
    const role = req.body.isPublisher ? Agora.RtcRole.PUBLISHER : Agora.RtcRole.SUBSCRIBER;
    const channel = req.body.channel;
    const token = Agora.RtcTokenBuilder.buildTokenWithUid(appID, appCertificate, channel, uid, role, privilegeExpiredTs);
    res.send({ uid, token });
  });

  app.get("/rtctoken", function(req, res) {
    // Generate Token Here
    const appID = "be503467d4a24a64a19be028749340d0";
    const appCertificate = "87f28bece77240929dacb9bc16fa4e44";
    const uid = Math.floor(Math.random() * 100000);
    //const uid = req.query.uid;
    const expirationTimeInSeconds = 3600;
    const currentTimestamp = Math.floor(Date.now() / 1000);
    const privilegeExpiredTs = currentTimestamp + expirationTimeInSeconds;
    const role = req.query.isPublisher ? Agora.RtcRole.PUBLISHER : Agora.RtcRole.SUBSCRIBER;
    const channel = req.query.channel;
    const token = Agora.RtcTokenBuilder.buildTokenWithUid(appID, appCertificate, channel, uid, role, privilegeExpiredTs);
    res.send({ uid, token });
  });

// app.listen(port);
// console.log('Server started at http://localhost:' + port);
