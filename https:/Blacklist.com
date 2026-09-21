<!DOCTYPE html>
<html lang="de">
<head>
<meta charset="UTF-8">
<meta name="viewport"
      content="width=device-width,
               initial-scale=1,
               maximum-scale=1,
               user-scalable=no,
               viewport-fit=cover">

<title>BLACKLIST OPERATIV V25.6.45 – 200 LEVEL + BEGLEITER</title>

<style>
*{
  box-sizing:border-box;
  -webkit-tap-highlight-color:transparent;
  touch-action:none;
}

html,body{
  margin:0;
  width:100%;
  height:100%;
  overflow:hidden;
  background:#05080b;
  color:#fff;
  font-family:Arial,Helvetica,sans-serif;
  user-select:none;
  -webkit-user-select:none;
}

canvas{
  position:fixed;
  inset:0;
  width:100vw;
  height:100vh;
  display:block;
}

/* =========================
   START MENU
========================= */

#menu{
  position:fixed;
  inset:0;
  z-index:50;
  display:flex;
  align-items:center;
  justify-content:center;

  background:
    radial-gradient(
      circle at 50% 35%,
      rgba(65,80,90,.35),
      transparent 40%
    ),
    linear-gradient(
      135deg,
      #050709,
      #12181c 55%,
      #070a0d
    );
}

.panel{touch-action:pan-y;
  width:min(820px,92vw);
  padding:35px;
  background:rgba(8,12,15,.95);
  border:1px solid #3d4a51;
  box-shadow:0 25px 80px #000;
  border-radius:8px;
}

.logo{
  font-size:clamp(30px,6vw,55px);
  font-weight:900;
  letter-spacing:7px;
}

.logo span{
  color:#d52b31;
}

.sub{
  margin-top:8px;
  color:#829097;
  letter-spacing:3px;
  font-size:12px;
}

.description{
  color:#aeb9be;
  line-height:1.6;
  margin:25px 0;
}

button{
  border:1px solid #59666c;
  background:#202a2f;
  color:#fff;
  padding:14px 20px;
  border-radius:5px;
  font-weight:bold;
  letter-spacing:1px;
}

#start{
  background:#8e2025;
  border-color:#c94b50;
}

#start:active{
  transform:scale(.97);
}

.mobileInfo{
  margin-top:20px;
  padding:14px;
  border:1px solid #263238;
  background:#0b1013;
  color:#849198;
  font-size:12px;
  line-height:1.5;
}

/* =========================
   HUD
========================= */

#hud{
  position:fixed;
  top:env(safe-area-inset-top,10px);
  left:0;
  right:0;
  z-index:10;
  padding:8px;
  pointer-events:none;
  display:none;
}

.hud{
  display:flex;
  gap:6px;
}

.box{
  background:rgba(5,9,11,.78);
  border:1px solid rgba(160,180,190,.24);
  padding:6px 9px;
  min-width:75px;
  box-shadow:0 3px 14px #0008;
}

.box.big{
  flex:1;
}

.label{
  color:#829096;
  font-size:7px;
  letter-spacing:1.5px;
}

.value{
  margin-top:3px;
  font-size:12px;
  font-weight:bold;
}

/* =========================
   MOBILE CONTROLS
========================= */

#mobileControls{
  position:fixed;
  inset:0;
  z-index:20;
  display:none;
  pointer-events:none;
}

.stickArea{
  position:absolute;
  width:145px;
  height:145px;
  border-radius:50%;
  pointer-events:auto;
}

#moveArea{
  left:
    calc(18px + env(safe-area-inset-left));
  bottom:
    calc(18px + env(safe-area-inset-bottom));
}

#aimArea{
  right:
    calc(18px + env(safe-area-inset-right));
  top:50%;
  transform:translateY(-50%);
  z-index:22;
}

.aimLabel{
  position:absolute;
  left:50%;
  top:-20px;
  transform:translateX(-50%);
  color:rgba(220,230,232,.62);
  font-size:9px;
  font-weight:800;
  letter-spacing:2px;
  text-shadow:0 2px 5px #000;
  pointer-events:none;
}

.stickBase{
  position:absolute;
  left:0;
  top:0;
  width:145px;
  height:145px;
  border-radius:50%;

  background:
    radial-gradient(
      circle,
      rgba(100,120,125,.16),
      rgba(20,25,28,.35)
    );

  border:2px solid rgba(180,195,200,.2);
}

.stick{
  position:absolute;
  width:62px;
  height:62px;
  left:41px;
  top:41px;
  border-radius:50%;

  background:
    radial-gradient(
      circle at 35% 30%,
      rgba(210,220,220,.4),
      rgba(70,80,82,.7)
    );

  border:2px solid rgba(220,230,230,.3);
  box-shadow:0 5px 15px #0008;
}

.controlButton{
  position:absolute;
  width:72px;
  height:72px;
  border-radius:50%;
  pointer-events:auto;

  display:flex;
  align-items:center;
  justify-content:center;

  font-size:11px;
  font-weight:bold;
  text-align:center;

  background:rgba(10,15,17,.78);
  border:2px solid rgba(210,220,220,.35);
  box-shadow:0 5px 18px #0009;
}

.controlButton:active{
  transform:scale(.91);
}

#actionControls{
  position:absolute;
  right:
    calc(18px + env(safe-area-inset-right));
  bottom:
    calc(18px + env(safe-area-inset-bottom));
  z-index:23;
  display:flex;
  flex-direction:column;
  align-items:flex-end;
  gap:8px;
  pointer-events:none;
}

#actionRow{
  display:flex;
  align-items:center;
  gap:10px;
}

#fireButton{
  position:relative;
  right:auto;
  bottom:auto;
  width:92px;
  height:92px;
  border-color:#d94c51;
  background:rgba(120,20,25,.72);
  font-size:14px;
}

#reloadButton{
  position:relative;
  right:auto;
  bottom:auto;
  width:78px;
  height:78px;
  border-radius:50%;
  color:#e4d47a;
  border-color:#8d8244;
}

#pauseButton{
  position:absolute;
  right:12px;
  top:95px;

  width:45px;
  height:45px;
  border-radius:50%;

  pointer-events:auto;

  background:#070b0dcc;
  border:1px solid #647078;
  color:#fff;
}

/* =========================
   CROSSHAIR
========================= */

#crosshair{
  position:fixed;
  z-index:15;
  width:30px;
  height:30px;
  margin-left:-15px;
  margin-top:-15px;
  pointer-events:none;
  display:none;
}

#crosshair::before,
#crosshair::after{
  content:"";
  position:absolute;
  background:#d9e3e5;
}

#crosshair::before{
  width:30px;
  height:2px;
  left:0;
  top:14px;
}

#crosshair::after{
  width:2px;
  height:30px;
  left:14px;
  top:0;
}

.crossCircle{
  position:absolute;
  inset:7px;
  border:1px solid #d9e3e5;
  border-radius:50%;
}

/* =========================
   CAMOUFLAGE
========================= */

#camoFill{
  width:100%;
  height:100%;
  background:#55c77e;
}

/* =========================
   ALERT
========================= */

#alert{
  position:fixed;
  z-index:30;

  left:50%;
  top:115px;

  transform:translateX(-50%);

  font-weight:bold;
  letter-spacing:3px;
  font-size:14px;

  display:none;

  text-shadow:0 2px 7px #000;
}

/* =========================
   PAUSE
========================= */

#pause{
  position:fixed;
  inset:0;
  z-index:60;

  display:none;
  align-items:center;
  justify-content:center;

  background:#000c;
}

#pause .panel{
  width:min(450px,90vw);
  text-align:center;
}

/* =========================
   MISSION SCREEN
========================= */

#missionScreen{
  position:fixed;
  inset:0;
  z-index:55;

  display:none;
  align-items:center;
  justify-content:center;

  background:#05080bf2;
}

.levelGrid{
  display:grid;
  grid-template-columns:
    repeat(4,1fr);

  gap:7px;
  margin-top:20px;
}

.levelGrid button{
  min-height:48px;
  padding:7px;
  font-size:10px;
}

.locked{
  opacity:.25;
}

/* =========================
   DAMAGE
========================= */

#damage{
  position:fixed;
  inset:0;
  z-index:14;

  pointer-events:none;

  background:
    radial-gradient(
      circle,
      transparent 35%,
      rgba(210,0,0,.65)
    );

  opacity:0;
}

/* =========================
   LANDSCAPE NOTICE
========================= */

#rotateNotice{
  display:none;
  position:fixed;
  inset:0;
  z-index:100;

  background:#05080b;
  align-items:center;
  justify-content:center;
  text-align:center;
  padding:30px;
}

@media (orientation:portrait) and (max-width:700px){
  #rotateNotice{
    display:flex;
  }
}

@media (orientation:landscape) and (max-height:520px){
  #aimArea{
    top:43%;
  }

  .stickArea{
    width:132px;
    height:132px;
  }

  .stickBase{
    width:132px;
    height:132px;
  }

  .stick{
    left:36px;
    top:36px;
  }

  #actionControls{
    right:calc(12px + env(safe-area-inset-right));
    bottom:calc(10px + env(safe-area-inset-bottom));
    transform:scale(.88);
    transform-origin:bottom right;
  }
}

@media(max-width:700px){
  .panel{
    padding:25px;
  }

  .hud{
    gap:4px;
  }

  .box{
    min-width:60px;
    padding:5px 6px;
  }

  .box.big{
    display:none;
  }

  .value{
    font-size:10px;
  }

  .label{
    font-size:6px;
  }
}

/* ARSENAL / CUTSCENE */
#shopScreen,#cutsceneScreen{position:fixed;inset:0;z-index:80;display:none;align-items:center;justify-content:center;background:rgba(3,6,8,.94)}
#shopScreen .panel{width:min(900px,94vw);max-height:88vh;overflow:auto}
.shopTop{display:flex;justify-content:space-between;gap:15px;align-items:center;margin-bottom:14px}.credits{font-size:16px;font-weight:900;color:#e4d47a}
.shopGrid{display:grid;grid-template-columns:repeat(3,1fr);gap:10px}.dwolfUpgrade{margin:10px 0 16px;padding:14px;background:#0a1013;border:1px solid #39484e;border-left:3px solid #c49a63;border-radius:8px}.dwolfUpgrade h3{margin:0 0 5px;font-size:16px;letter-spacing:1px}.dwolfUpgrade .upgradeSub{font-size:10px;color:#9aa6aa;line-height:1.5;margin-bottom:10px}.upgradeRow{display:grid;grid-template-columns:1fr auto auto;gap:8px;align-items:center;padding:8px 0;border-top:1px solid #202a2e}.upgradeRow:first-of-type{border-top:0}.upgradeName{font-weight:800;font-size:11px}.upgradeLevel{font-size:10px;color:#c49a63}.upgradeRow button{padding:7px 9px;font-size:10px}.weaponCard{padding:14px;background:#0b1114;border:1px solid #35434a;border-radius:7px;min-height:145px}.weaponCard.equipped{border-color:#55c77e;box-shadow:0 0 18px #55c77e22}.weaponName{font-size:16px;font-weight:900;letter-spacing:1px}.weaponMeta{font-size:10px;color:#849198;line-height:1.55;margin:7px 0 12px}.weaponCard button{width:100%;padding:10px}.weaponCard button:disabled{opacity:.35}
.outfitTitle{margin:18px 0 8px;color:#aab6bb;font-size:11px;letter-spacing:2px}.outfitGrid{display:grid;grid-template-columns:repeat(4,1fr);gap:10px}.outfitCard{padding:12px;background:#0b1114;border:1px solid #35434a;border-radius:7px}.outfitCard.equipped{border-color:#55c77e;box-shadow:0 0 18px #55c77e22}.outfitName{font-size:13px;font-weight:900}.outfitMeta{font-size:9px;color:#849198;line-height:1.5;margin:6px 0 10px}@media(max-width:700px){.outfitGrid{grid-template-columns:1fr 1fr}}
#shopScreen{overflow:hidden !important;touch-action:auto !important;align-items:flex-start !important;padding:20px 0;box-sizing:border-box}
#shopScreen .panel{max-height:calc(100vh - 40px);overflow-y:auto;overflow-x:hidden;touch-action:pan-y !important;-webkit-overflow-scrolling:touch;overscroll-behavior:contain;padding-bottom:28px}
#shopScreen *{touch-action:auto !important}
#shopScreen .companionSection{margin-top:18px}
#companionGrid{display:grid;grid-template-columns:repeat(3,1fr);gap:8px}
.companionCard{background:#0b1013;border:1px solid #263239;padding:10px;min-height:155px;position:relative}
.companionCard.equipped{border-color:#65d7ff;box-shadow:0 0 18px #65d7ff22}
.companionPreview{height:66px;display:flex;align-items:center;justify-content:center;font-size:42px;filter:drop-shadow(0 8px 5px #0008)}
.companionName{font-weight:800;letter-spacing:1px;color:#e7eef1;font-size:13px}
.companionMeta{font-size:9px;color:#7f8c92;line-height:1.45;margin:5px 0 8px}
.companionStats{font-size:9px;color:#a9c4cc;margin-bottom:8px}
.companionUpgrade{margin-top:12px;padding:10px;background:#0a0f12;border:1px solid #253137}
.companionUpgrade h3{margin:0 0 4px;color:#e7eef1;font-size:13px}
.companionUpgrade .upgradeSub{font-size:9px;color:#748187;margin-bottom:8px}
.companionUpgrade .upgradeRow{display:grid;grid-template-columns:1fr auto auto;gap:8px;align-items:center;margin:5px 0}
@media(max-width:700px){#companionGrid{grid-template-columns:repeat(2,1fr)}}

.skinGrid{display:grid;grid-template-columns:repeat(4,1fr);gap:10px}.skinCard{padding:12px;background:#0b1114;border:1px solid #35434a;border-radius:7px}.skinCard.equipped{border-color:#55c77e;box-shadow:0 0 18px #55c77e22}.skinSwatch{height:48px;border-radius:5px;margin-bottom:8px;border:1px solid #5a666b}.skinName{font-size:12px;font-weight:900}.skinMeta{font-size:9px;color:#849198;line-height:1.5;margin:6px 0 10px}@media(max-width:700px){.skinGrid{grid-template-columns:1fr 1fr}}
.newGameBtn{margin-top:8px;background:#151c20;border-color:#7d3a3e;color:#f0b5b7}

#cutsceneScreen{z-index:95;background:radial-gradient(circle at 70% 35%,#172329,#030607 65%)}.cutsceneBox{width:min(760px,90vw);padding:28px;border-left:3px solid #b72d34;background:rgba(5,9,11,.9);box-shadow:0 20px 70px #000}.cutsceneKicker{font-size:10px;letter-spacing:4px;color:#849198}.cutsceneTitle{font-size:clamp(28px,6vw,52px);font-weight:900;letter-spacing:3px;margin:8px 0 14px}.cutsceneText{min-height:74px;color:#c4cdd0;line-height:1.65;font-size:14px}.cutsceneFooter{display:flex;justify-content:space-between;align-items:center;margin-top:20px;gap:10px}.cutsceneSkip{background:#202a2f}
@media(max-width:700px){.shopGrid{grid-template-columns:1fr 1fr}.weaponCard{min-height:135px;padding:10px}.weaponName{font-size:13px}}@media(max-width:480px){.shopGrid{grid-template-columns:1fr}}

/* =========================================================
   PAD TO HOME STUDIO INTRO
========================================================= */
#studioIntro{position:fixed;inset:0;z-index:20000;background:#030506;color:#fff;display:flex;align-items:center;justify-content:center;overflow:hidden;font-family:Arial,sans-serif;}
#studioIntro .introFrame{position:absolute;inset:0;display:flex;align-items:center;justify-content:center;opacity:0;transform:scale(1.04);transition:opacity .75s ease,transform 1.2s ease;}
#studioIntro .introFrame.show{opacity:1;transform:scale(1);}
#studioIntro .introFrame.hide{opacity:0;transform:scale(1.08);}
.introVignette{position:absolute;inset:0;background:radial-gradient(circle at center,transparent 25%,rgba(0,0,0,.78) 100%);pointer-events:none;}
.introGrid{position:absolute;inset:0;background:linear-gradient(rgba(255,255,255,.035) 1px,transparent 1px),linear-gradient(90deg,rgba(255,255,255,.035) 1px,transparent 1px);background-size:55px 55px;opacity:.28;}
.studioMark{text-align:center;position:relative;z-index:2;letter-spacing:5px;text-transform:uppercase;}
.studioMark .small{font-size:clamp(12px,2vw,20px);color:#8e989e;letter-spacing:8px;margin-bottom:16px;}
.studioMark .big{font-size:clamp(42px,9vw,110px);font-weight:900;text-shadow:0 0 28px rgba(255,255,255,.15);}
.studioMark .line{height:2px;width:min(520px,70vw);margin:22px auto;background:linear-gradient(90deg,transparent,#d52b2b,transparent);}
.gameReveal{text-align:center;position:relative;z-index:2;text-transform:uppercase;}
.gameReveal .present{font-size:clamp(12px,2vw,18px);letter-spacing:7px;color:#aab3b8;margin-bottom:18px;}
.gameReveal .title{font-size:clamp(44px,10vw,120px);font-weight:950;letter-spacing:3px;line-height:.9;text-shadow:0 0 30px rgba(215,0,0,.25);}
.gameReveal .title span{color:#d32c2c;}
.gameReveal .subtitle{margin-top:20px;font-size:clamp(10px,1.7vw,16px);letter-spacing:6px;color:#68737a;}
.introScene{position:absolute;inset:0;background:linear-gradient(180deg,#0a0e11 0%,#111820 55%,#050607 100%);}
.introScene:before{content:"";position:absolute;left:0;right:0;bottom:18%;height:1px;background:#303a40;box-shadow:0 40px 0 #11181d,0 80px 0 #0c1115;}
.introSilhouette{position:absolute;bottom:18%;left:50%;width:28px;height:115px;background:#07090a;border-radius:16px 16px 7px 7px;transform:translateX(-50%);box-shadow:0 0 30px rgba(0,0,0,.9);}
.introSilhouette:before{content:"";position:absolute;width:42px;height:42px;border-radius:50%;background:#050607;left:50%;top:-34px;transform:translateX(-50%);}
.introSilhouette:after{content:"";position:absolute;width:120px;height:12px;background:#090b0c;left:8px;top:52px;transform:rotate(-12deg);transform-origin:left center;}
@media(max-width:700px){#bossBar{top:68px;width:84vw}#bossBar #bossName{font-size:10px}}


/* V25.6.45 · 200 Level · Missionsarchiv exakt nach dem Shop-Scroll-Prinzip */
#missionScreen{
  position:fixed !important;
  inset:0 !important;
  z-index:55 !important;
  display:none;
  align-items:flex-start !important;
  justify-content:center !important;
  background:#05080bf2 !important;
  overflow:hidden !important;
  touch-action:auto !important;
  padding:20px 0 !important;
  box-sizing:border-box !important;
}
#missionScreen .panel{
  width:min(900px,94vw) !important;
  max-height:calc(100vh - 40px) !important;
  overflow:auto !important;
  overflow-x:hidden !important;
  -webkit-overflow-scrolling:touch !important;
  overscroll-behavior:contain !important;
  touch-action:auto !important;
  padding-bottom:28px !important;
}
#missionScreen .levelGrid{
  display:grid !important;
  grid-template-columns:repeat(4,1fr) !important;
  gap:7px !important;
  margin-top:20px !important;
  overflow:visible !important;
  max-height:none !important;
  touch-action:auto !important;
}
#missionScreen .levelGrid button{
  touch-action:auto !important;
}
@media(max-width:700px){
  #missionScreen .panel{
    width:94vw !important;
    max-height:calc(100vh - 40px) !important;
  }
}


<style>
/* BLACKLIST OPERATIV // V27 ARSENAL + DEATH SCREEN */
#arsenalSpecial{margin-top:16px;padding:14px;border:1px solid #26343b;background:linear-gradient(180deg,#0b1115,#070a0d);border-radius:14px}
#arsenalSpecial .specialHead{font-size:13px;font-weight:900;letter-spacing:2px;color:#e42e42;margin-bottom:10px}
.specialGrid{display:grid;grid-template-columns:repeat(2,minmax(0,1fr));gap:10px}
.specialCard{border:1px solid #26343b;border-radius:12px;padding:11px;background:#0a0f13;box-shadow:inset 0 0 20px #0005}
.specialCard.selected{border-color:#65d7ff;box-shadow:0 0 18px #65d7ff22,inset 0 0 20px #0008}
.specialName{font-weight:900;color:#fff;font-size:13px;letter-spacing:1px}
.specialMeta{font-size:10px;line-height:1.45;color:#87959b;margin:6px 0 9px}
.specialCard button{width:100%;margin:0}
#deathScreen{position:fixed;inset:0;z-index:9998;display:none;align-items:center;justify-content:center;background:radial-gradient(circle at center,#180b0d 0%,#07090b 55%,#020304 100%);padding:20px;box-sizing:border-box}
#deathScreen .deathBox{width:min(520px,92vw);border:1px solid #7f1f27;background:linear-gradient(180deg,#0e1114,#050607);box-shadow:0 0 50px #e42e4222,inset 0 0 40px #000;border-radius:18px;padding:28px;text-align:center}
#deathScreen .deathKicker{color:#e42e42;font-size:11px;font-weight:900;letter-spacing:4px}
#deathScreen .deathTitle{color:#fff;font-size:42px;font-weight:1000;letter-spacing:5px;margin:8px 0;text-shadow:0 0 22px #e42e42}
#deathScreen .deathText{color:#89979d;font-size:12px;letter-spacing:2px;margin-bottom:22px}
#deathScreen .deathButtons{display:flex;gap:10px;justify-content:center;flex-wrap:wrap}
#deathScreen button{min-width:190px}
@media(max-width:620px){.specialGrid{grid-template-columns:1fr}#deathScreen .deathTitle{font-size:30px}}
</style>

</style>

<!-- BLACKLIST OPERATIV // PWA UPGRADE -->
<meta name="theme-color" content="#05080b">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="apple-mobile-web-app-title" content="BLACKLIST OPERATIV">
<link rel="manifest" href="data:application/manifest+json;base64,eyJuYW1lIjoiQkxBQ0tMSVNUIE9QRVJBVElWIiwic2hvcnRfbmFtZSI6IkJMQUNLTElTVCIsInN0YXJ0X3VybCI6Ii4vIiwiZGlzcGxheSI6InN0YW5kYWxvbmUiLCJvcmllbnRhdGlvbiI6ImxhbmRzY2FwZSIsImJhY2tncm91bmRfY29sb3IiOiIjMDUwODBiIiwidGhlbWVfY29sb3IiOiIjMDUwODBiIiwiZGVzY3JpcHRpb24iOiJCTEFDS0xJU1QgT1BFUkFUSVYgXHUyMDEzIE1vYmlsZSBUYWN0aWNhbCBPcGVyYXRpb25zIiwiaWNvbnMiOlt7InNyYyI6ImRhdGE6aW1hZ2Uvc3ZnK3htbCwlM0NzdmcgeG1sbnM9JTIyaHR0cCUzQSUyRiUyRnd3dy53My5vcmclMkYyMDAwJTJGc3ZnJTIyIHZpZXdCb3g9JTIyMCAwIDE5MiAxOTIlMjIlM0UlM0NyZWN0IHdpZHRoPSUyMjE5MiUyMiBoZWlnaHQ9JTIyMTkyJTIyIHJ4PSUyMjQwJTIyIGZpbGw9JTIyJTIzMDUwODBiJTIyLyUzRSUzQ3BhdGggZD0lMjJNMzIgNDhoMTI4djk2SDMyeiUyMiBmaWxsPSUyMiUyM2U0MmU0MiUyMi8lM0UlM0NwYXRoIGQ9JTIyTTQ4IDY0aDk2djY0SDQ4eiUyMiBmaWxsPSUyMiUyMzA1MDgwYiUyMi8lM0UlM0N0ZXh0IHg9JTIyOTYlMjIgeT0lMjIxMDUlMjIgdGV4dC1hbmNob3I9JTIybWlkZGxlJTIyIGZvbnQtZmFtaWx5PSUyMkFyaWFsJTIyIGZvbnQtc2l6ZT0lMjIyMiUyMiBmb250LXdlaWdodD0lMjI5MDAlMjIgZmlsbD0lMjIlMjNmZmYlMjIlM0VCTyUzQyUyRnRleHQlM0UlM0MlMkZzdmclM0UiLCJzaXplcyI6IjE5MngxOTIiLCJ0eXBlIjoiaW1hZ2Uvc3ZnK3htbCJ9XX0=">
<link rel="apple-touch-icon" href="data:image/svg+xml,%3Csvg xmlns=%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22 viewBox=%220 0 192 192%22%3E%3Crect width=%22192%22 height=%22192%22 rx=%2240%22 fill=%22%2305080b%22/%3E%3Cpath d=%22M32 48h128v96H32z%22 fill=%22%23e42e42%22/%3E%3Cpath d=%22M48 64h96v64H48z%22 fill=%22%2305080b%22/%3E%3Ctext x=%2296%22 y=%22105%22 text-anchor=%22middle%22 font-family=%22Arial%22 font-size=%2222%22 font-weight=%22900%22 fill=%22%23fff%22%3EBO%3C%2Ftext%3E%3C%2Fsvg%3E">
<style>
#pwaInstallCard{position:fixed;left:50%;bottom:18px;transform:translateX(-50%);z-index:10000;width:min(560px,92vw);background:linear-gradient(145deg,#0c1115,#06090b);border:1px solid #46535a;box-shadow:0 18px 60px #000b,0 0 30px #e42e4222;border-radius:14px;padding:14px 16px;display:none;color:#e7eef1;font-family:inherit}
#pwaInstallCard .pwaTitle{font-weight:900;letter-spacing:1.5px;font-size:13px}.pwaSub{color:#87959b;font-size:10px;line-height:1.5;margin-top:5px}.pwaBtns{display:flex;gap:8px;margin-top:10px}.pwaBtns button{flex:1;margin:0!important}.pwaClose{background:#11171b!important;border-color:#364248!important}
.appBadge{display:inline-flex;align-items:center;gap:6px;border:1px solid #3c4a50;border-radius:999px;padding:5px 9px;font-size:9px;color:#aebbc0;margin-top:8px}
</style>

<!-- PWA NOTE: Service Worker must be a separate same-origin file (sw.js). Browsers do not allow registering a service worker from a data/blob URL. The game itself remains fully self-contained. -->
</head>

<body>
<div id="pwaInstallCard"><div class="pwaTitle">📱 BLACKLIST OPERATIV // APP-MODUS</div><div class="pwaSub">Auf iPad/iPhone: Teilen → „Zum Home-Bildschirm“. Danach startet BLACKLIST OPERATIV wie eine App im Vollbild.</div><div class="appBadge">⚡ PWA · OFFLINE CACHE · FULLSCREEN</div><div class="pwaBtns"><button id="pwaHow">ANLEITUNG</button><button id="pwaClose" class="pwaClose">SPÄTER</button></div></div>


<!-- =========================
     PAD TO HOME STUDIOS INTRO
========================= -->
<div id="studioIntro" aria-label="Pad to Home Studios Intro">
  <div class="introFrame" id="introSceneFrame">
    <div class="introScene"></div><div class="introSilhouette"></div><div class="introVignette"></div>
  </div>
  <div class="introFrame" id="introGameFrame">
    <div class="introGrid"></div><div class="introVignette"></div>
    <div class="gameReveal">
      <div class="present">PAD TO HOME STUDIOS PRÄSENTIERT</div>
      <div class="title">BLACKLIST <span>OPERATIV</span></div>
      <div class="subtitle">MOBILE TACTICAL OPERATIONS</div>
    </div>
  </div>
</div>

<button id="audioToggle" aria-label="Ton an/aus" style="position:fixed;right:10px;top:10px;z-index:9999;background:#101418;color:#fff;border:1px solid #59636a;border-radius:10px;padding:8px 11px;font-weight:700">🔊 TON AN</button>


<canvas id="game"></canvas>

<!-- =========================
     PORTRAIT WARNING
========================= -->

<div id="rotateNotice">
  <div>
    <div style="font-size:50px">📱↔️</div>
    <h2>BITTE QUERFORMAT</h2>
    <p style="color:#89969d">
      BLACKLIST OPERATIV ist für das Spielen im
      Querformat optimiert.
    </p>
  </div>
</div>

<!-- =========================
     MENU
========================= -->

<div id="menu">

  <div class="panel">

    <div class="logo">
      BLACKLIST <span>OPERATIV</span>
    </div>

    <div class="sub">
      MOBILE TACTICAL OPERATIONS
    </div>

    <div class="description">
      Agent Zero befindet sich hinter feindlichen Linien.
      Nutze Bewegung, Deckung und Tarnung, um die Mission
      erfolgreich abzuschließen.
    </div>

    <button id="start">
      OPERATION STARTEN
    </button>

    <button id="missionsButton"
            style="margin-left:6px">
      MISSIONEN
    </button>

    <button id="shopButton" style="margin-left:6px">
      ARSENAL
    </button>

    <button id="newGameButton" class="newGameBtn">
      NEUES SPIEL
    </button>

    <div class="mobileInfo">
      🕹️ Links bewegen (auch hoch/runter) · 🎯 Rechts zielen · 🔴 Feuer
      · 🥷 Tarnung · 🔄 Nachladen
      <br><br>
      <b>Wichtig:</b> Gegner reagieren nicht sofort.
      🟡 bedeutet Verdacht. Erst 🔴 bedeutet echten Sichtkontakt.
    </div>

  </div>

</div>

<!-- =========================
     MISSIONS
========================= -->

<div id="missionScreen">

  <div class="panel">

    <div class="logo"
         style="font-size:30px">
      MISSIONS<span>ARCHIV</span>
    </div>

    <div style="color:#7f8c92;margin-top:8px">
      FREIGESCHALTETE EINSÄTZE · RANG LVL <span id="missionRankText">1</span>
    </div>

    <div id="levelGrid"
         class="levelGrid">
    </div>

    <button
      onclick="closeMissions()"
      style="margin-top:20px">
      ZURÜCK
    </button>

  </div>

</div>

<!-- =========================
     HUD
========================= -->

<div id="bossBar" style="display:none;position:fixed;top:78px;left:50%;transform:translateX(-50%);width:min(620px,78vw);z-index:30;pointer-events:none;text-align:center;font-family:Arial,sans-serif">
  <div style="font-size:12px;font-weight:900;letter-spacing:2px;color:#ff4b54;text-shadow:0 0 10px #ff2020" id="bossName">BOSS</div>
  <div style="height:12px;background:#12090b;border:1px solid #8f2b31;border-radius:8px;overflow:hidden;box-shadow:0 0 16px #ff263522">
    <div id="bossFill" style="height:100%;width:100%;background:linear-gradient(90deg,#8e1f29,#ff3f49);transition:width .08s"></div>
  </div>
  <div id="bossHpText" style="font-size:10px;color:#f2b0b4;margin-top:3px">0 / 0</div>
</div>

<div id="hud">

  <div class="hud">

    <div class="box">
      <div class="label">AGENT</div>
      <div class="value">ZERO</div>
    </div>

    <div class="box">
      <div class="label">MISSION</div>
      <div
        class="value"
        id="missionText">
        01
      </div>
    </div>

    <div class="box">
      <div class="label">GEGNER</div>
      <div class="value" id="enemyCountText">0</div>
    </div>

    <div class="box">
      <div class="label">HP</div>
      <div
        class="value"
        id="hpText">
        100
      </div>
    </div>

    <div class="box">
      <div class="label">MUNITION</div>
      <div
        class="value"
        id="ammoText">
        30/150
      </div>
    </div>

    <div class="box">
      <div class="label">LEVEL</div>
      <div class="value" id="rankText">LVL 1 · REKRUT</div>
      <div id="hudXpBar" style="height:5px;background:#172126;border-radius:3px;margin-top:6px;overflow:hidden">
        <div id="hudXpFill" style="height:100%;width:0%;background:#55c77e;transition:width .2s"></div>
      </div>
      <div id="hudXpText" style="font-size:9px;color:#7f8c92;margin-top:3px">XP 0/250</div>
    </div>

    <div class="box">
      <div class="label">WAFFE</div>
      <div class="value" id="weaponText">SILENT</div>
    </div>

    <div class="box big">
      <div class="label">AUFTRAG</div>
      <div
        class="value"
        id="objectiveText">
        Gegner ausschalten
      </div>
    </div>

  </div>

</div>

<!-- =========================
     MOBILE CONTROLS
========================= -->

<div id="mobileControls">

  <div
    id="moveArea"
    class="stickArea">

    <div class="stickBase"></div>
    <div
      id="moveStick"
      class="stick">
    </div>

  </div>

  <div
    id="aimArea"
    class="stickArea">

    <div class="aimLabel">ZIELEN</div>
    <div class="stickBase"></div>
    <div
      id="aimStick"
      class="stick">
    </div>

  </div>

  <!-- Rechte Aktionstasten liegen unterhalb des Ziel-Joysticks -->
  <div id="actionControls">

    <div id="actionRow">
      <div
        id="fireButton"
        class="controlButton">
        FEUER
      </div>

      <div
        id="reloadButton"
        class="controlButton">
        NACHLADEN
      </div>
    </div>
  </div>

  <button
    id="pauseButton">
    II
  </button>

</div>

<div id="crosshair">
  <div class="crossCircle"></div>
</div>
</div>

<div id="alert"></div>

<div id="damage"></div>

<div id="shopScreen">
  <div class="panel">
    <div class="shopTop">
      <div>
        <div class="logo" style="font-size:30px">ARSENAL<span> // FIELD SHOP</span></div>
        <div style="color:#7f8c92;margin-top:5px">AUSRÜSTUNG FÜR AGENT ZERO</div>
      </div>
      <div class="credits">$ <span id="creditsText">0</span></div>
    </div>
    <div class="outfitTitle">WAFFEN · LEVEL-FREISCHALTUNGEN</div>
    <div id="weaponProgress" style="font-size:10px;color:#7f8c92;margin:-2px 0 10px;line-height:1.5"></div>
    <div id="shopGrid" class="shopGrid"></div>
    <div id="dwolfUpgradePanel" class="dwolfUpgrade" style="display:none"></div>
    <div class="outfitTitle companionSection">BEGLEITER // K9 &amp; SPECIAL</div>
    <div id="companionGrid" class="companionGrid"></div>
    <div id="companionUpgradePanel" class="companionUpgrade" style="display:none"></div>
    <div class="outfitTitle">OUTFITS / KLEIDUNG</div>
    <div id="outfitGrid" class="outfitGrid"></div>
    <div class="outfitTitle">WAFFEN-SKINS</div>
    <div id="skinGrid" class="skinGrid"></div>
    <div id="arsenalSpecial"><div class="specialHead">ARSENAL // SPECIAL-AMMO</div><div id="specialAmmoGrid" class="specialGrid"></div></div>
    <button onclick="closeShop()" style="margin-top:16px">ZURÜCK</button>
  </div>
</div>


<div id="deathScreen">
  <div class="deathBox">
    <div class="deathKicker">BLACKLIST OPERATIV // ZERO</div>
    <div class="deathTitle">AGENT DOWN</div>
    <div class="deathText">MISSION GESCHEITERT · ZERO IST GEFALLEN</div>
    <div class="deathButtons">
      <button id="deathRetry">ERNEUT VERSUCHEN</button>
      <button id="deathMenu">HAUPTMENÜ</button>
    </div>
  </div>
</div>

<div id="cutsceneScreen">
  <div class="cutsceneBox">
    <div class="cutsceneKicker">BLACKLIST OPERATIV // BRIEFING</div>
    <div class="cutsceneTitle" id="cutsceneTitle">OPERATION</div>
    <div class="cutsceneText" id="cutsceneText"></div>
    <div class="cutsceneFooter">
      <div style="color:#68777d;font-size:10px;letter-spacing:1px">TACTICAL INSERT // ZERO</div>
      <button class="cutsceneSkip" id="cutsceneSkip">ÜBERSPRINGEN</button>
    </div>
  </div>
</div>

<!-- =========================
     PAUSE
========================= -->

<div id="pause">

  <div class="panel">

    <div
      class="logo"
      style="font-size:32px">
      PAUSE
    </div>

    <p style="color:#8c989e">
      BLACKLIST OPERATIV
    </p>

    <button onclick="resumeGame()">
      WEITERSPIELEN
    </button>

    <button onclick="openShop()" style="margin-left:5px">
      ARSENAL
    </button>

    <button
      onclick="backMenu()"
      style="margin-left:5px">
      HAUPTMENÜ
    </button>

  </div>

</div>

<script>

/* =========================================================
   CANVAS
========================================================= */

const canvas =
  document.getElementById("game");

const ctx =
  canvas.getContext("2d");

let W =
  innerWidth;

let H =
  innerHeight;

let DPR =
  Math.min(devicePixelRatio || 1,2);

function resize(){

  W=innerWidth;
  H=innerHeight;

  canvas.width=W*DPR;
  canvas.height=H*DPR;

  canvas.style.width=W+"px";
  canvas.style.height=H+"px";

  ctx.setTransform(
    DPR,0,0,DPR,0,0
  );
}

addEventListener(
  "resize",
  resize
);

resize();


/* =========================================================
   TOUCH STATE
========================================================= */

const touch={
  move:{
    active:false,
    id:null,
    x:0,
    y:0
  },

  aim:{
    active:false,
    id:null,
    x:0,
    y:0
  },

  fire:false
};


/* =========================================================
   VIRTUAL JOYSTICK
========================================================= */

function setupStick(areaId,stickId,type){

  const area=
    document.getElementById(areaId);

  const stick=
    document.getElementById(stickId);

  const data=
    touch[type];

  const radius=42;

  function update(e){

    const rect=
      area.getBoundingClientRect();

    const cx=
      rect.left+rect.width/2;

    const cy=
      rect.top+rect.height/2;

    let dx=e.clientX-cx;
    let dy=e.clientY-cy;

    const length=
      Math.hypot(dx,dy);

    if(length>radius){

      dx=
        dx/length*radius;

      dy=
        dy/length*radius;
    }

    data.x=
      dx/radius;

    data.y=
      dy/radius;

    stick.style.transform=
      `translate(${dx}px,${dy}px)`;

    if(type==="aim"){

      const dead=.16;

      const aimLength=Math.hypot(
        data.x,
        data.y
      );

      if(aimLength>dead){

        // Immer normieren: Schussrichtung = exakt Stickrichtung.
        player.aimX=data.x/aimLength;
        player.aimY=data.y/aimLength;

        moveCrosshair();
      }
    }
  }

  area.addEventListener(
    "pointerdown",
    e=>{

      e.preventDefault();

      data.active=true;
      data.id=e.pointerId;

      area.setPointerCapture(
        e.pointerId
      );

      update(e);
    }
  );

  area.addEventListener(
    "pointermove",
    e=>{

      if(
        !data.active ||
        e.pointerId!==data.id
      )return;

      e.preventDefault();

      update(e);
    }
  );

  function reset(e){

    if(
      !data.active ||
      e.pointerId!==data.id
    )return;

    data.active=false;
    data.id=null;
    data.x=0;
    data.y=0;

    stick.style.transform=
      "translate(0px,0px)";
  }

  area.addEventListener(
    "pointerup",
    reset
  );

  area.addEventListener(
    "pointercancel",
    reset
  );

  area.addEventListener(
    "lostpointercapture",
    e=>{
      if(data.active && e.pointerId===data.id){
        reset(e);
      }
    }
  );
}

setupStick(
  "moveArea",
  "moveStick",
  "move"
);

setupStick(
  "aimArea",
  "aimStick",
  "aim"
);


/* =========================================================
   FIRE
========================================================= */

const fireButton=
  document.getElementById(
    "fireButton"
  );

fireButton.addEventListener(
  "pointerdown",
  e=>{

    e.preventDefault();

    touch.fire=true;

    fireButton.setPointerCapture(
      e.pointerId
    );
  }
);

function stopFire(){
  touch.fire=false;
}

fireButton.addEventListener(
  "pointerup",
  stopFire
);

fireButton.addEventListener(
  "pointercancel",
  stopFire
);


/* =========================================================
   BUTTONS
========================================================= */

document
  .getElementById("reloadButton")
  .addEventListener(
    "pointerdown",
    e=>{
      e.preventDefault();
      reload();
    }
  );

document
  .getElementById("pauseButton")
  .addEventListener(
    "pointerdown",
    e=>{
      e.preventDefault();
      togglePause();
    }
  );


/* =========================================================
   MISSIONS
========================================================= */

const missions=[

 ["01","Absturzstelle","WALD",
  "Eliminiere alle Gegner",18,"clear"],

 ["02","Außenposten","WALD",
  "Erreiche die Extraktion",16,"reach"],

 ["03","Grenzgebiet","STEPPE",
  "Eliminiere alle Gegner",22,"clear"],

 ["04","Stadt bei Nacht","CITY",
  "Sichere das Einsatzgebiet",20,"clear"],

 ["05","Industriekomplex","FACTORY",
  "Zerstöre das Ziel",18,"target"],

 ["06","Hafen","HARBOR",
  "Erreiche die Evakuierung",24,"reach"],

 ["07","Wüstenstation","DESERT",
  "Eliminiere alle Gegner",25,"clear"],

 ["08","Geheime Basis","BASE",
  "Sichere das Gebiet",27,"clear"],

 ["09","Flughafen","AIRPORT",
  "Stoppe die Operation",25,"target"],

 ["10","Bergpass","MOUNTAIN",
  "Erreiche die Extraktion",22,"reach"],

 ["11","Regenwald","JUNGLE",
  "Eliminiere die Einheit",24,"clear"],

 ["12","Tunnelanlage","TUNNEL",
  "Sichere die Anlage",21,"clear"],

 ["13","Verlassene Stadt","CITY",
  "Eliminiere alle Gegner",28,"clear"],

 ["14","Militärkonvoi","STEPPE",
  "Zerstöre das Ziel",24,"target"],

 ["15","Forschungsanlage","LAB",
  "Sichere die Anlage",30,"clear"],

 ["16","Nachtoperation","NIGHT",
  "Erreiche die Extraktion",26,"reach"],

 ["17","Lagerhäuser","HARBOR",
  "Eliminiere alle Gegner",30,"clear"],

 ["18","Grenzposten","MOUNTAIN",
  "Sichere den Sektor",32,"clear"],

 ["19","Geheime Startbahn","AIRPORT",
  "Zerstöre das Hauptziel",32,"target"],

 ["20","BLACKLIST","BASE",
  "Erreiche das Kommandozentrum",35,"reach"],

 ["21","Operation ECHO","JUNGLE",
  "Eliminiere alle Gegner",35,"clear"],

 ["22","Operation GHOST","NIGHT",
  "Sichere den Sektor",38,"clear"],

 ["23","Operation IRON","FACTORY",
  "Zerstöre das Hauptziel",38,"target"],

 ["24","Operation ZERO","CITY",
  "Erreiche die Extraktion",40,"reach"],

 ["25","BLACKLIST FINAL","BASE",
  "Eliminiere das Kommando",45,"clear"],

 ["26","SKYFALL","HELI",
  "Erreiche den Hubschrauber",32,"reach"],

 ["27","FREEFALL","SHIP",
  "Lande auf dem Frachtschiff",34,"reach"],

 ["28","CARGO RAID","SHIP",
  "Sichere das Frachtschiff",42,"clear"],

 ["29","RUNWAY","RUNWAY",
  "Erreiche das Flugzeug",45,"reach"],

 ["30","LAST FLIGHT","PLANE",
  "Zerstöre das Flugzeug und springe ab",50,"target"],

 ["31","GHOST TRAIN","METRO",
  "Sichere den Zug und erreiche den Tunnel",38,"reach"],

 ["32","BLACK ICE","SNOWBASE",
  "Eliminiere die Eliteeinheit",44,"clear"],

 ["33","RED HORIZON","DAM",
  "Zerstöre den Energiekern",48,"target"]

];


/* =========================================================
   CHAPTER 2–8 · ERWEITERUNG BIS LEVEL 200
   Level werden weiterhin EINZELN nacheinander freigeschaltet.
========================================================= */
(function extendMissionsTo500(){
  const names=[
    "NACHTSEKTOR","DUNKLER HAFEN","WALDGRenze","STAHLWERK","GEISTERSTADT",
    "SANDSTURM","EISFRONT","TUNNEL WEST","SCHATTENBASIS","ROTER KORRIDOR",
    "VERLASSENER FLUGHAFEN","NORDKONVOI","VERBORGENES LABOR","MONDPOSTEN","URBAN RAID",
    "HAFENBLOCK","BERGPASS II","NACHTHAFEN","BLACKOUT","GRAUZONE",
    "ECHO FALL","GHOST SECTOR","IRON WALL","ZERO POINT","NIGHT RAID",
    "COLD HARBOR","DUST LINE","FROST LINE","DARK RUNWAY","FINAL APPROACH",
    "SHADOW CITY","STEEL DISTRICT","RED DOCKS","NIGHTFALL","BROKEN DAM",
    "BLACK FOREST","ICE STATION","DEAD CITY","WAR FACTORY","ZERO HOUR",
    "DEEP HARBOR","SILENT BASE","RED VALLEY","DARK CONVOY","GHOST PORT",
    "FROZEN CITY","IRON PASS","BLACK TERMINAL","NIGHT COMMAND","LAST OUTPOST",
    "RAVEN CITY","STEEL HORIZON","DUST FORT","COLD TERMINAL","RED SECTOR",
    "BLACK DISTRICT","GHOST RUN","IRON HARBOR","ZERO SECTOR","FINAL CITY",
    "SHADOW FRONT","FROST COMMAND","NIGHT FACTORY","RED BASE","BLACK HARBOR",
    "DEAD RUNWAY","IRON CITY","DARK MOUNTAIN","GHOST STATION","ZERO FORT",
    "BLACKLINE","RED TERMINAL","NIGHT HORIZON","STEEL BASE","FINAL OPERATION"
  ];
  const envs=["CITY","NIGHT","FACTORY","HARBOR","BASE","AIRPORT","MOUNTAIN","JUNGLE","DESERT","CITY"];
  for(let n=34;n<=500;n++){
    const i=n-34, enemyCount=Math.min(70,28+Math.floor(i*.62));
    const env=envs[i%envs.length];
    const type=(i%3===1)?"reach":(i%3===2?"target":"clear");
    const objective=type==="reach"?"Erreiche den Extraktionspunkt":type==="target"?"Zerstöre das Hauptziel":"Eliminiere alle Gegner";
    missions.push([String(n),names[i%names.length],env,objective,enemyCount,type]);
  }
})();



/* =========================================================
   LEVEL THEMES / STORY TEXT
========================================================= */
const levelThemes=[
 {sky1:'#294653',sky2:'#71877b',ground:'#34453c',accent:'#6f9d75',fog:.08,weather:'mist',detail:'PINE'},
 {sky1:'#29353b',sky2:'#6f7b78',ground:'#343b39',accent:'#b08b52',fog:.10,weather:'dust',detail:'OUTPOST'},
 {sky1:'#6d7375',sky2:'#a69b82',ground:'#6e624d',accent:'#c0a66b',fog:.04,weather:'wind',detail:'STEPPE'},
 {sky1:'#080d16',sky2:'#26313c',ground:'#242a2e',accent:'#5e86a7',fog:.02,weather:'rain',detail:'CITY'},
 {sky1:'#1b2428',sky2:'#4d5a58',ground:'#343b3b',accent:'#d18c4c',fog:.12,weather:'smoke',detail:'FACTORY'},
 {sky1:'#06111a',sky2:'#29434a',ground:'#293333',accent:'#5c9fa9',fog:.09,weather:'rain',detail:'HARBOR'},
 {sky1:'#81765f',sky2:'#b69b73',ground:'#725f48',accent:'#d1a45c',fog:.03,weather:'dust',detail:'DESERT'},
 {sky1:'#10171b',sky2:'#39484b',ground:'#283235',accent:'#647b83',fog:.13,weather:'smoke',detail:'BASE'},
 {sky1:'#17202a',sky2:'#56636b',ground:'#303638',accent:'#7f9eb0',fog:.07,weather:'rain',detail:'AIRPORT'},
 {sky1:'#243a49',sky2:'#73838a',ground:'#394743',accent:'#7ca6b8',fog:.08,weather:'snow',detail:'MOUNTAIN'},
 {sky1:'#17382f',sky2:'#567d69',ground:'#2c4035',accent:'#66a678',fog:.16,weather:'rain',detail:'JUNGLE'},
 {sky1:'#080b0e',sky2:'#22292c',ground:'#202426',accent:'#879399',fog:.18,weather:'smoke',detail:'TUNNEL'},
 {sky1:'#0a1018',sky2:'#303b45',ground:'#252b30',accent:'#8b5960',fog:.10,weather:'rain',detail:'CITY'},
 {sky1:'#5d6664',sky2:'#8f8b76',ground:'#57584d',accent:'#a78b5b',fog:.08,weather:'dust',detail:'CONVOY'},
 {sky1:'#16252a',sky2:'#526e70',ground:'#303b3d',accent:'#68a7a1',fog:.12,weather:'mist',detail:'LAB'},
 {sky1:'#03060b',sky2:'#111b25',ground:'#1b2226',accent:'#6888a4',fog:.05,weather:'rain',detail:'NIGHT'},
 {sky1:'#0b1720',sky2:'#344b50',ground:'#293637',accent:'#6b9a9b',fog:.13,weather:'rain',detail:'WAREHOUSE'},
 {sky1:'#263744',sky2:'#70818a',ground:'#3a4545',accent:'#9b835d',fog:.09,weather:'wind',detail:'MOUNTAIN'},
 {sky1:'#0b1117',sky2:'#28343e',ground:'#252c31',accent:'#9d5e58',fog:.08,weather:'smoke',detail:'AIRFIELD'},
 {sky1:'#090e13',sky2:'#202b31',ground:'#20282c',accent:'#6e8c8d',fog:.18,weather:'mist',detail:'BLACKLIST'},
 {sky1:'#0e2b21',sky2:'#4c7560',ground:'#2a4036',accent:'#74aa79',fog:.18,weather:'rain',detail:'JUNGLE'},
 {sky1:'#02050a',sky2:'#18212b',ground:'#1b2228',accent:'#8a6e93',fog:.06,weather:'rain',detail:'GHOST'},
 {sky1:'#20282a',sky2:'#52605f',ground:'#303737',accent:'#c27a4f',fog:.12,weather:'smoke',detail:'IRON'},
 {sky1:'#090d13',sky2:'#303942',ground:'#252c31',accent:'#b34e55',fog:.09,weather:'rain',detail:'ZERO'},
 {sky1:'#030407',sky2:'#10171c',ground:'#171d21',accent:'#b7353c',fog:.04,weather:'smoke',detail:'FINAL'},
 {sky1:'#07151c',sky2:'#31505b',ground:'#27373b',accent:'#6aa7b5',fog:.10,weather:'wind',detail:'HELI'},
 {sky1:'#06111a',sky2:'#29434a',ground:'#263436',accent:'#5c9fa9',fog:.09,weather:'rain',detail:'SHIP'},
 {sky1:'#07131b',sky2:'#38525b',ground:'#273538',accent:'#74aab3',fog:.08,weather:'rain',detail:'CARGO'},
 {sky1:'#151b20',sky2:'#52636a',ground:'#333a3d',accent:'#c2a96a',fog:.06,weather:'wind',detail:'RUNWAY'},
 {sky1:'#080d12',sky2:'#26343b',ground:'#20282c',accent:'#9aaeb5',fog:.07,weather:'smoke',detail:'PLANE'},
 {sky1:'#090d12',sky2:'#33434b',ground:'#20272b',accent:'#78a5b5',fog:.13,weather:'mist',detail:'METRO'},
 {sky1:'#c7d4d7',sky2:'#71848b',ground:'#39464a',accent:'#b8d9df',fog:.10,weather:'snow',detail:'SNOWBASE'},
 {sky1:'#3a1116',sky2:'#6b4c45',ground:'#303437',accent:'#d44a4e',fog:.10,weather:'smoke',detail:'DAM'}
];

const levelStartTexts=[
 'Absturzstelle: Rauch hängt zwischen den Bäumen. Finde die Überlebenden und räume die Absturzstelle.',
 'Außenposten: Der Feind hält die Zufahrt. Brich durch und erreiche den Extraktionspunkt.',
 'Grenzgebiet: Offenes Gelände, kaum Deckung. Schalte die Patrouillen aus, bevor Verstärkung eintrifft.',
 'Stadt bei Nacht: Straßenlaternen und nasser Asphalt verraten jede Bewegung. Sichere den Block.',
 'Industriekomplex: Maschinenlärm überdeckt Schüsse. Zerstöre das markierte Ziel und verschwinde.',
 'Hafen: Container, Regen und Nebel machen den Sektor unübersichtlich. Halte dich in Bewegung.',
 'Wüstenstation: Die Hitze flimmert über dem Sand. Durchquere die Station und beseitige den Widerstand.',
 'Geheime Basis: Beton, Stahltüren und Alarmleuchten. Niemand darf den Sektor verlassen.',
 'Flughafen: Eine feindliche Operation läuft an. Stoppe das Hauptziel zwischen Hangars und Rollfeld.',
 'Bergpass: Kalter Wind und schlechte Sicht. Nutze die Felsen und erreiche die sichere Route.',
 'Regenwald: Dichte Vegetation und Dauerregen verschlucken Geräusche. Eliminiere die Einheit.',
 'Tunnelanlage: Enge Korridore, schwaches Licht. Jeder Schritt kann einen Alarm auslösen.',
 'Verlassene Stadt: Leere Straßen, zerstörte Fassaden und feindliche Schützen. Räume das Gebiet.',
 'Militärkonvoi: Der Konvoi steht bereit. Finde das Ziel und zerstöre es, bevor er abfährt.',
 'Forschungsanlage: Hinter Glas und Stahl liegen die Daten. Sichere die Anlage.',
 'Nachtoperation: Fast völlige Dunkelheit. Bleib ruhig, nutze Deckung und erreiche die Extraktion.',
 'Lagerhäuser: Container und Hallen bilden ein Labyrinth. Schalte die Wachen aus.',
 'Grenzposten: Der Pass wird schwer bewacht. Sichere den Sektor und halte die Linie.',
 'Geheime Startbahn: Feindliche Maschinen stehen bereit. Zerstöre das Hauptziel.',
 'BLACKLIST: Das Kommandozentrum ist nah. Durchbrich die äußere Sicherung und dringe weiter vor.',
 'Operation ECHO: Das Ziel versteckt sich im Regenwald. Keine Zeugen zurücklassen.',
 'Operation GHOST: Dunkelheit und Regen sind deine Deckung. Sichere den Sektor.',
 'Operation IRON: Der Kern der feindlichen Infrastruktur liegt vor dir. Zerstöre das Hauptziel.',
 'Operation ZERO: Alle Wege führen zur Extraktion. Halte durch und erreiche den Abholpunkt.',
 'BLACKLIST FINAL: Letzter Einsatz. Das Kommando muss fallen. Danach endet die Jagd.',
 'SKYFALL: Steig in den Hubschrauber ein. Der Einsatz beginnt über dem Zielgebiet.',
 'FREEFALL: Spring ab und lande auf dem Frachtschiff. Keine Ausrüstung darf verloren gehen.',
 'CARGO RAID: Kämpfe dich über das Containerdeck und sichere das Frachtschiff.',
 'RUNWAY: Erreiche die Startbahn. Das Fahrzeug bringt Zero direkt an das feindliche Flugzeug.',
 'LAST FLIGHT: Dringe in das Flugzeug ein, zerstöre das Ziel und springe im letzten Moment ab.',
 'GHOST TRAIN: Ein schwer bewachter Hochgeschwindigkeitszug rast durch den Untergrund. Sichere den Zug und erreiche den Ausgang.',
 'BLACK ICE: Schneesturm, Eis und Elitewachen. Zero muss den Bergkomplex sichern, bevor Verstärkung eintrifft.',
 'RED HORIZON: Ein gewaltiger Staudamm versorgt die feindliche Anlage. Zerstöre den Energiekern.'
];

const levelEndTexts=[
 'Die Absturzstelle ist unter Kontrolle. Zero zieht sich mit den geborgenen Daten zurück.',
 'Der Außenposten schweigt. Die Extraktion kann beginnen.',
 'Die Grenzlinie ist frei. Feindliche Patrouillen wurden ausgeschaltet.',
 'Die Stadt ist gesichert. Im Regen bleibt nur das Echo der letzten Schüsse.',
 'Das Ziel wurde zerstört. Der Industriekomplex verliert seine kritische Infrastruktur.',
 'Der Hafen ist unter Kontrolle. Zero verschwindet zwischen den Containern.',
 'Die Wüstenstation ist gefallen. Die Hitze wird bald alle Spuren verwischen.',
 'Die geheime Basis ist gesichert. Keine verwertbaren Daten bleiben beim Feind.',
 'Die Operation am Flughafen ist beendet. Das Hauptziel ist ausgeschaltet.',
 'Der Bergpass ist frei. Zero erreicht die sichere Route.',
 'Die feindliche Einheit im Regenwald ist ausgeschaltet. Der Sektor gehört wieder dir.',
 'Die Tunnelanlage ist gesichert. Die letzten Alarmlichter gehen aus.',
 'Die verlassene Stadt ist ruhig. Kein Gegner kontrolliert mehr den Block.',
 'Der Militärkonvoi ist gestoppt. Das Ziel liegt in Trümmern.',
 'Die Forschungsanlage ist gesichert. Die Daten sind auf Zero übertragen.',
 'Die Nachtoperation war erfolgreich. Die Extraktion wartet bereits.',
 'Die Lagerhäuser sind sauber. Zero verlässt den Sektor durch die Hinterzufahrt.',
 'Der Grenzposten ist gefallen. Der Weg durch die Berge ist offen.',
 'Die geheime Startbahn ist unbrauchbar. Die feindliche Operation endet hier.',
 'Das BLACKLIST-Kommandozentrum ist in Reichweite. Der äußere Ring ist gefallen.',
 'Operation ECHO ist abgeschlossen. Das Echo verstummt im Dschungel.',
 'Operation GHOST ist abgeschlossen. Niemand hat Zero kommen sehen.',
 'Operation IRON ist beendet. Die Infrastruktur des Feindes bricht zusammen.',
 'Operation ZERO ist erfolgreich. Die Extraktion ist erreicht.',
 'BLACKLIST FINAL: Das Kommando ist ausgeschaltet. Zero hat die Mission beendet.',
 'SKYFALL: Zero erreicht den Hubschrauber. Der nächste Sprung führt direkt in die feindliche Zone.',
 'FREEFALL: Der Fallschirm öffnet sich. Unter Zero liegt ein riesiges Frachtschiff im dunklen Meer.',
 'CARGO RAID: Das Frachtschiff ist gesichert. Zero erreicht das Fahrzeug für den letzten Vorstoß.',
 'RUNWAY: Zero rast über die Startbahn und springt mit dem Wagen auf das feindliche Flugzeug.',
 'LAST FLIGHT: Das Flugzeug wird zerstört. Zero springt im letzten Moment heraus – der Fallschirm öffnet sich. KAPITEL 1 IST BEENDET.',
 'GHOST TRAIN: Der Zug ist gesichert. Zero verschwindet im Tunnel, bevor die nächste Patrouille eintrifft.',
 'BLACK ICE: Die Eliteeinheit ist ausgeschaltet. Der Bergkomplex gehört wieder dir.',
 'RED HORIZON: Der Energiekern ist zerstört. Das rote Leuchten des Damms erlischt.'
];


/* Zusätzliche Themes für Level 34–500. */
for(let i=levelThemes.length;i<missions.length;i++){
  const env=missions[i][2];
  const presets={
    CITY:{sky1:'#080d16',sky2:'#26313c',ground:'#242a2e',accent:'#5e86a7',fog:.04,weather:'rain',detail:'CITY'},
    NIGHT:{sky1:'#03060b',sky2:'#18232d',ground:'#1a2126',accent:'#6888a4',fog:.05,weather:'rain',detail:'NIGHT'},
    FACTORY:{sky1:'#171d20',sky2:'#4b5758',ground:'#303638',accent:'#c17a4c',fog:.12,weather:'smoke',detail:'FACTORY'},
    HARBOR:{sky1:'#06111a',sky2:'#29434a',ground:'#293333',accent:'#5c9fa9',fog:.09,weather:'rain',detail:'HARBOR'},
    BASE:{sky1:'#0b1115',sky2:'#344148',ground:'#283235',accent:'#71858d',fog:.12,weather:'smoke',detail:'BASE'},
    AIRPORT:{sky1:'#111923',sky2:'#56656c',ground:'#303638',accent:'#7f9eb0',fog:.07,weather:'rain',detail:'AIRPORT'},
    MOUNTAIN:{sky1:'#223641',sky2:'#6f8088',ground:'#394743',accent:'#7ca6b8',fog:.08,weather:'snow',detail:'MOUNTAIN'},
    JUNGLE:{sky1:'#102c21',sky2:'#557765',ground:'#2b4035',accent:'#69a77b',fog:.14,weather:'rain',detail:'JUNGLE'},
    DESERT:{sky1:'#756b58',sky2:'#ad966f',ground:'#705d47',accent:'#d1a45c',fog:.04,weather:'dust',detail:'DESERT'}
  };
  levelThemes.push(presets[env]||presets.CITY);
}
for(let i=levelStartTexts.length;i<missions.length;i++){
  const m=missions[i];
  levelStartTexts.push(`Level ${m[0]}: ${m[1]}. Der Einsatz beginnt. ${m[3]}.`);
}
for(let i=levelEndTexts.length;i<missions.length;i++){
  const m=missions[i];
  levelEndTexts.push(`Level ${m[0]} ist abgeschlossen. ${m[1]} ist unter Kontrolle. Der nächste Einsatz wird freigeschaltet.`);
}


/* =========================================================
   GAME STATE
========================================================= */

let unlocked=Math.max(1,parseInt(localStorage.getItem("blacklistMobileUnlocked")||"1",10));

let currentLevel=0;

let gameRunning=false;
let paused=false;
let won=false;

let world={
  width:7000
};

let camera={
  x:0,
  shake:0
};

let player;
let enemies=[];
let pendingEnemies=[];
let bullets=[];
let enemyBullets=[];
let particles=[];
let props=[];

let target=null;
let extractX=0;

let flash=0;
let alertTimeout;


/* =========================================================
   RANDOM
========================================================= */

function rand(a,b){
  return Math.random()*(b-a)+a;
}

function randi(a,b){
  return Math.floor(
    rand(a,b+1)
  );
}

function clamp(v,a,b){
  return Math.max(
    a,
    Math.min(b,v)
  );
}


/* =========================================================
   WEAPONS / SHOP
========================================================= */
const weaponCatalog={
  PISTOLE:{name:"PISTOLE",cost:0,req:1,mag:12,reserve:96,damage:38,cooldown:.23,speed:1350,pellets:1,spread:.010,desc:"Dienstpistole. Ausgewogen, präzise und zuverlässig."},
  VECTOR:{name:"VECTOR",cost:650,req:2,mag:36,reserve:180,damage:24,cooldown:.075,speed:1500,pellets:1,spread:.042,desc:"Schnelle Maschinenpistole für kurze bis mittlere Distanz."},
  RAVEN:{name:"RAVEN",cost:950,req:3,mag:14,reserve:84,damage:58,cooldown:.27,speed:1450,pellets:1,spread:.014,desc:"Präzisionspistole mit starkem Einzelschuss."},
  BREACH:{name:"BREACH",cost:1200,req:4,mag:8,reserve:48,damage:27,cooldown:.50,speed:1120,pellets:7,spread:.17,desc:"Taktische Schrotflinte. Brutal auf kurze Distanz."},
  PHANTOM:{name:"PHANTOM",cost:1800,req:5,mag:24,reserve:144,damage:43,cooldown:.105,speed:1580,pellets:1,spread:.022,desc:"Stabiler taktischer Allrounder mit hoher Feuerrate."},
  SPECTRE:{name:"SPECTRE",cost:2400,req:7,mag:32,reserve:192,damage:32,cooldown:.085,speed:1680,pellets:1,spread:.014,desc:"Leise Spezial-MP mit sehr guter Kontrolle."},
  FALCON:{name:"FALCON",cost:2900,req:9,mag:15,reserve:90,damage:66,cooldown:.23,speed:1550,pellets:1,spread:.009,desc:"Schwere Agentenpistole für präzise harte Treffer."},
  NIGHTFALL:{name:"NIGHTFALL",cost:3600,req:12,mag:10,reserve:50,damage:88,cooldown:.58,speed:2200,pellets:1,spread:.004,desc:"Präzisionsgewehr für große Distanzen."},
  VANGUARD:{name:"VANGUARD",cost:4300,req:14,mag:30,reserve:180,damage:47,cooldown:.13,speed:1850,pellets:1,spread:.018,desc:"Modulares Sturmgewehr mit starkem Mittelstreckenprofil."},
  SHADOW:{name:"SHADOW",cost:5100,req:17,mag:20,reserve:120,damage:72,cooldown:.31,speed:2050,pellets:1,spread:.007,desc:"Gedämpftes Agentengewehr mit hoher Präzision und kontrolliertem Rückstoß."},
  HAMMER:{name:"HAMMER",cost:5900,req:20,mag:6,reserve:42,damage:34,cooldown:.62,speed:1250,pellets:9,spread:.20,desc:"Schwere Breach-Schrotflinte. Maximale Wirkung auf kurze Distanz."},
  FURY:{name:"FURY",cost:6800,req:22,mag:18,reserve:108,damage:52,cooldown:.12,speed:1950,pellets:1,spread:.012,desc:"Spezialkarabiner mit aggressiver Kadenz und verstärkter Munition.",special:true},
  VOLT:{name:"VOLT",cost:8200,req:25,mag:8,reserve:56,damage:95,cooldown:.42,speed:2300,pellets:1,spread:.005,desc:"Elektro-Präzisionswaffe. Treffer erzeugen einen kurzen Schockimpuls.",special:true,shock:true},
  TITAN:{name:"TITAN",cost:10500,req:30,mag:5,reserve:30,damage:130,cooldown:.82,speed:1500,pellets:1,spread:.008,desc:"Experimenteller Spezialwerfer mit explosiver Aufschlagmunition.",special:true,explosive:95},
  RAILGUN:{name:"RAILGUN",cost:12000,req:30,mag:5,reserve:25,damage:180,cooldown:1.15,speed:3200,pellets:1,spread:.001,desc:"Experimentelle Energie-Präzisionswaffe mit leuchtendem Cyan-Kern und extrem hoher Durchschlagskraft.",special:true,railgun:true},
  "D-WOLF":{name:"D-WOLF",cost:9000,req:25,mag:30,reserve:150,damage:17,cooldown:.20,speed:1980,pellets:1,spread:.018,desc:"Exklusives Sturmgewehr im D-WOLF-Setup. Startet bewusst schwächer mit 17 Schaden und wird durch Upgrades stärker.",special:true,dwolf:true},
  CERBERUS:{name:"CERBERUS",cost:13500,req:40,mag:24,reserve:168,damage:78,cooldown:.105,speed:2100,pellets:1,spread:.012,desc:"Elite-Karabiner mit aggressiver Kadenz und schwerer Munition.",special:true},
  NOVA:{name:"NOVA",cost:16500,req:55,mag:10,reserve:70,damage:115,cooldown:.40,speed:2450,pellets:1,spread:.004,desc:"Hochpräzise Spezialwaffe für harte Einzelziele.",special:true},
  APEX:{name:"APEX",cost:22000,req:75,mag:36,reserve:216,damage:62,cooldown:.075,speed:2200,pellets:1,spread:.010,desc:"Fortgeschrittenes Sturmgewehr für Endgame-Einsätze.",special:true},
  TEMPEST:{name:"TEMPEST",cost:30000,req:100,mag:12,reserve:96,damage:145,cooldown:.26,speed:2800,pellets:1,spread:.003,desc:"Experimentelles Präzisionssystem für extreme Reichweite.",special:true},
  FAUSTE:{name:"FÄUSTE",cost:100,req:1,mag:0,reserve:0,damage:999,cooldown:.38,speed:0,pellets:1,spread:0,desc:"Nahkampf. Schnelle Schläge und zufällige Finisher.",melee:true},
  SPEER:{name:"SPEER",cost:1800,req:3,mag:0,reserve:0,damage:999,cooldown:.55,speed:0,pellets:1,spread:0,desc:"Lange Reichweite mit Stößen, Sweeps und Dreh-Finishern.",melee:true},
  KATANA:{name:"KATANA",cost:3200,req:8,mag:0,reserve:0,damage:999,cooldown:.52,speed:0,pellets:1,spread:0,desc:"Schnelle Klingenwaffe mit wechselnden Hieb-Animationen.",melee:true},
  MESSER:{name:"MESSER",cost:2400,req:5,mag:0,reserve:0,damage:999,cooldown:.44,speed:0,pellets:1,spread:0,desc:"Kompakter Nahkampf mit schnellen Richtungswechseln.",melee:true},
  SCHWERT:{name:"SCHWERT",cost:4600,req:12,mag:0,reserve:0,damage:999,cooldown:.62,speed:0,pellets:1,spread:0,desc:"Schwere Klinge mit breiten und kraftvollen Finishern.",melee:true},
  STAB:{name:"STAB",cost:2900,req:6,mag:0,reserve:0,damage:999,cooldown:.50,speed:0,pellets:1,spread:0,desc:"Taktischer Stab mit Drehungen, Sweeps und Stößen.",melee:true}
};
const outfitCatalog={
  TACTICAL:{name:"TACTICAL",cost:0,desc:"Klassischer schwarzer Agentenanzug."},
  GHOST:{name:"GHOST",cost:900,desc:"Dunkles Stealth-Outfit mit Kapuze."},
  EXECUTIVE:{name:"EXECUTIVE",cost:1300,desc:"Eleganter schwarzer Anzug für Undercover-Einsätze."},
  URBAN:{name:"URBAN",cost:1700,desc:"Graues Urban-Tactical-Outfit mit Schutzweste."},
  DESERT:{name:"DESERT",cost:2200,desc:"Staubfarbenes Einsatzoutfit für Wüsten- und Außenmissionen."},
  RECON:{name:"RECON",cost:2800,desc:"Leichtes Aufklärer-Setup mit dunklem Tarnmuster."},
  BLACKOPS:{name:"BLACKOPS",cost:3600,desc:"Schweres Spezialkräfte-Outfit mit markanter Panzerung."},
  JICKENWINGPRIME:{name:"JICKEN WING PRIME",cost:1000,desc:"Community-Skin: markante braune Jacke mit goldenen Prime-Akzenten und exklusivem Wing-Emblem."},
  DEVILMARKER:{name:"DEVIL MARKER",cost:1000,desc:"Community-Skin: schwarzer Street-Look mit roten Devil-Akzenten und markantem Marker-Emblem."},
  "D-WOLF":{name:"D-WOLF",cost:4500,desc:"Exklusiver Operator-Skin nach der Vorlage: sandfarbenes Combat-Set, schwere Weste, Helm und taktische Schutzbrille."},
  DIAMONDREACTIVE:{name:"REAKTIVER DIAMANT",cost:0,desc:"LEVEL 1000 · Krönender Charakter-Skin mit leuchtender, reaktiver Diamant-Optik.",secret:true,diamond:true},
  NEONRAID:{name:"NEON RAID",cost:5200,desc:"Schwarz-graues Urban-Set mit cyanfarbenen Einsatzmarkierungen."},
  FROSTGUARD:{name:"FROSTGUARD",cost:6200,desc:"Winterrüstung mit heller Schutzschicht und schwerer Weste."},
  NIGHTVIPER:{name:"NIGHT VIPER",cost:7600,desc:"Dunkles Nacht-Setup für verdeckte Operationen."},
  REDSENTINEL:{name:"RED SENTINEL",cost:8800,desc:"Schwere schwarze Rüstung mit roten Warnakzenten."},
  GOLDFANG:{name:"GOLD FANG",cost:12000,desc:"Elite-Outfit mit goldenen Details und schwarzer Panzerung."},
  PHANTOMZERO:{name:"PHANTOM ZERO",cost:15000,desc:"Experimentelles Stealth-Setup für fortgeschrittene Agenten."},
  STORMBREAKER:{name:"STORMBREAKER",cost:19000,desc:"Schwere Sturmrüstung mit markanten Schulterplatten."},
  HAZARD:{name:"HAZARD",cost:24000,desc:"Gefahrenzone-Set mit technischen Warnmarkierungen."},
  APEXZERO:{name:"APEX ZERO",cost:32000,desc:"Endgame-Operator-Set für die höchsten Einsätze."}
};
const weaponSkinCatalog={
  STANDARD:{name:"STANDARD",cost:0,desc:"Originale Werkslackierung.",color:"#667074"},
  OBSIDIAN:{name:"OBSIDIAN",cost:450,desc:"Mattschwarze Stealth-Lackierung.",color:"#15191b"},
  REDLINE:{name:"REDLINE",cost:700,desc:"Schwarze Lackierung mit roter Akzentlinie.",color:"#a83238"},
  ARCTIC:{name:"ARCTIC",cost:850,desc:"Helle taktische Winterlackierung.",color:"#aeb8ba"},
  GOLD:{name:"GOLD",cost:1500,desc:"Exklusive goldene Sonderlackierung.",color:"#b89445"},
  GHOST:{name:"GHOST",cost:1100,desc:"Gedämpfte graue Spezialbeschichtung.",color:"#46545a"},
  CARBON:{name:"CARBON",cost:1350,desc:"Dunkle Carbon-Optik mit technischer Struktur.",color:"#293238"},
  TOXIC:{name:"TOXIC",cost:1750,desc:"Dunkles Grün mit aggressivem Spezialakzent.",color:"#5d8a52"},
  COBALT:{name:"COBALT",cost:1950,desc:"Kühle blau-graue Speziallackierung.",color:"#3d6178"},
  CRIMSON:{name:"CRIMSON",cost:2300,desc:"Tiefe rote Sonderlackierung für Elite-Einsätze.",color:"#762c34"},
  SHADOWGRID:{name:"SHADOWGRID",cost:0,desc:"GEHEIM · Tarnung aus dem Levelsystem.",color:"#263038",secret:true},
  NIGHTCORE:{name:"NIGHTCORE",cost:0,desc:"GEHEIM · Dunkle reaktive Level-Tarnung.",color:"#161d22",secret:true},
  VOLT:{name:"VOLT",cost:0,desc:"GEHEIM · Elektrische Akzent-Tarnung.",color:"#3e6870",secret:true},
  PHANTOMFLUX:{name:"PHANTOM FLUX",cost:0,desc:"GEHEIM · Schimmernde Spezial-Tarnung.",color:"#48505a",secret:true},
  REDPHASE:{name:"RED PHASE",cost:0,desc:"GEHEIM · Reaktive Einsatz-Tarnung.",color:"#6d3038",secret:true},
  DIAMONDREACTIVE:{name:"REAKTIVER DIAMANT",cost:0,desc:"LEVEL 1000 · Legendäre leuchtende Diamant-Tarnung.",color:"#9be7ee",secret:true,diamond:true}
};
let ownedWeapons=(()=>{try{const a=JSON.parse(localStorage.getItem("blacklistWeapons")||"[]");return Array.isArray(a)?a.map(x=>x==="SILENT"?"PISTOLE":x).filter(x=>weaponCatalog[x]):["PISTOLE"]}catch(e){return ["PISTOLE"]}})();
if(!ownedWeapons.includes("PISTOLE"))ownedWeapons.unshift("PISTOLE");
let equippedWeapon=localStorage.getItem("blacklistEquippedWeapon")||"PISTOLE";
if(equippedWeapon==="SILENT")equippedWeapon="PISTOLE";
if(!weaponCatalog[equippedWeapon]||!ownedWeapons.includes(equippedWeapon))equippedWeapon="PISTOLE";
let ownedOutfits=(()=>{try{const a=JSON.parse(localStorage.getItem("blacklistOutfits")||"[]");return Array.isArray(a)?a.filter(x=>outfitCatalog[x]):["TACTICAL"]}catch(e){return ["TACTICAL"]}})();
if(!ownedOutfits.includes("TACTICAL"))ownedOutfits.unshift("TACTICAL");
/* V25.6.46: Community-Skins sauber auf Kaufstatus umstellen.
   Alte Gratis-Freischaltungen aus den vorherigen Versionen werden entfernt,
   damit JICKEN WING PRIME und DEVIL MARKER wirklich für $1000 gekauft werden müssen. */
let communityPaidSkins=(()=>{
  try{const a=JSON.parse(localStorage.getItem("blacklistCommunityPaidSkins")||"[]");return Array.isArray(a)?a.filter(x=>x==="JICKENWINGPRIME"||x==="DEVILMARKER"):[];}catch(e){return [];}
})();
ownedOutfits=ownedOutfits.filter(id=>
  id!=="JICKENWINGPRIME"&&id!=="DEVILMARKER" || communityPaidSkins.includes(id)
);
try{localStorage.setItem("blacklistOutfits",JSON.stringify(ownedOutfits));}catch(e){}
let equippedOutfit=localStorage.getItem("blacklistEquippedOutfit")||"TACTICAL";
if(!outfitCatalog[equippedOutfit]||!ownedOutfits.includes(equippedOutfit))equippedOutfit="TACTICAL";
let ownedWeaponSkins=(()=>{try{const a=JSON.parse(localStorage.getItem("blacklistWeaponSkins")||"[]");return Array.isArray(a)?a.filter(x=>weaponSkinCatalog[x]):["STANDARD"]}catch(e){return ["STANDARD"]}})();
if(!ownedWeaponSkins.includes("STANDARD"))ownedWeaponSkins.unshift("STANDARD");
let equippedWeaponSkin=localStorage.getItem("blacklistEquippedWeaponSkin")||"STANDARD";
if(!weaponSkinCatalog[equippedWeaponSkin]||!ownedWeaponSkins.includes(equippedWeaponSkin))equippedWeaponSkin="STANDARD";
let dwolfUpgrades=(()=>{try{const a=JSON.parse(localStorage.getItem("blacklistDWolfUpgrades")||"{}");return {damage:Math.min(10,Math.max(0,a.damage|0)),ammo:Math.min(10,Math.max(0,a.ammo|0)),rate:Math.min(10,Math.max(0,a.rate|0))}}catch(e){return {damage:0,ammo:0,rate:0}}})();
let credits=parseInt(localStorage.getItem("blacklistCredits")||"0",10); if(!Number.isFinite(credits)||credits<0)credits=0;
let playerXP=parseInt(localStorage.getItem("blacklistXP")||"0",10); if(!Number.isFinite(playerXP)||playerXP<0)playerXP=0;
function xpForLevel(l){return 250+(l-1)*125;}
function xpSpentBeforeLevel(l){const n=Math.max(0,l-1);return n*(2*250+125*(n-1))/2;}
function getRankLevel(){let lvl=1;while(lvl<1000 && playerXP>=xpSpentBeforeLevel(lvl+1))lvl++;return lvl;}
const rankNames=["REKRUT","GEFREITER","OBERGEFREITER","STABSGEFREITER","UNTEROFFIZIER","FELDWEBEL","OBERFELDWEBEL","HAUPTFELDWEBEL","STABSFELDWEBEL","LEUTNANT","OBERLEUTNANT","HAUPTMANN","MAJOR","OBERSTLEUTNANT","OBERST","BRIGADEGENERAL","GENERALMAJOR","GENERALLEUTNANT","GENERAL","GENERALOBERST","GENERALFELDMARSCHALL"];
function getRankName(lvl){return rankNames[Math.min(rankNames.length-1,Math.floor((Math.max(1,lvl)-1)/50))];}
function getEnemyScale(){const lvl=getRankLevel();return {hp:1+(lvl-1)*.0025,damage:1+(lvl-1)*.0015,speed:1+(lvl-1)*.0007,vision:1+(lvl-1)*.0004};}
const secretSkinRewards=["SHADOWGRID","NIGHTCORE","VOLT","PHANTOMFLUX","REDPHASE"];
function grantLevelReward(level){
  if(level>=1000){
    if(!ownedWeaponSkins.includes("DIAMONDREACTIVE"))ownedWeaponSkins.push("DIAMONDREACTIVE");
    if(!ownedOutfits.includes("DIAMONDREACTIVE"))ownedOutfits.push("DIAMONDREACTIVE");
    return "REAKTIVER DIAMANT · WAFFE + CHARAKTER";
  }
  const id=secretSkinRewards[(level-1)%secretSkinRewards.length];
  if(!ownedWeaponSkins.includes(id)){ownedWeaponSkins.push(id);return weaponSkinCatalog[id].name;}
  return null;
}
function awardXP(n){
  const before=getRankLevel();
  playerXP=Math.min(Number.MAX_SAFE_INTEGER,playerXP+Math.max(0,n||0));
  const after=getRankLevel();
  localStorage.setItem("blacklistXP",String(playerXP));
  if(after>before){
    let rewards=[];
    for(let level=before+1;level<=after;level++){const reward=grantLevelReward(level);if(reward)rewards.push(reward);}
    saveLoadout();
    showAlert(after>=1000?"LEVEL 1000 · REAKTIVER DIAMANT":`LEVEL UP · LVL ${after} · ${getRankName(after)}${rewards.length?" · GEHEIMTARNUNG: "+rewards[rewards.length-1]:""}`,"green");
    zeroSpeak(after>=1000?"Level tausend. Das ist das Ende der Skala.":"Neuer Rang. Weiter geht's.",true);
  }
  updateHUD();
}
function weaponUnlocked(w){return getRankLevel()>=w.req;}

// Level = unlock requirement only. Every non-free weapon must still be purchased with credits.
function weaponCanBePurchased(w){return weaponUnlocked(w)&&!ownedWeapons.includes(w.name)&&credits>=w.cost;}

function saveLoadout(){localStorage.setItem("blacklistWeapons",JSON.stringify(ownedWeapons));localStorage.setItem("blacklistOutfits",JSON.stringify(ownedOutfits));localStorage.setItem("blacklistWeaponSkins",JSON.stringify(ownedWeaponSkins));localStorage.setItem("blacklistCredits",String(credits));localStorage.setItem("blacklistXP",String(playerXP));localStorage.setItem("blacklistDWolfUpgrades",JSON.stringify(dwolfUpgrades));localStorage.setItem("blacklistCompanions",JSON.stringify(ownedCompanions));localStorage.setItem("blacklistCompanionUpgrades",JSON.stringify(companionUpgrades));localStorage.setItem("blacklistEquippedCompanion",equippedCompanion);}
function getWeapon(){
  const base=weaponCatalog[player.weapon]||weaponCatalog.PISTOLE;
  if(!base.dwolf)return base;
  const u=dwolfUpgrades;
  return Object.assign({},base,{
    damage:base.damage+u.damage*6,
    mag:base.mag+u.ammo*3,
    reserve:base.reserve+u.ammo*18,
    cooldown:Math.max(.055,base.cooldown-u.rate*.006),
    spread:base.spread
  });
}
function awardCredits(n){credits+=n;saveLoadout();if(typeof updateHUD==="function")updateHUD();}
function buyOrEquipWeapon(id){
  const w=weaponCatalog[id]; if(!w)return;
  if(!weaponUnlocked(w)){showAlert("LEVEL "+w.req+" ERFORDERLICH","red");return;}
  if(!ownedWeapons.includes(id)){
    if(credits<w.cost){showAlert("ZU WENIG CREDITS","red");return;}
    credits-=w.cost;ownedWeapons.push(id);saveLoadout();showAlert(w.name+" FREIGESCHALTET","green");
  }
  player.weapon=id; equippedWeapon=id; localStorage.setItem("blacklistEquippedWeapon",id); player.ammo=w.mag; player.reserve=w.reserve; player.reload=0; updateHUD(); renderShop();
}
function buyOrEquipOutfit(id){
  const o=outfitCatalog[id]; if(!o)return;
  if(!ownedOutfits.includes(id)){
    const price=(id==="JICKENWINGPRIME"||id==="DEVILMARKER")?1000:o.cost;
    if(credits<price){showAlert("ZU WENIG CREDITS","red");return;}
    credits-=price;
    ownedOutfits.push(id);
    if(id==="JICKENWINGPRIME"||id==="DEVILMARKER"){
      if(!communityPaidSkins.includes(id))communityPaidSkins.push(id);
      try{localStorage.setItem("blacklistCommunityPaidSkins",JSON.stringify(communityPaidSkins));}catch(e){}
    }
    saveLoadout();
    showAlert(o.name+" GEKAUFT · $"+price,"green");
  }
  equippedOutfit=id;
  localStorage.setItem("blacklistEquippedOutfit",id);
  if(player)player.outfit=id;
  updateHUD();
  renderShop();
}

function buyOrEquipWeaponSkin(id){
  const skin=weaponSkinCatalog[id]; if(!skin)return;
  if(!ownedWeaponSkins.includes(id)){
    if(credits<skin.cost){showAlert("ZU WENIG CREDITS","red");return;}
    credits-=skin.cost; ownedWeaponSkins.push(id); saveLoadout(); showAlert(skin.name+" SKIN FREIGESCHALTET","green");
  }
  equippedWeaponSkin=id; localStorage.setItem("blacklistEquippedWeaponSkin",id); renderShop();
}

function dwolfUpgradeCost(type){
  const level=dwolfUpgrades[type]||0;
  return 1200 + level*850;
}
function upgradeDWolf(type){
  if(!weaponCatalog["D-WOLF"])return;
  if(!ownedWeapons.includes("D-WOLF")){showAlert("D-WOLF ZUERST KAUFEN","red");return;}
  if((dwolfUpgrades[type]||0)>=10){showAlert("UPGRADE MAXIMUM ERREICHT","red");return;}
  const cost=dwolfUpgradeCost(type);
  if(credits<cost){showAlert("ZU WENIG CREDITS","red");return;}
  credits-=cost;dwolfUpgrades[type]++;saveLoadout();
  if(player&&player.weapon==="D-WOLF"){const w=getWeapon();player.ammo=Math.min(w.mag,player.ammo);player.reserve=Math.min(w.reserve,player.reserve);}
  showAlert("D-WOLF UPGRADE · "+type.toUpperCase(),"green");
  updateHUD();renderShop();
}
function renderDWolfUpgrade(){
  const panel=document.getElementById("dwolfUpgradePanel");if(!panel)return;
  const owned=ownedWeapons.includes("D-WOLF"), equipped=player&&player.weapon==="D-WOLF";
  panel.style.display=(owned||equipped)?"block":"none";
  if(!owned&&!equipped)return;
  const w=getWeapon();
  const rows=[
    ["SCHADEN","damage",w.damage,"+6 SCHADEN / Stufe"],
    ["MAGAZIN / SCHUSS","ammo",w.mag,"+3 MAG · +18 RESERVE / Stufe"],
    ["FEUERRATE","rate",(60/w.cooldown).toFixed(1),"kürzere Schussverzögerung"]
  ];
  panel.innerHTML='<h3>🐺 D-WOLF // WAFFEN-UPGRADES</h3><div class="upgradeSub">Die einzige Waffe im Arsenal mit permanenten Upgrades für Schaden, Magazin und Feuerrate. Kein Rückstoß-Upgrade.</div>'+rows.map(r=>{const lv=dwolfUpgrades[r[1]]||0;const max=lv>=10;const cost=dwolfUpgradeCost(r[1]);return `<div class="upgradeRow"><div><div class="upgradeName">${r[0]}</div><div style="font-size:9px;color:#748187">${r[3]}</div></div><div class="upgradeLevel">LV ${lv}/10 · ${r[2]}</div><button ${max||credits<cost?'disabled':''} onclick="upgradeDWolf('${r[1]}')">${max?'MAX':'$'+cost}</button></div>`}).join('');
}


/* =========================================================
   V27 // ARSENAL SPECIAL AMMO
========================================================= */
const specialAmmoCatalog={
  PORTAL:{name:"🌀 PORTAL-MUNITION",cost:1800,color:"#b76cff",desc:"Beim tödlichen Treffer öffnet sich hinter dem Gegner ein Portal. Kraken-/Tentakelarme packen ihn und ziehen ihn vollständig hinein. Kein Leichnam bleibt zurück."},
  LIGHT:{name:"⚡ LICHT-MUNITION",cost:2200,color:"#e9fbff",desc:"Beim tödlichen Treffer fällt ein leuchtender Energie-Klingenstab auf den Gegner. Der Effekt verschwindet wieder, der Gegner bleibt als Ragdoll liegen."}
};
let ownedSpecialAmmo=(()=>{try{const a=JSON.parse(localStorage.getItem("blacklistSpecialAmmo")||"[]");return Array.isArray(a)?a.filter(x=>specialAmmoCatalog[x]):[]}catch(e){return[]}})();
let selectedSpecialAmmo=localStorage.getItem("blacklistSelectedSpecialAmmo")||"";
if(!specialAmmoCatalog[selectedSpecialAmmo])selectedSpecialAmmo="";
let specialEffects=[];
let meleeEffects=[];
let playerDeath={active:false,time:0};

/* =========================================================
   V27.3 // MELEE FINISHER SYSTEM
   Jede Nahkampfwaffe besitzt mehrere Finisher. Pro Treffer wird
   zufällig genau einer gewählt. Die Finisher geben dem echten
   Ragdoll unterschiedliche Impulse und eigene sichtbare Effekte.
========================================================= */
const meleeFinisherCatalog={
  FAUSTE:[
    {n:"JAB",arc:-.20,spin:-.25,kickX:120,kickY:-90,fx:"fist"},
    {n:"DOPPELSCHLAG",arc:.10,spin:.45,kickX:155,kickY:-70,fx:"double"},
    {n:"UPPERCUT",arc:-1.05,spin:.75,kickX:70,kickY:-220,fx:"upper"},
    {n:"BODYBLOW",arc:.55,spin:-.65,kickX:170,kickY:-35,fx:"impact"},
    {n:"BACKFIST",arc:-.65,spin:1.15,kickX:-130,kickY:-110,fx:"spin"},
    {n:"KNIETREFFER",arc:.25,spin:-1.0,kickX:105,kickY:-165,fx:"knee"},
    {n:"SCHUBS",arc:.0,spin:.15,kickX:220,kickY:-55,fx:"shock"}
  ],
  SPEER:[
    {n:"GERADER STOSS",arc:0,spin:.15,kickX:230,kickY:-45,fx:"thrust"},
    {n:"SEITEN-SWEEP",arc:.85,spin:1.15,kickX:155,kickY:-90,fx:"sweep"},
    {n:"AUFWÄRTSSTOSS",arc:-.8,spin:-.55,kickX:95,kickY:-210,fx:"thrustUp"},
    {n:"RÜCKHAND",arc:.55,spin:-1.0,kickX:-145,kickY:-80,fx:"sweep"},
    {n:"DREHSTOSS",arc:-1.1,spin:1.55,kickX:180,kickY:-120,fx:"spin"},
    {n:"STABKOMBO",arc:.2,spin:-.4,kickX:195,kickY:-125,fx:"combo"},
    {n:"STAFF-ENDSTOSS",arc:1.0,spin:.55,kickX:110,kickY:-150,fx:"impact"}
  ],
  KATANA:[
    {n:"DIAGONALHIEB",arc:-.75,spin:-.7,kickX:180,kickY:-100,fx:"slash"},
    {n:"QUERHIEB",arc:.15,spin:.8,kickX:205,kickY:-55,fx:"slashWide"},
    {n:"AUFWÄRTSHIEB",arc:-1.0,spin:-.45,kickX:105,kickY:-205,fx:"slashUp"},
    {n:"RÜCKHAND",arc:.75,spin:1.1,kickX:-160,kickY:-85,fx:"slash"},
    {n:"DREHKLINGE",arc:-.25,spin:1.7,kickX:190,kickY:-135,fx:"spinSlash"},
    {n:"DRAW-SLASH",arc:-.55,spin:-1.35,kickX:145,kickY:-155,fx:"draw"},
    {n:"ÜBERKOPFHIEB",arc:-1.35,spin:.35,kickX:120,kickY:-180,fx:"heavySlash"}
  ],
  MESSER:[
    {n:"SCHNELLSTICH",arc:.05,spin:.1,kickX:145,kickY:-60,fx:"stab"},
    {n:"QUERSCHNITT",arc:.55,spin:-.6,kickX:170,kickY:-75,fx:"slash"},
    {n:"RÜCKHANDSTICH",arc:-.55,spin:1.0,kickX:-125,kickY:-80,fx:"stab"},
    {n:"DOPPELSTICH",arc:.1,spin:.5,kickX:155,kickY:-125,fx:"double"},
    {n:"LOW-SLASH",arc:.9,spin:-.8,kickX:135,kickY:-25,fx:"low"},
    {n:"SPIN-MESSER",arc:-.9,spin:1.5,kickX:160,kickY:-110,fx:"spinSlash"},
    {n:"ELBOGEN + MESSER",arc:.25,spin:-1.15,kickX:185,kickY:-95,fx:"impact"}
  ],
  SCHWERT:[
    {n:"BREITHIEB",arc:.35,spin:-.65,kickX:230,kickY:-70,fx:"heavySlash"},
    {n:"ÜBERKOPF",arc:-1.4,spin:.4,kickX:145,kickY:-205,fx:"heavySlash"},
    {n:"GERADER STOSS",arc:0,spin:.2,kickX:250,kickY:-45,fx:"thrust"},
    {n:"RÜCKHAND",arc:.7,spin:1.0,kickX:-190,kickY:-85,fx:"slashWide"},
    {n:"DREH-HIEB",arc:-.5,spin:1.8,kickX:205,kickY:-130,fx:"spinSlash"},
    {n:"TIEFER SWEEP",arc:.95,spin:-1.15,kickX:175,kickY:-35,fx:"low"},
    {n:"POMMELSTOSS",arc:.15,spin:.15,kickX:155,kickY:-140,fx:"impact"}
  ],
  STAB:[
    {n:"GERADER STOSS",arc:0,spin:.1,kickX:220,kickY:-45,fx:"thrust"},
    {n:"SEITEN-SWEEP",arc:.9,spin:-1.0,kickX:165,kickY:-70,fx:"sweep"},
    {n:"DREHSTAB",arc:-.55,spin:1.6,kickX:185,kickY:-115,fx:"spin"},
    {n:"AUFWÄRTS",arc:-1.1,spin:.4,kickX:95,kickY:-200,fx:"thrustUp"},
    {n:"RÜCKHAND",arc:.65,spin:-1.35,kickX:-155,kickY:-80,fx:"sweep"},
    {n:"STAB-KOMBO",arc:.2,spin:.8,kickX:200,kickY:-125,fx:"combo"},
    {n:"WIRBEL",arc:-.8,spin:1.9,kickX:170,kickY:-105,fx:"spinSlash"}
  ]
};

function meleeWeapon(id){return !!(weaponCatalog[id]&&weaponCatalog[id].melee);}
const meleeTargetZones={
  FAUSTE:[{n:"KOPF",x:0,y:-88},{n:"BRUST",x:0,y:-52},{n:"MITTELKÖRPER",x:0,y:-30}],
  SPEER:[{n:"GESICHT",x:0,y:-88},{n:"BRUST",x:0,y:-52},{n:"BAUCH",x:0,y:-28}],
  KATANA:[{n:"SCHULTER",x:0,y:-66},{n:"BRUST",x:0,y:-48},{n:"SEITE",x:0,y:-28}],
  MESSER:[{n:"SCHULTER",x:0,y:-64},{n:"BRUST",x:0,y:-48},{n:"SEITE",x:0,y:-28}],
  SCHWERT:[{n:"OBERKÖRPER",x:0,y:-62},{n:"BRUST",x:0,y:-48},{n:"SEITE",x:0,y:-28}],
  STAB:[{n:"BRUST",x:0,y:-52},{n:"BAUCH",x:0,y:-28},{n:"BEIN",x:0,y:2}]
};
function getMeleeTarget(weapon,finisher){
  const zones=meleeTargetZones[weapon]||meleeTargetZones.FAUSTE;
  if(finisher&&finisher.target){return finisher.target;}
  return zones[randi(0,zones.length-1)];
}


function startMeleeFinisher(e,weaponName,finisher){
  if(!e||e.meleeFinisherStarted)return;
  e.meleeFinisherStarted=true;
  e.meleeFinisher=finisher;
  e.meleeWeapon=weaponName;
  e.meleeTarget=getMeleeTarget(weaponName,finisher);
  e.dead=true;
  e.hp=0;
  e.fall=1;
  e.deathDir=player.dir||1;
  e.weaponDropped=true;
  e.specialEffectStarted=true;
  e.portalHidden=false;
  e.portalizing=false;
  initRagdoll(e);
  const r=e.ragdoll;
  const kx=(player.dir||1)*finisher.kickX;
  for(const q of Object.values(r.pts)){
    q.vx+=kx+rand(-35,35);
    q.vy+=finisher.kickY+rand(-30,30);
  }
  /* unterschiedliche Gelenkreaktionen pro Finisher */
  r.pts.head.vx+=Math.sin(finisher.spin)*95;
  r.pts.head.vy-=Math.abs(finisher.spin)*30;
  r.pts.handL.vx-=finisher.spin*70;
  r.pts.handR.vx+=finisher.spin*70;
  r.pts.footL.vx-=finisher.spin*45;
  r.pts.footR.vx+=finisher.spin*45;
  e.meleeT=0;
  meleeEffects.push({type:"finisher",enemy:e,weapon:weaponName,style:finisher.fx,name:finisher.n,t:0,duration:.95,arc:finisher.arc,spin:finisher.spin});
  blacklistSfx&&blacklistSfx("death");
  awardCredits(e.type==="heavy"?90:55);
  awardXP(e.type==="heavy"?120:65);
  player.hp=Math.min(player.maxHp||100,(player.hp||0)+5);
  burst(e.x,e.y-35,"death");
  showAlert(weaponName+" · "+finisher.n,"green");
}

function performMeleeAttack(){
  const w=getWeapon();
  if(!w.melee)return;
  player.shootCd=w.cooldown;
  player.recoil=.08;
  const weapon=player.weapon;
  const list=meleeFinisherCatalog[weapon]||meleeFinisherCatalog.FAUSTE;
  let best=null,bestD=Infinity;
  for(const e of enemies){
    if(!e||e.dead||e.portalHidden)continue;
    const dx=e.x-player.x,dy=e.y-player.y;
    if(Math.abs(dy)>92)continue;
    if(dx*(player.dir||1)<-12)continue;
    const reach=weapon==="SPEER"||weapon==="STAB"?150:weapon==="SCHWERT"||weapon==="KATANA"?125:105;
    const d=Math.hypot(dx,dy);
    if(d<=reach&&d<bestD){best=e;bestD=d;}
  }
  const swing={type:"swing",weapon,dir:player.dir||1,t:0,duration:.22,arc:(rand(-.9,.9)),hit:!!best};
  meleeEffects.push(swing);
  blacklistSfx&&blacklistSfx("hit");
  if(!best)return;
  const finisher=list[randi(0,list.length-1)];
  startMeleeFinisher(best,weapon,finisher);
}

function updateMeleeEffects(dt){
  for(let i=meleeEffects.length-1;i>=0;i--){
    const fx=meleeEffects[i];
    fx.t+=dt;
    if(fx.type==="finisher"&&fx.enemy){fx.enemy.meleeT=fx.t;}
    if(fx.t>=fx.duration)meleeEffects.splice(i,1);
  }
}

function drawMeleeEffects(){
  for(const fx of meleeEffects){
    const p=Math.min(1,fx.t/fx.duration);
    const ease=p<.5?2*p*p:1-Math.pow(-2*p+2,2)/2;

    if(fx.type==="swing"){
      const x=player.x-camera.x+fx.dir*38,y=player.y-57;
      ctx.save();ctx.globalAlpha=1-p;ctx.translate(x,y);ctx.scale(fx.dir,1);
      ctx.strokeStyle=fx.weapon==="FAUSTE"?"#d6a17e":"#e9fbff";ctx.lineWidth=5;ctx.shadowBlur=16;ctx.shadowColor=ctx.strokeStyle;
      ctx.beginPath();ctx.arc(0,0,42,-1.05+fx.arc,.25+fx.arc);ctx.stroke();
      ctx.restore();
      continue;
    }

    const e=fx.enemy;if(!e)continue;
    const ex=e.x-camera.x, ey=e.y-58;
    const px=player.x-camera.x, py=player.y-58;
    const dir=player.dir||1;
    const weapon=fx.weapon;
    const fade=p<.72?1:Math.max(0,1-(p-.72)/.28);

    ctx.save();
    ctx.globalAlpha=fade;
    ctx.lineCap="round";ctx.lineJoin="round";

    /* Deutlich sichtbare Finisher-Kamera-/Impact-Linien */
    if(p<.72){
      ctx.strokeStyle="#ffffff";ctx.lineWidth=3;ctx.shadowBlur=14;ctx.shadowColor="#ffffff";
      for(let k=0;k<4;k++){
        const yy=ey-35+k*18;
        ctx.beginPath();ctx.moveTo(ex-dir*(25+k*5),yy);ctx.lineTo(ex-dir*(70+k*18),yy-(k-1.5)*8);ctx.stroke();
      }
    }

    /* Waffenanimation: eigene sichtbare Bewegung je Waffe */
    const t=ease;
    const target=e.meleeTarget||{x:0,y:-52,n:"BRUST"};
    const targetX=ex+target.x, targetY=ey+target.y;
    const sx=px+dir*(18+55*t), sy=py-4-25*t;
    const tx=targetX-dir*(18-12*t), ty=targetY-10*Math.sin(t*Math.PI);
    const ang=Math.atan2(ty-sy,tx-sx);

    ctx.save();
    ctx.translate(sx,sy);
    ctx.rotate(ang);
    ctx.scale(dir,1);
    ctx.shadowBlur=18;ctx.shadowColor="#e9fbff";

    if(weapon==="FAUSTE"){
      ctx.fillStyle="#d6a17e";ctx.strokeStyle="#fff1e6";ctx.lineWidth=2;
      ctx.beginPath();ctx.arc(0,0,12,0,Math.PI*2);ctx.fill();ctx.stroke();
      ctx.beginPath();ctx.arc(24,-10,11,0,Math.PI*2);ctx.fill();ctx.stroke();
      ctx.strokeStyle="#ffd9b8";ctx.lineWidth=4;ctx.beginPath();ctx.moveTo(-8,0);ctx.lineTo(34,-10);ctx.stroke();
    }else if(weapon==="SPEER"){
      ctx.strokeStyle="#d9dfe3";ctx.lineWidth=7;ctx.beginPath();ctx.moveTo(-72,8);ctx.lineTo(72,-8);ctx.stroke();
      ctx.fillStyle="#e9fbff";ctx.beginPath();ctx.moveTo(72,-8);ctx.lineTo(48,-19);ctx.lineTo(48,3);ctx.closePath();ctx.fill();
      ctx.fillStyle="#b7c1c5";ctx.fillRect(45,-11,7,6);
    }else if(weapon==="STAB"){
      ctx.strokeStyle="#8f6b4a";ctx.lineWidth=7;ctx.beginPath();ctx.moveTo(-62,8);ctx.lineTo(68,-8);ctx.stroke();
      ctx.fillStyle="#c9d1d4";ctx.beginPath();ctx.moveTo(68,-8);ctx.lineTo(48,-16);ctx.lineTo(48,0);ctx.closePath();ctx.fill();
    }else if(weapon==="MESSER"){
      ctx.strokeStyle="#dfe9ed";ctx.lineWidth=6;ctx.beginPath();ctx.moveTo(-12,8);ctx.lineTo(58,-16);ctx.stroke();
      ctx.strokeStyle="#2d3437";ctx.lineWidth=9;ctx.beginPath();ctx.moveTo(-25,13);ctx.lineTo(-5,7);ctx.stroke();
    }else if(weapon==="KATANA"){
      ctx.strokeStyle="#f4fbff";ctx.lineWidth=7;ctx.beginPath();ctx.moveTo(-18,12);ctx.lineTo(82,-20);ctx.stroke();
      ctx.strokeStyle="#7e542f";ctx.lineWidth=9;ctx.beginPath();ctx.moveTo(-38,16);ctx.lineTo(-17,11);ctx.stroke();
    }else if(weapon==="SCHWERT"){
      ctx.strokeStyle="#e8f5fa";ctx.lineWidth=12;ctx.beginPath();ctx.moveTo(-20,14);ctx.lineTo(86,-14);ctx.stroke();
      ctx.strokeStyle="#aeb8bd";ctx.lineWidth=4;ctx.beginPath();ctx.moveTo(-28,7);ctx.lineTo(-8,16);ctx.stroke();
    }
    ctx.restore();

    /* Finisher-spezifische Bewegungsbahn */
    ctx.strokeStyle="#dff7ff";ctx.lineWidth=4;ctx.shadowBlur=20;ctx.shadowColor="#8eeeff";
    const sweep=fx.arc+(t-.5)*fx.spin*2;
    ctx.beginPath();
    if(fx.style==="thrust"||fx.style==="thrustUp"||fx.style==="stab"){
      ctx.moveTo(px+dir*25,py);ctx.lineTo(targetX,targetY);
    }else if(fx.style==="spin"||fx.style==="spinSlash"){
      ctx.arc(ex,ey,58,sweep-1.55,sweep+1.55);
    }else if(fx.style==="low"){
      ctx.arc(ex,ey+24,62,-.15,Math.PI+.35);
    }else if(fx.style==="upper"||fx.style==="slashUp"){
      ctx.arc(ex,ey,60,-2.2,-.15);
    }else if(fx.style==="sweep"||fx.style==="slashWide"){
      ctx.arc(ex,ey,66,sweep-1.0,sweep+1.0);
    }else{
      ctx.arc(ex,ey,62,sweep-.9,sweep+.9);
    }
    ctx.stroke();

    /* Trefferblitz + Ring */
    if(p>.35&&p<.82){
      const q=(p-.35)/.47;
      ctx.globalAlpha=fade*(1-q);
      ctx.strokeStyle="#ffffff";ctx.lineWidth=5;
      ctx.beginPath();ctx.arc(ex,ey,12+q*48,0,Math.PI*2);ctx.stroke();
      for(let k=0;k<8;k++){
        const a=k*Math.PI/4;
        ctx.beginPath();ctx.moveTo(ex+Math.cos(a)*12,ey+Math.sin(a)*12);ctx.lineTo(ex+Math.cos(a)*(35+q*35),ey+Math.sin(a)*(35+q*35));ctx.stroke();
      }
    }

    ctx.restore();

    /* Finisher-Name sichtbar anzeigen */
    if(p<.78){
      ctx.save();
      ctx.globalAlpha=fade;
      ctx.textAlign="center";
      ctx.font="900 12px Arial";
      ctx.fillStyle="#ffffff";
      ctx.shadowBlur=12;ctx.shadowColor="#000";
      ctx.fillText(weapon+" · "+(fx.name||"FINISHER")+(e.meleeTarget?" · "+e.meleeTarget.n:""),ex,ey-82-18*Math.sin(p*Math.PI));
      ctx.restore();
    }
  }
}
function saveSpecialAmmo(){localStorage.setItem("blacklistSpecialAmmo",JSON.stringify(ownedSpecialAmmo));localStorage.setItem("blacklistSelectedSpecialAmmo",selectedSpecialAmmo||"");}
function buyOrSelectSpecialAmmo(id){
  const a=specialAmmoCatalog[id]; if(!a)return;
  if(selectedSpecialAmmo===id){
    selectedSpecialAmmo="";
    saveSpecialAmmo();
    showAlert("SPEZIAL-MUNITION ABGELEGT","green");
    renderShop();
    return;
  }
  if(!ownedSpecialAmmo.includes(id)){
    if(credits<a.cost){showAlert("ZU WENIG CREDITS","red");return;}
    credits-=a.cost; ownedSpecialAmmo.push(id);
    showAlert(a.name+" FREIGESCHALTET","green");
  }
  selectedSpecialAmmo=id; saveSpecialAmmo(); renderShop();
}
function renderArsenal(){
  const host=document.getElementById("specialAmmoGrid"); if(!host)return;
  host.innerHTML="";
  Object.entries(specialAmmoCatalog).forEach(([id,a])=>{
    const owned=ownedSpecialAmmo.includes(id), selected=selectedSpecialAmmo===id;
    const card=document.createElement("div"); card.className="specialCard"+(selected?" selected":"");
    card.innerHTML=`<div class="specialName">${a.name}</div><div class="specialMeta">${a.desc}<br><b style="color:${a.color}">STATUS: ${selected?"AKTIV":owned?"IM BESITZ":"PREIS: $"+a.cost}</b></div>`;
    const b=document.createElement("button");
    b.textContent=selected?"ABLEGEN":owned?"AUSRÜSTEN":"KAUFEN · $"+a.cost;
    b.disabled=!owned&&credits<a.cost;
    b.onclick=()=>buyOrSelectSpecialAmmo(id);
    card.appendChild(b); host.appendChild(card);
  });
}
/* =========================================================
   V27.1 // ECHTES 2D-RAGDOLL + PORTAL-CLEANUP
   Gelenkbasierte Physik statt einer einzigen gedrehten Todesfigur.
========================================================= */
function initRagdoll(e){
  if(!e)return;
  const x=e.x, y=e.y;
  const pts={
    head:{x:x,y:y-96,vx:0,vy:-45}, neck:{x:x,y:y-79,vx:0,vy:-20},
    shL:{x:x-17,y:y-69,vx:0,vy:0}, elL:{x:x-35,y:y-49,vx:0,vy:0}, handL:{x:x-54,y:y-38,vx:0,vy:0},
    shR:{x:x+17,y:y-69,vx:0,vy:0}, elR:{x:x+35,y:y-49,vx:0,vy:0}, handR:{x:x+54,y:y-38,vx:0,vy:0},
    hipL:{x:x-12,y:y-34,vx:0,vy:0}, kneeL:{x:x-19,y:y-8,vx:0,vy:0}, footL:{x:x-34,y:y+9,vx:0,vy:0},
    hipR:{x:x+12,y:y-34,vx:0,vy:0}, kneeR:{x:x+19,y:y-8,vx:0,vy:0}, footR:{x:x+34,y:y+9,vx:0,vy:0}
  };
  const kick=(e.deathDir||1)*(70+Math.random()*75);
  Object.values(pts).forEach((q,idx)=>{
    q.vx=kick+rand(-35,35);
    q.vy=rand(-75,25)+(idx%3)*7;
  });
  const bonePairs=[
    ["head","neck"],["neck","shL"],["neck","shR"],["shL","elL"],["elL","handL"],["shR","elR"],["elR","handR"],
    ["shL","hipL"],["shR","hipR"],["hipL","hipR"],["hipL","kneeL"],["kneeL","footL"],["hipR","kneeR"],["kneeR","footR"]
  ];
  const bones=bonePairs.map(([a,b])=>({a,b,len:Math.hypot(pts[a].x-pts[b].x,pts[a].y-pts[b].y)}));
  e.ragdoll={pts,bones,age:0,ground:y+10};
  e.ragdollProgress=0;
}
function updateRagdoll(e,dt){
  const r=e&&e.ragdoll;if(!r)return;
  r.age+=dt;
  const g=760;
  const damp=Math.pow(.985,dt*60);
  for(const q of Object.values(r.pts)){
    q.vy+=g*dt;
    q.vx*=damp; q.vy*=damp;
    q.x+=q.vx*dt; q.y+=q.vy*dt;
    if(q.y>r.ground){q.y=r.ground; if(q.vy>0)q.vy*=-.16; q.vx*=.82;}
  }
  for(let pass=0;pass<7;pass++){
    for(const b of r.bones){
      const a=r.pts[b.a],c=r.pts[b.b];
      let dx=c.x-a.x,dy=c.y-a.y,d=Math.hypot(dx,dy)||.001;
      const err=(d-b.len)/d;
      const ax=dx*err*.5, ay=dy*err*.5;
      a.x+=ax; a.y+=ay; c.x-=ax; c.y-=ay;
    }
    for(const q of Object.values(r.pts)) if(q.y>r.ground)q.y=r.ground;
  }
}
function specialKillStart(type,e){
  if(!type||!e||e.specialEffectStarted)return;
  e.specialEffectStarted=true;
  e.specialType=type;
  e.specialT=0;
  e.weaponDropped=true;
  e.portalHidden=false;
  e.portalizing=type==="PORTAL";
  e.specialAlpha=1;
  e.specialPull=0;
  /* Wichtig: Spezial-Effekte dürfen den normalen Spielzustand NICHT pausieren. */
  paused=false;
  initRagdoll(e);
  if(type==="PORTAL"){
    specialEffects.push({
      type:"portal", enemy:e,
      x:e.x+(e.deathDir||1)*18, y:e.y-52,
      t:0, duration:1.55, dir:e.deathDir||1
    });
  }else if(type==="LIGHT"){
    specialEffects.push({
      type:"light", enemy:e,
      x:e.x, y:e.y-205,
      t:0, duration:1.35, groundY:e.y-4
    });
  }
}
function updateSpecialEffects(dt){
  for(let i=specialEffects.length-1;i>=0;i--){
    const fx=specialEffects[i];
    fx.t+=dt;
    const e=fx.enemy;
    if(!e){ specialEffects.splice(i,1); continue; }

    if(fx.type==="portal"){
      const p=Math.min(1,fx.t/fx.duration);
      const pull=Math.min(1,Math.max(0,(p-.10)/.90));
      e.portalPull=pull;
      e.specialAlpha=Math.max(0,1-pull);

      /* Während des Portalzugs übernimmt NUR dieser Effekt die Ragdoll-Position.
         updateEnemy() lässt sie in dieser Phase bewusst in Ruhe. */
      if(e.ragdoll){
        const targetX=fx.x;
        const targetY=fx.y+30;
        const follow=Math.min(1,dt*(4+pull*12));
        for(const q of Object.values(e.ragdoll.pts)){
          q.x+=(targetX-q.x)*follow;
          q.y+=(targetY-q.y)*follow;
          q.vx*=0.75;
          q.vy*=0.75;
        }
      }

      if(p>=1){
        e.portalHidden=true;
        e.portalizing=false;
        e.specialAlpha=0;
        const idx=enemies.indexOf(e);
        if(idx>=0)enemies.splice(idx,1);
        const pidx=pendingEnemies.indexOf(e);
        if(pidx>=0)pendingEnemies.splice(pidx,1);
        specialEffects.splice(i,1);
      }
    }else if(fx.type==="light"){
      const p=Math.min(1,fx.t/fx.duration);
      e.ragdollProgress=Math.min(1,p);
      e.specialAlpha=1;
      if(p>=1){
        e.ragdollProgress=1;
        specialEffects.splice(i,1);
      }
    }else if(fx.t>=fx.duration){
      specialEffects.splice(i,1);
    }
  }
}
function drawSpecialEffects(){
  for(const fx of specialEffects){
    const x=fx.x-camera.x;
    if(fx.type==="portal"){
      const p=Math.min(1,fx.t/fx.duration), pull=Math.min(1,Math.max(0,(p-.18)/.82)), fade=1;
      ctx.save();ctx.globalAlpha=fade;
      ctx.translate(x,fx.y);
      ctx.strokeStyle="#b76cff";ctx.lineWidth=5;ctx.shadowBlur=24;ctx.shadowColor="#8c4dff";
      ctx.beginPath();ctx.ellipse(0,0,26+pull*15,43+pull*25,0,0,Math.PI*2);ctx.stroke();
      ctx.strokeStyle="#e4a8ff";ctx.lineWidth=2;
      for(let k=0;k<8;k++){
        const ang=-Math.PI*.9+k*(Math.PI*1.8/7);
        const reach=65+pull*28;
        ctx.beginPath();ctx.moveTo(Math.cos(ang)*8,Math.sin(ang)*12);
        ctx.quadraticCurveTo(Math.cos(ang)*42,Math.sin(ang)*55,Math.cos(ang)*reach,Math.sin(ang)*reach);ctx.stroke();
      }
      ctx.restore();
    }else if(fx.type==="light"){
      const p=Math.min(1,fx.t/fx.duration), fall=Math.min(1,p/.75), fade=p>.72?1-(p-.72)/.63:1;
      const y=fx.y+(fx.groundY-fx.y)*fall;
      ctx.save();ctx.globalAlpha=Math.max(0,fade);ctx.translate(x,y);ctx.rotate(-.12);
      ctx.shadowBlur=28;ctx.shadowColor="#dffcff";ctx.fillStyle="#f4ffff";ctx.fillRect(-3,-62,6,124);
      ctx.fillStyle="#a9f5ff";ctx.fillRect(-8,-52,16,104);ctx.fillStyle="#fff";ctx.fillRect(-2,-70,4,140);
      ctx.restore();
    }
  }
}
function updatePlayerDeath(dt){
  if(!playerDeath.active)return;
  playerDeath.time+=dt;
}

function renderShop(){
  const grid=document.getElementById("shopGrid"); if(!grid)return;
  document.getElementById("creditsText").textContent=credits; grid.innerHTML="";
  const lvl=getRankLevel(), baseXP=xpForLevel(lvl);
  const spent=xpSpentBeforeLevel(lvl);
  const inLevel=Math.max(0,playerXP-spent), pct=lvl>=1000?100:Math.min(100,Math.floor(inLevel/baseXP*100));
  const wp=document.getElementById("weaponProgress"); if(wp)wp.textContent=lvl>=1000?`LEVEL 1000 · ${getRankName(lvl)} · MAX LEVEL · REAKTIVER DIAMANT VERDIENT · WAFFEN: LEVEL ERREICHEN + KAUFEN`:`LEVEL ${lvl} · ${getRankName(lvl)} · XP ${inLevel}/${baseXP} (${pct}%) · WAFFEN: LEVEL ERREICHEN + KAUFEN`;
  Object.values(weaponCatalog).forEach(w=>{
    const owned=ownedWeapons.includes(w.name), equipped=player&&player.weapon===w.name;
    const card=document.createElement("div"); card.className="weaponCard"+(equipped?" equipped":"");
    const rankOK=weaponUnlocked(w);
    card.innerHTML=`<div class="weaponName">${w.name}</div><div class="weaponMeta">MAG ${w.mag} · SCHADEN ${w.damage} · ${w.pellets>1?"STREUSCHUSS":"PRÄZISION"}<br>${w.desc}${w.special?'<br>★ SPEZIALWAFFE'+(w.explosive?' · EXPLOSIV':'')+(w.shock?' · SCHOCKIMPULS':''):''}<br>${!rankOK?"GESPERRT · LEVEL "+w.req:owned?"IM BESITZ":"FREIGESCHALTET · KAUF: $"+w.cost}</div>`;
    const b=document.createElement("button"); b.textContent=equipped?"AUSGERÜSTET":!rankOK?"LEVEL "+w.req:owned?"AUSRÜSTEN":"KAUFEN · $"+w.cost; b.disabled=equipped||!rankOK||(!owned&&credits<w.cost); b.onclick=()=>buyOrEquipWeapon(w.name); card.appendChild(b); grid.appendChild(card);
  });
  renderDWolfUpgrade();
  renderArsenal();
  renderCompanions();
  const og=document.getElementById("outfitGrid"); if(!og)return; og.innerHTML="";
  Object.entries(outfitCatalog).forEach(([id,o])=>{
    const owned=ownedOutfits.includes(id), equipped=equippedOutfit===id;
    const card=document.createElement("div"); card.className="outfitCard"+(equipped?" equipped":"");
    const isCommunityPaid=id==="JICKENWINGPRIME"||id==="DEVILMARKER";
    const price=isCommunityPaid?1000:o.cost;
    card.innerHTML=`<div class="outfitName">${o.name}</div><div class="outfitMeta">${o.desc}<br>${owned?"IM BESITZ":"PREIS: $"+price}</div>`;
    const b=document.createElement("button");
    b.textContent=equipped?"GETRAGEN":owned?"ANZIEHEN":"KAUFEN · $"+price;
    b.disabled=equipped||(!owned&&credits<price);
    b.onclick=()=>buyOrEquipOutfit(id);
    card.appendChild(b); og.appendChild(card);
  });
  const sg=document.getElementById("skinGrid"); if(!sg)return; sg.innerHTML="";
  Object.values(weaponSkinCatalog).forEach(skin=>{
    const owned=ownedWeaponSkins.includes(skin.name), equipped=equippedWeaponSkin===skin.name;
    const card=document.createElement("div"); card.className="skinCard"+(equipped?" equipped":"");
    const isSecret=!!skin.secret;
    card.innerHTML=`<div class="skinSwatch" style="background:linear-gradient(135deg,${skin.color},#090d0f 70%);box-shadow:inset 0 0 0 1px #0008${skin.diamond?",0 0 18px #bffcff":""}"></div><div class="skinName">${skin.name}${isSecret?" · GEHEIM":""}</div><div class="skinMeta">${skin.desc}<br>${owned?"IM BESITZ":isSecret?"LEVEL-BELOHNUNG":"PREIS: $"+skin.cost}</div>`;
    const b=document.createElement("button"); b.textContent=equipped?"AUSGERÜSTET":owned?"AUSRÜSTEN":isSecret?"NOCH GESPERRT":"KAUFEN · $"+skin.cost; b.disabled=equipped||(!owned&&isSecret)||(!owned&&!isSecret&&credits<skin.cost); b.onclick=()=>buyOrEquipWeaponSkin(skin.name); card.appendChild(b); sg.appendChild(card);
  });
  renderArsenal();
}
function openShop(){if(gameRunning)paused=true;renderShop();document.getElementById("shopScreen").style.display="flex";}
function closeShop(){document.getElementById("shopScreen").style.display="none";paused=false;}

/* =========================================================
   BEGLEITER // K9 & SPECIAL
========================================================= */
const companionCatalog={
  HAYHAY:{name:"HAY HAY",cost:0,emoji:"🐔",type:"huhn",desc:"Kostenloser Chaos-Begleiter. Läuft mit und greift Gegner an.",ability:"PANIK-GACKERN"},
  SHEPHERD:{name:"DEUTSCHER SCHÄFERHUND",cost:4200,emoji:"🐕",type:"shepherd",desc:"Ausdauernder Spürhund für aggressive Nahkampfangriffe.",ability:"SPÜRINSTINKT"},
  DALMATIAN:{name:"DALMATINER",cost:4600,emoji:"🐕",type:"dalmatian",desc:"Schneller Begleiter mit hoher Angriffsgeschwindigkeit.",ability:"SPRINT"},
  FRENCHIE:{name:"FRANZÖSISCHE BULLDOGGE",cost:4800,emoji:"🐶",type:"frenchie",desc:"Kompakt, schnell und überraschend schlagkräftig.",ability:"RAMMSTOSS"},
  AMBULL:{name:"AMERIKANISCHE BULLDOGGE",cost:5400,emoji:"🐕",type:"ambull",desc:"Schwerer Angriffshund mit besonders hohem Basisschaden.",ability:"BRECHER"},
  DOBERMANN:{name:"DOBERMANN",cost:6200,emoji:"🐕",type:"dobermann",desc:"Elite-Begleiter mit hoher Reichweite und Präzision.",ability:"JAGD"},
  POODLE:{name:"PUDEL",cost:3900,emoji:"🐩",type:"poodle",desc:"Unterschätzt. Schnell, wendig und mit taktischer Ausrüstung.",ability:"TRICKANGRIFF"},
  DACHSHUND:{name:"DACKEL",cost:3500,emoji:"🐶",type:"dachshund",desc:"Klein, schnell und kommt auch durch enge Situationen.",ability:"FLINKER ANGRIFF"},
  ROTTWEILER:{name:"ROTTWEILER",cost:7000,emoji:"🐕",type:"rottweiler",desc:"Schwerer Elite-Begleiter mit maximaler Präsenz.",ability:"WACHHUND"}
};
let ownedCompanions=(()=>{try{const a=JSON.parse(localStorage.getItem("blacklistCompanions")||"[]");return Array.isArray(a)?a.filter(x=>companionCatalog[x]):["HAYHAY"]}catch(e){return ["HAYHAY"]}})();
if(!ownedCompanions.includes("HAYHAY"))ownedCompanions.unshift("HAYHAY");
let equippedCompanion=localStorage.getItem("blacklistEquippedCompanion")||"HAYHAY";
if(!companionCatalog[equippedCompanion]||!ownedCompanions.includes(equippedCompanion))equippedCompanion="HAYHAY";
let companionUpgrades=(()=>{try{const a=JSON.parse(localStorage.getItem("blacklistCompanionUpgrades")||"{}");return {damage:Math.min(10,Math.max(0,a.damage|0)),ability:Math.min(10,Math.max(0,a.ability|0)),gear:Math.min(10,Math.max(0,a.gear|0))}}catch(e){return {damage:0,ability:0,gear:0}}})();
let companion={id:equippedCompanion,x:300,y:450,attackCd:0,anim:0};
function companionUpgradeCost(type){const lv=companionUpgrades[type]||0;return 900+lv*700;}
function buyOrEquipCompanion(id){
  const c=companionCatalog[id];if(!c)return;
  if(!ownedCompanions.includes(id)){
    if(credits<c.cost){showAlert("ZU WENIG CREDITS","red");return;}
    credits-=c.cost;ownedCompanions.push(id);saveLoadout();showAlert(c.name+" FREIGESCHALTET","green");
  }
  equippedCompanion=id;localStorage.setItem("blacklistEquippedCompanion",id);
  if(companion)companion.id=id;
  saveLoadout();renderShop();
}
function upgradeCompanion(type){
  if((companionUpgrades[type]||0)>=10){showAlert("BEGLEITER-UPGRADE MAXIMUM","red");return;}
  const cost=companionUpgradeCost(type);if(credits<cost){showAlert("ZU WENIG CREDITS","red");return;}
  credits-=cost;companionUpgrades[type]++;saveLoadout();
  showAlert("BEGLEITER-UPGRADE · "+type.toUpperCase(),"green");renderShop();
}
function renderCompanionUpgrade(){
  const panel=document.getElementById("companionUpgradePanel");if(!panel)return;
  const c=companionCatalog[equippedCompanion];if(!c){panel.style.display="none";return;}
  panel.style.display="block";
  const dmg=10+companionUpgrades.damage*6;
  const rate=(1.05-companionUpgrades.ability*.065).toFixed(2);
  const gear=companionUpgrades.gear;
  const rows=[
    ["SCHADEN","damage",dmg,"+6 Schaden / Stufe"],
    ["FÄHIGKEIT","ability",rate+" s","schnellerer Spezialangriff"],
    ["AUSRÜSTUNG / AUSSEHEN","gear","LV "+gear,"sichtbare taktische Ausrüstung"]
  ];
  panel.innerHTML='<h3>🐾 '+c.name+' // UPGRADES</h3><div class="upgradeSub">Der Begleiter ist unsterblich. Upgrades werden direkt am Begleiter sichtbar: Ausrüstung, Panzerung und Spezialdetails wachsen mit dem Level.</div>'+rows.map(r=>{const lv=companionUpgrades[r[1]]||0,max=lv>=10,cost=companionUpgradeCost(r[1]);return `<div class="upgradeRow"><div><div class="upgradeName">${r[0]}</div><div style="font-size:9px;color:#748187">${r[3]}</div></div><div class="upgradeLevel">LV ${lv}/10 · ${r[2]}</div><button ${max||credits<cost?'disabled':''} onclick="upgradeCompanion('${r[1]}')">${max?'MAX':'$'+cost}</button></div>`}).join('');
}
function renderCompanions(){
  const grid=document.getElementById("companionGrid");if(!grid)return;grid.innerHTML="";
  Object.entries(companionCatalog).forEach(([id,c])=>{
    const owned=ownedCompanions.includes(id),equipped=equippedCompanion===id;
    const card=document.createElement("div");card.className="companionCard"+(equipped?" equipped":"");
    const dmg=10+companionUpgrades.damage*6;
    const gear=companionUpgrades.gear;
    card.innerHTML=`<div class="companionPreview">${c.emoji}</div><div class="companionName">${c.name}</div><div class="companionMeta">${c.desc}<br>FÄHIGKEIT: ${c.ability}<br>UNSTERBLICH · SCHADEN LV ${companionUpgrades.damage}/10 · AUSRÜSTUNG LV ${gear}/10</div><div class="companionStats">ANGRIFF ${dmg} · SPEZIAL ${Math.max(.40,1.05-companionUpgrades.ability*.065).toFixed(2)}s</div>`;
    const b=document.createElement("button");b.textContent=equipped?"AUSGERÜSTET":owned?"AUSRÜSTEN":id==="HAYHAY"?"GRATIS":"KAUFEN · $"+c.cost;b.disabled=equipped||(!owned&&credits<c.cost);b.onclick=()=>buyOrEquipCompanion(id);card.appendChild(b);grid.appendChild(card);
  });
  renderCompanionUpgrade();
}
function updateCompanion(dt){
  if(!companion||!player)return;
  companion.id=equippedCompanion;
  companion.attackCd=Math.max(0,(companion.attackCd||0)-dt);
  companion.anim+=(dt*6);
  const side=player.dir>=0?-1:1;
  const tx=player.x+side*58,ty=player.y+24;
  companion.x+=(tx-companion.x)*Math.min(1,dt*7);
  companion.y+=(ty-companion.y)*Math.min(1,dt*7);
  companion.x=clamp(companion.x,90,world.width-90);companion.y=clamp(companion.y,390,505);
  let targetEnemy=null,best=Infinity;
  for(const e of enemies){if(e.dead)continue;const d=Math.hypot(e.x-companion.x,e.y-companion.y);if(d<330&&d<best){best=d;targetEnemy=e;}}
  if(targetEnemy&&companion.attackCd<=0){
    const base=10+companionUpgrades.damage*6;
    const type=companionCatalog[equippedCompanion]?.type;
    const bonus=type==="ambull"||type==="rottweiler"?5:type==="dobermann"?3:0;
    const damage=base+bonus;
    targetEnemy.hp-=damage;
    targetEnemy.flash=.12;targetEnemy.stagger=.10;targetEnemy.knockback=(targetEnemy.x<companion.x?-1:1)*18;
    burst(targetEnemy.x,targetEnemy.y-55,"spark");
    companion.attackCd=Math.max(.40,1.05-companionUpgrades.ability*.065);
    if(targetEnemy.hp<=0&&!targetEnemy.dead){
      targetEnemy.dead=true;targetEnemy.deathDir=rand(-1,1)<0?-1:1;targetEnemy.fall=0;targetEnemy.weaponDropped=true;
      awardCredits(targetEnemy.type==="heavy"?90:55);awardXP(targetEnemy.type==="heavy"?120:65);player.hp=Math.min(player.maxHp||100,(player.hp||0)+5);const kw=getWeapon();player.reserve=Math.min(kw.reserve,(player.reserve||0)+10);burst(targetEnemy.x,targetEnemy.y-35,"death");
    }
  }
}
function drawCompanion(){
  if(!companion||!player)return;
  const c=companionCatalog[equippedCompanion];if(!c)return;
  const x=companion.x-camera.x,y=companion.y;if(x<-100||x>W+100)return;
  const moving=Math.hypot((companion.x-(companion.prevX||companion.x)),(companion.y-(companion.prevY||companion.y)))>.25;
  const speed= moving ? 1 : 0;
  companion.prevX=companion.x;companion.prevY=companion.y;
  companion.anim=(companion.anim||0)+speed*dtForCompanion();
  const t=companion.anim,gear=companionUpgrades.gear;
  ctx.save();ctx.translate(x,y);ctx.scale(player.dir<0?-1:1,1);
  ctx.fillStyle="#0008";ctx.beginPath();ctx.ellipse(0,7,30,7,0,0,Math.PI*2);ctx.fill();
  if(c.type==="huhn"){
    // Hay Hay: kleine Laufbewegung mit wechselnden Beinen und Körperwippen.
    const bob=moving?Math.sin(t*10)*2:0,leg=Math.sin(t*10)*3;
    ctx.translate(0,bob);
    ctx.fillStyle="#e6e0cf";ctx.beginPath();ctx.ellipse(0,-21,19,21,0,0,Math.PI*2);ctx.fill();
    ctx.fillStyle="#b94136";ctx.beginPath();ctx.arc(1,-45,12,0,Math.PI*2);ctx.fill();
    ctx.fillStyle="#f0d34e";ctx.beginPath();ctx.moveTo(11,-45);ctx.lineTo(26,-41);ctx.lineTo(11,-38);ctx.fill();
    ctx.fillStyle="#d54b42";ctx.fillRect(-8,-58,5,7);ctx.fillRect(0,-60,5,9);ctx.fillRect(8,-58,5,7);
    ctx.strokeStyle="#b88945";ctx.lineWidth=3;ctx.lineCap="round";
    ctx.beginPath();ctx.moveTo(-7,-3);ctx.lineTo(-8+leg,8);ctx.moveTo(7,-3);ctx.lineTo(8-leg,8);ctx.stroke();
  }else{
    const colors={shepherd:"#76583d",dalmatian:"#ececec",frenchie:"#b99d80",ambull:"#e5e0d4",dobermann:"#292a2b",poodle:"#e7e3dc",dachshund:"#9b5b31",rottweiler:"#252321"};
    const body=colors[c.type]||"#777";
    const walk=moving?Math.sin(t*9):0;
    const walk2=moving?Math.sin(t*9+Math.PI):0;
    const bob=moving?Math.abs(Math.sin(t*9))*1.5:0;
    ctx.translate(0,bob);
    // Schwanz: bewegt sich sichtbar beim Laufen.
    ctx.strokeStyle=body;ctx.lineWidth=7;ctx.lineCap="round";ctx.beginPath();
    ctx.moveTo(-24,-29);ctx.quadraticCurveTo(-39,-38- walk*2,-43,-25+walk*2);ctx.stroke();
    // Hinterkörper und Brust.
    ctx.fillStyle=body;ctx.beginPath();ctx.ellipse(-3,-27,29,19,0,0,Math.PI*2);ctx.fill();
    ctx.beginPath();ctx.ellipse(23,-44,18,17,0,0,Math.PI*2);ctx.fill();
    // Hals/Brust für eine etwas realistischere Silhouette.
    ctx.beginPath();ctx.ellipse(15,-31,13,18,-.18,0,Math.PI*2);ctx.fill();
    // Kopfdetails.
    ctx.fillStyle="#111";ctx.beginPath();ctx.arc(31,-46,2.6,0,Math.PI*2);ctx.fill();
    ctx.fillStyle="#171717";ctx.beginPath();ctx.arc(40,-40,3.2,0,Math.PI*2);ctx.fill();
    // Vier einzelne, gelenkige Beine mit gegenläufigem Laufzyklus.
    function leg(lx,phase,front){
      const a=phase*.42, knee=front?-1:1;
      const upperY=-13, lowerY=-2;
      ctx.strokeStyle=body;ctx.lineWidth=8;ctx.lineCap="round";ctx.lineJoin="round";
      ctx.beginPath();ctx.moveTo(lx,upperY);ctx.lineTo(lx+a*7,lowerY);ctx.lineTo(lx+a*7+knee*1,9);ctx.stroke();
      ctx.strokeStyle="#1118";ctx.lineWidth=2;ctx.beginPath();ctx.moveTo(lx+a*7,lowerY);ctx.lineTo(lx+a*7+knee*1,9);ctx.stroke();
    }
    leg(-17,walk,false);leg(-4,walk2,false);leg(13,walk2,true);leg(25,walk,true);
    // Pfoten.
    ctx.strokeStyle="#111";ctx.lineWidth=3;ctx.beginPath();
    ctx.moveTo(-18+walk*3,9);ctx.lineTo(-11+walk*3,9);
    ctx.moveTo(-5+walk2*3,9);ctx.lineTo(2+walk2*3,9);
    ctx.moveTo(12+walk2*3,9);ctx.lineTo(19+walk2*3,9);
    ctx.moveTo(24+walk*3,9);ctx.lineTo(31+walk*3,9);ctx.stroke();
    // Rasse-spezifische Details.
    if(c.type==="dalmatian"){ctx.fillStyle="#303030";for(const [sx,sy] of [[-12,-29],[2,-21],[13,-32],[-2,-39]]){ctx.beginPath();ctx.arc(sx,sy,3,0,Math.PI*2);ctx.fill();}}
    if(c.type==="frenchie"||c.type==="ambull"){
      ctx.fillStyle="#171717";ctx.beginPath();ctx.moveTo(18,-56);ctx.lineTo(8,-70);ctx.lineTo(24,-62);ctx.fill();
      ctx.beginPath();ctx.moveTo(32,-56);ctx.lineTo(40,-70);ctx.lineTo(42,-58);ctx.fill();
    }
    if(c.type==="poodle"){ctx.fillStyle="#d8d4ce";ctx.beginPath();ctx.arc(27,-53,13,0,Math.PI*2);ctx.fill();ctx.beginPath();ctx.arc(13,-51,9,0,Math.PI*2);ctx.fill();}
    if(c.type==="dachshund"){ctx.scale(1.22,.82);}
    if(c.type==="rottweiler"){ctx.fillStyle="#9a2e35";ctx.fillRect(24,-55,9,5);}
    // Sichtbare Upgrades: Geschirr, Platten und Tech-Modul.
    if(gear>0){ctx.fillStyle=gear>=7?"#56656b":"#303b40";ctx.fillRect(-19,-38,40,8);ctx.fillStyle="#8b9aa0";ctx.fillRect(-4,-39,10,10);}
    if(gear>=3){ctx.strokeStyle="#65d7ff";ctx.lineWidth=2;ctx.beginPath();ctx.arc(2,-34,8+gear*.35,0,Math.PI*2);ctx.stroke();}
    if(gear>=5){ctx.fillStyle="#111719";ctx.fillRect(-28,-33,9,13);ctx.fillRect(29,-34,9,13);}
    if(gear>=8){ctx.fillStyle="#b7dce3";ctx.beginPath();ctx.arc(10,-41,4,0,Math.PI*2);ctx.fill();ctx.shadowBlur=12;ctx.shadowColor="#65d7ff";ctx.fillStyle="#65d7ff";ctx.fillRect(10,-43,7,3);ctx.shadowBlur=0;}
    if(gear>=10){ctx.strokeStyle="#e5fbff";ctx.lineWidth=2;ctx.beginPath();ctx.arc(0,-26,32+Math.sin(t)*2,0,Math.PI*2);ctx.stroke();}
  }
  ctx.restore();
}
function dtForCompanion(){return Math.min(.04,Math.max(.016,(performance.now()-(companion._lastT||performance.now()))/1000))||.016;}


/* =========================================================
   CUTSCENES
========================================================= */
let cutscene={active:false,timer:0,callback:null,chars:0,text:"",auto:0};
function showCutscene(title,text,callback){
  cutscene.active=true;cutscene.timer=0;cutscene.callback=callback;cutscene.text=text;cutscene.chars=0;cutscene.auto=0;
  document.getElementById("cutsceneTitle").textContent=title;document.getElementById("cutsceneText").textContent="";document.getElementById("cutsceneScreen").style.display="flex";document.getElementById("mobileControls").style.display="none";
}
function finishCutscene(){if(!cutscene.active)return;const cb=cutscene.callback;cutscene.active=false;cutscene.callback=null;document.getElementById("cutsceneScreen").style.display="none";if(gameRunning)document.getElementById("mobileControls").style.display="block";if(cb)cb();}
document.getElementById("cutsceneSkip").onclick=finishCutscene;
function updateCutscene(dt){cutscene.timer+=dt;cutscene.chars=Math.min(cutscene.text.length,Math.floor(cutscene.timer*55));document.getElementById("cutsceneText").textContent=cutscene.text.slice(0,cutscene.chars);if(cutscene.chars>=cutscene.text.length){cutscene.auto+=dt;if(cutscene.auto>2.8)finishCutscene();}}

/* =========================================================
   LEVEL
========================================================= */

function setupLevel(id){

  currentLevel=id;

  const m=
    missions[id];

  world.width=
    6000+id*130;

  player={

    x:300,
    y:430,

    vx:0,
    vy:0,

    dir:1,
    walking:false,
    walkPhase:0,
    recoil:0,
    muzzle:0,

    weapon:equippedWeapon,
    outfit:equippedOutfit,

    aimX:1,
    aimY:0,

    hp:100,
    maxHp:100,

    ammo:30,
    reserve:150,

    shootCd:0,
    reload:0,

    camo:0,
    inv:0
  };

  const equipped=weaponCatalog[player.weapon];
  player.ammo=equipped.mag;
  player.reserve=equipped.reserve;
  companion={id:equippedCompanion,x:player.x-58,y:player.y+24,attackCd:0,anim:0};

  // Touch-Zustände beim Missionsstart vollständig zurücksetzen.
  touch.move.active=false; touch.move.id=null; touch.move.x=0; touch.move.y=0;
  touch.aim.active=false; touch.aim.id=null; touch.aim.x=0; touch.aim.y=0;
  touch.fire=false;
  const moveStickEl=document.getElementById("moveStick");
  const aimStickEl=document.getElementById("aimStick");
  if(moveStickEl)moveStickEl.style.transform="translate(0px,0px)";
  if(aimStickEl)aimStickEl.style.transform="translate(0px,0px)";

  enemies=[];
  pendingEnemies=[];
  bullets=[];
  enemyBullets=[];
  particles=[];
  props=[];

  target=null;

  camera.x=0;

  /*
    Gegneranzahl
  */

  for(
    let i=0;
    i<m[4];
    i++
  ){

    const spawnStart=Math.max(850,W+80);
    const spawnEnd=Math.max(spawnStart+400,world.width-900);
    const x=
      spawnStart+
      (m[4]<=1?.5:i/(m[4]-1))*
      (spawnEnd-spawnStart)+
      rand(-55,55);

    const heavy=
      Math.random()<.14;
    const enemyScale=getEnemyScale();

    /* Gegner bekommen bewusst unterschiedliche Höhen/Laufbahnen,
       damit sie nicht wie auf einer geraden Schießlinie stehen. */
    const spawnLanes=[398,414,448,470,492];
    const lane=spawnLanes[randi(0,spawnLanes.length-1)];
    const spawnY=clamp(lane+rand(-7,7),385,505);

    pendingEnemies.push({

      x:x,

      y:spawnY,
      homeY:spawnY,
      vy:0,
      walking:false,
      walkPhase:rand(0,6.28),

      homeX:x,

      dir:
        Math.random()<.5
        ?-1
        :1,

      hp:
        Math.round((heavy?150:100)*enemyScale.hp),

      maxHp:
        Math.round((heavy?150:100)*enemyScale.hp),

      type:
        heavy
        ?"heavy"
        :"rifle",

      weapon:
        heavy
        ? (Math.random()<.35 ? "BREACH" : Math.random()<.5 ? "PHANTOM" : "HAMMER")
        : (["PISTOLE","VECTOR","RAVEN","SPECTRE","VANGUARD","SHADOW","FURY","VOLT"][randi(0,7)]),

      state:"patrol",

      alert:0,
      contactDelay:0,
      lastSeenX:x,
      lastSeenY:430,

      vision:
        (heavy?470:500)*enemyScale.vision,

      shoot:
        rand(1.5,2.8),

      patrol:
        rand(70,180),

      flash:0,

      // Universelle Trefferzonen: jeder Gegner besitzt Kopf-, Körper-, Bein- und Gesamt-Hitbox.
      hitbox:{head:13,body:30,legs:22,overall:32},

      dead:false
    });
  }

  /*
    BOSS-SPAWN
  */
  const bossConfigs={
    7:["IRON WARDEN",980,"TITAN"],
    12:["BLACK HUNTER",1120,"VOLT"],
    18:["COMMANDER VEX",1280,"FURY"],
    25:["OVERSEER",1500,"TITAN"],
    28:["TITAN GUARD",1750,"TITAN"],
    32:["FROST COMMANDER",2050,"VOLT"],
    33:["RED WARDEN",2300,"TITAN"]
  };
  const bossCfg=bossConfigs[Number(m[0])];
  if(bossCfg){
    const bossScale=getEnemyScale();
    pendingEnemies.push({
      x:world.width-980,y:425,homeY:425,vy:0,walking:false,walkPhase:0,homeX:world.width-980,dir:-1,
      hp:Math.round(bossCfg[1]*bossScale.hp),maxHp:Math.round(bossCfg[1]*bossScale.hp),
      type:"boss",weapon:bossCfg[2],state:"patrol",alert:0,contactDelay:0,lastSeenX:player.x,lastSeenY:425,
      vision:700*bossScale.vision,shoot:.8,patrol:120,flash:0,hitbox:{head:17,body:42,legs:28,overall:45},dead:false,
      boss:true,bossName:bossCfg[0]
    });
  }

  /*
    Ziel
  */

  if(m[5]==="target"){

    target={
      x:world.width-850,
      y:405,
      hp:300,
      maxHp:300,
      alive:true
    };
  }

  extractX=
    world.width-280;


  /*
    Umgebung
  */

  for(
    let i=0;
    i<world.width/95;
    i++
  ){

    const env=m[2];

    let x=
      i*95+rand(-20,20);

    // Sicherheitszone am Missionsstart: Kisten niemals innerhalb von 5 m um Zero.
    // 5 m werden im Spiel als ca. 250 Welt-Einheiten behandelt.
    if(Math.abs(x-player.x)<250){
      x = player.x + (x>=player.x ? 300 : -300);
    }

    if(
      env==="CITY" ||
      env==="FACTORY" ||
      env==="BASE" ||
      env==="LAB" ||
      env==="AIRPORT"
    ){

      if(Math.random()<.6){

        props.push({

          type:"building",

          x:x,

          y:390,

          w:env==="CITY"?rand(125,230):rand(110,195),

          h:env==="CITY"?rand(115,270):rand(90,180)
        });
      }

    }else{

      if(Math.random()<.65){

        props.push({

          type:
            ["tree","tree","rock","crate"]
            [randi(0,3)],

          x:x,

          y:rand(395,465),

          s:rand(.7,1.4)
        });
      }
    }
  }

  // Letzte Prüfung: keine Kiste darf näher als 5 m am Spawnpunkt liegen.
  for(const p of props){
    if(p.type==="crate" && Math.hypot(p.x-player.x,p.y-player.y)<250){
      p.x=player.x + 300;
    }
  }

  updateHUD();
}


function newGame(){
  if(!confirm("NEUES SPIEL STARTEN?\n\nMissionsfortschritt, Credits, Waffen, Outfits und Waffen-Skins werden zurückgesetzt."))return;
  localStorage.removeItem("blacklistMobileUnlocked");
  localStorage.removeItem("blacklistCredits");
  localStorage.removeItem("blacklistXP");
  localStorage.removeItem("blacklistWeapons");
  localStorage.removeItem("blacklistOutfits");
  localStorage.removeItem("blacklistWeaponSkins");
  localStorage.removeItem("blacklistDWolfUpgrades");
  localStorage.removeItem("blacklistEquippedWeapon");
  localStorage.removeItem("blacklistEquippedOutfit");
  localStorage.removeItem("blacklistEquippedWeaponSkin");
  location.reload();
}

/* =========================================================
   START
========================================================= */


/* =========================================================
   LAZY ENEMY SPAWN
   Gegner werden erst aktiviert, wenn sie in Sichtweite kommen.
========================================================= */
function activateVisibleEnemies(){
  if(!player || !pendingEnemies.length)return;
  const viewLeft=camera.x-70;
  const viewRight=camera.x+W+70;
  for(let i=pendingEnemies.length-1;i>=0;i--){
    const e=pendingEnemies[i];
    if(e.x>=viewLeft && e.x<=viewRight){
      enemies.push(e);
      pendingEnemies.splice(i,1);
      if(e.boss){
        showAlert("BOSS IN SICHT", "red");
        radio("Funk: Bosskontakt. Feindlicher Kommandeur in Sicht.",true);
      }
    }
  }
}

function startGame(id=0){
  playerDeath={active:false,time:0};
  const ds=document.getElementById("deathScreen"); if(ds)ds.style.display="none";

  document
    .getElementById("menu")
    .style.display="none";

  document
    .getElementById("missionScreen")
    .style.display="none";

  document
    .getElementById("hud")
    .style.display="block";

  document
    .getElementById("mobileControls")
    .style.display="block";

  document
    .getElementById("crosshair")
    .style.display="block";

  gameRunning=true;
  paused=false;
  won=false;

  setupLevel(id);
  radio("Funk an Zero. Einsatz beginnt. Ziel: "+missions[id][3]+".",true);
  zeroSpeak("Verstanden. Ich erledige das.",true);
  showCutscene(
    "LEVEL "+missions[id][0]+" · "+missions[id][1],
    levelStartTexts[id]+"\n\nZIEL: "+missions[id][3]+". Gelb bedeutet Verdacht, Rot bedeutet bestätigten Sichtkontakt.",
    ()=>{document.getElementById("mobileControls").style.display="block";}
  );
}

document
  .getElementById("start")
  .onclick=
  ()=>{
    startGame(
      Math.min(
        currentLevel,
        unlocked-1
      )
    );
  };


/* =========================================================
   MISSIONS MENU
========================================================= */

document.getElementById("missionsButton").onclick=showMissions;
document.getElementById("shopButton").onclick=openShop;
document.getElementById("newGameButton").onclick=newGame;

function showMissions(){

  const mr=document.getElementById("missionRankText"); if(mr)mr.textContent=getRankLevel();
  const grid=
    document.getElementById(
      "levelGrid"
    );

  grid.innerHTML="";

  missions.forEach(
    (m,i)=>{

      const b=
        document.createElement(
          "button"
        );

      b.textContent=
        m[0]+" · "+m[1];

      if(i>=unlocked){

        b.className="locked";

      }else{

        b.onclick=
          ()=>startGame(i);
      }

      grid.appendChild(b);
    }
  );

  document
    .getElementById(
      "missionScreen"
    )
    .style.display="flex";
}

function closeMissions(){

  document
    .getElementById(
      "missionScreen"
    )
    .style.display="none";
}


/* =========================================================
   PAUSE
========================================================= */

function togglePause(){

  if(!gameRunning)return;

  paused=!paused;

  document
    .getElementById("pause")
    .style.display=
      paused?"flex":"none";
}

function resumeGame(){

  paused=false;

  document
    .getElementById("pause")
    .style.display="none";
}

function backMenu(){

  gameRunning=false;
  cutscene.active=false;
  document.getElementById("shopScreen").style.display="none";
  document.getElementById("cutsceneScreen").style.display="none";

  document
    .getElementById("pause")
    .style.display="none";

  document
    .getElementById("hud")
    .style.display="none";

  document
    .getElementById("mobileControls")
    .style.display="none";

  document
    .getElementById("crosshair")
    .style.display="none";

  document
    .getElementById("menu")
    .style.display="flex";
}


/* =========================================================
   CAMOUFLAGE
========================================================= */


/* =========================================================
   RELOAD
========================================================= */

function reload(){

  const w=getWeapon();
  if(w.melee)return;
  if(
    player.reload>0 ||
    player.ammo>=w.mag ||
    player.reserve<=0
  )return;

  player.reload=1.2;
}

function finishReload(){

  const amount=
    Math.min(
      getWeapon().mag-player.ammo,
      player.reserve
    );

  player.ammo+=amount;
  player.reserve-=amount;
  player.reload=0;
}


/* =========================================================
   SPECIAL WEAPON EFFECTS
========================================================= */
function specialImpact(b,hitX,hitY,hitEnemy){
  if(b.explosive){
    burst(hitX,hitY,"death");
    camera.shake=Math.max(camera.shake||0,10);
    for(const e of enemies){
      if(e.dead || e===hitEnemy) continue;
      const d=Math.hypot(e.x-hitX,e.y-hitY);
      if(d<120){
        e.hp-=Math.max(12,b.explosive*(1-d/120));
        e.state="combat";e.alert=2;e.stagger=.18;e.flash=.12;
      }
    }
  }
  if(b.shock){
    for(const e of enemies){
      if(e.dead)continue;
      const d=Math.hypot(e.x-hitX,e.y-hitY);
      if(d<115){e.stagger=Math.max(e.stagger||0,.65);e.shoot=Math.max(e.shoot,.9);e.alert=2;}
    }
    for(let i=0;i<12;i++)particles.push({x:hitX,y:hitY,vx:rand(-140,140),vy:rand(-140,140),life:.5,type:"spark"});
  }
}

/* =========================================================
   PLAYER SHOOT
========================================================= */

function getWeaponMuzzle(weaponName){
  const lengths={PISTOLE:32,FALCON:40,VECTOR:49,SPECTRE:47,RAVEN:61,PHANTOM:57,BREACH:59,NIGHTFALL:83,VANGUARD:71,SHADOW:84,HAMMER:62,FURY:77,VOLT:79,TITAN:62,"D-WOLF":86,RAILGUN:108,FAUSTE:40,SPEER:120,KATANA:92,MESSER:58,SCHWERT:105,STAB:115};
  return {x:15+(lengths[weaponName]||45),y:-54};
}

function shoot(){
  if(player.reload>0||player.shootCd>0)return;
  const w=getWeapon();
  if(w.melee){performMeleeAttack();return;}
  if(player.ammo<=0){reload();return;}
  player.ammo--; player.shootCd=w.cooldown; player.recoil=.12; player.muzzle=.07;
  const len=Math.hypot(player.aimX,player.aimY)||1; const ax=player.aimX/len, ay=player.aimY/len; const base=Math.atan2(ay,ax);
  const muzzle=getWeaponMuzzle(player.weapon);
  for(let i=0;i<w.pellets;i++){
    const angle=base+rand(-w.spread,w.spread);
    const mx=player.x+muzzle.x*Math.cos(angle)-muzzle.y*Math.sin(angle);
    const my=player.y+muzzle.x*Math.sin(angle)+muzzle.y*Math.cos(angle);
    blacklistSfx&&blacklistSfx("shoot");
    bullets.push({x:mx,y:my,vx:Math.cos(angle)*w.speed,vy:Math.sin(angle)*w.speed,life:1.15,damage:w.damage,explosive:w.explosive||0,shock:!!w.shock,railgun:!!w.railgun,specialType:(selectedSpecialAmmo&&ownedSpecialAmmo.includes(selectedSpecialAmmo))?selectedSpecialAmmo:""});
  }
  flash=.07;
  for(let i=0;i<(w.pellets>1?10:5);i++)particles.push({x:player.x+ax*muzzle.x,y:player.y-54+ay*muzzle.x,vx:rand(-80,80)+ax*rand(30,130),vy:rand(-80,80)+ay*rand(30,130),life:.25,type:"spark"});
}

/* =========================================================
   ENEMY SHOOT
========================================================= */

function enemyShoot(e){

  const sx=
    e.x+e.dir*18;

  const sy=
    e.y-40;

  let angle=
    Math.atan2(
      player.y-42-sy,
      player.x-sx
    );

  /*
    Bewusst etwas ungenauer
  */

  angle+=rand(
    -.11,
    .11
  );

  enemyBullets.push({

    x:sx,
    y:sy,

    vx:
      Math.cos(angle)*590,

    vy:
      Math.sin(angle)*590,

    life:1.6,

    damage:
      Math.round((e.boss?13:(e.type==="heavy"?7:4))*getEnemyScale().damage)
  });

  e.flash=.07;
}


/* =========================================================
   LINE OF SIGHT
========================================================= */

function lineOfSight(e){

  const d=
    Math.abs(
      player.x-e.x
    );

  if(d>e.vision)
    return false;

  if(
    Math.abs(
      player.y-e.y
    )>110
  )
    return false;

  const direction=
    player.x>e.x
    ?1
    :-1;

  /*
    Gegner müssen ungefähr
    in unsere Richtung schauen
  */

  if(
    e.dir!==direction &&
    d>120
  )
    return false;

  return true;
}


/* =========================================================
   ENEMY AI / REACTIONS
========================================================= */

function updateEnemy(e,dt){

  /* Tote Gegner durchlaufen eine kurze, sichtbare Todesanimation:
     erst Knie/Absacken, danach zufällig nach vorne oder hinten umfallen. */
  if(e.dead){
    /* Portal-Ragdoll wird ausschließlich von updateSpecialEffects() gezogen.
       So kämpfen zwei Physik-Systeme nicht gleichzeitig um dieselben Gelenke. */
    if(e.ragdoll && !e.portalizing) updateRagdoll(e,dt);
    else if(!e.ragdoll) e.fall=Math.min(1,(e.fall||0)+dt*2.35);
    return;
  }

  if(e.stagger>0){
    e.stagger-=dt;
    e.x+= (e.knockback||0)*dt;
    e.knockback*=Math.max(0,1-dt*8);
  }

  if(e.flash>0)
    e.flash-=dt;

  const visible=lineOfSight(e);

  /*
    FEINDSICHT:
    1) GELB = Verdacht
    2) kurze Reaktionszeit
    3) ROT = klarer Sichtkontakt
    4) erst danach beginnt das Schießen
  */

  if(visible){

    e.lastSeenX=player.x;
    e.lastSeenY=player.y;

    if(e.state==="patrol" || e.state==="search"){

      e.state="alert";
      e.alert=0;
      e.contactDelay=0.72;

    }else if(e.state==="alert"){

      e.alert+=dt;
      e.contactDelay-=dt;

      if(e.contactDelay<=0){

        e.state="combat";
        e.alert=.72;

        // Nicht im selben Frame feuern.
        e.shoot=.22+rand(.08,.22);

        showAlert(
          "FEINDLICHER SICHTKONTAKT",
          "red"
        );
      }

    }else if(e.state==="combat"){

      e.alert=Math.min(2,e.alert+dt);
    }

  }else{

    if(e.state==="combat"){

      e.alert-=dt*.65;

      if(e.alert<0){

        e.alert=0;
        e.state="search";
        e.shoot=.8;
      }

    }else if(e.state==="alert"){

      e.alert-=dt*.4;

      // Wenn der Gegner die Sicht verliert, wird der Verdacht
      // langsam abgebaut statt sofort zurückzusetzen.
      if(e.alert<-.35){

        e.alert=0;
        e.contactDelay=0;
        e.state="patrol";
      }
    }
  }


  /*
    PATROUILLE / SUCHE
  */

  if(
    e.state==="patrol" ||
    e.state==="search"
  ){

    const es=getEnemyScale();
    const speed=
      (e.state==="search"
      ?55
      :35)*es.speed;

    e.x+=e.dir*speed*dt;
    e.y=e.homeY+Math.sin(performance.now()/650+e.homeX*.01)*7;
    e.y=clamp(e.y,385,505);
    e.walking=true;
    e.walkPhase+=dt*5;

    if(
      Math.abs(
        e.x-e.homeX
      )>e.patrol
    ){

      e.dir*=-1;
    }

    if(e.state==="search"){

      e.dir=
        e.lastSeenX>e.x
        ?1
        :-1;

      // Am letzten Sichtpunkt kurz suchen.
      if(Math.abs(e.x-e.lastSeenX)<20){
        e.state="patrol";
      }
    }
  }


  /*
    GELB / VERDACHT
  */

  else if(e.state==="alert"){

    e.dir=
      player.x>e.x
      ?1
      :-1;
  }


  /*
    ROT / KAMPF
  */

  else if(e.state==="combat"){

    e.dir=
      player.x>e.x
      ?1
      :-1;

    const d=
      Math.abs(
        player.x-e.x
      );

    const es=getEnemyScale();
    /* Nach bestätigtem Sichtkontakt verfolgen Gegner Zero aktiv. */
    if(d>85){
      e.x+=e.dir*62*es.speed*dt;
    }
    const verticalGap=player.y-e.y;
    e.y+=clamp(verticalGap,-55,55)*dt*.72;
    e.y=clamp(e.y,385,505);
    e.walking=d>.02;
    e.walkPhase+=dt*7;

    // Während Tarnung kann kein neuer Feindkontakt entstehen.
    // Bereits alarmierte Gegner schießen ebenfalls nicht weiter,
    // solange Zero unsichtbar ist.

    e.shoot-=dt;

    if(e.shoot<=0 && visible){

      enemyShoot(e);
      radio("Funk: Feind eröffnet das Feuer.");

      /* Jeder Gegner schießt nach genau 1 Sekunde wieder. */
      e.shoot=.65;
    }
  }
}


/* =========================================================
   COVER / COLLISION
========================================================= */

function circleHitsCrate(x,y,r,p){
  if(p.type!=="crate" || p.broken)return false;
  const s=p.s||1;
  const left=p.x-20*s, right=p.x+20*s;
  const top=p.y-28*s, bottom=p.y;
  const cx=clamp(x,left,right), cy=clamp(y,top,bottom);
  return Math.hypot(x-cx,y-cy)<r;
}

function canMoveTo(x,y,r){
  for(const p of props){
    if(circleHitsCrate(x,y,r,p))return false;
  }
  return true;
}

function damageCrate(p,damage){
  if(p.type!=="crate" || p.broken)return;
  p.hp=(p.hp==null?100:p.hp)-damage;
  p.hit=.12;
  burst(p.x,p.y-18,"spark");
  if(p.hp<=0){
    p.broken=true;
    p.brokenTimer=0;
    burst(p.x,p.y-14,"explosion");
    camera.shake=5;
  }
}

/* =========================================================
   UPDATE
========================================================= */


/* =========================================================
   FUNK / RADIO – taktische Reaktionen
========================================================= */
let radioCooldown=0;
let lastRadioText="";
function radio(text,force=false){
  if(!("speechSynthesis" in window))return;
  if(!force && radioCooldown>0)return;
  const clean=String(text||"").replace(/\s+/g," ").trim();
  if(!clean || (!force && clean===lastRadioText))return;
  try{
    speechSynthesis.cancel();
    const u=new SpeechSynthesisUtterance(clean);
    u.lang="de-DE";u.rate=.92;u.pitch=.68;u.volume=.42;
    const voices=speechSynthesis.getVoices();
    const german=voices.find(v=>/^de(-|_)/i.test(v.lang));
    if(german)u.voice=german;
    speechSynthesis.speak(u);
    radioCooldown=force?.8:2.8; lastRadioText=clean;
  }catch(e){}
}

let zeroVoiceCooldown=0;
function zeroSpeak(text,force=false){
  if(!("speechSynthesis" in window))return;
  if(!force && zeroVoiceCooldown>0)return;
  const clean=String(text||"").replace(/\s+/g," ").trim();
  if(!clean)return;
  try{
    speechSynthesis.cancel();
    const u=new SpeechSynthesisUtterance(clean);
    u.lang="de-DE";u.rate=.86;u.pitch=.48;u.volume=.58;
    const voices=speechSynthesis.getVoices();
    const male=voices.find(v=>/^de(-|_)/i.test(v.lang) && /male|mann|daniel|markus|thomas|stefan|google deutsch/i.test(v.name));
    const german=voices.find(v=>/^de(-|_)/i.test(v.lang));
    if(male)u.voice=male;else if(german)u.voice=german;
    speechSynthesis.speak(u);
    zeroVoiceCooldown=force?1.2:3.5;
  }catch(e){}
}

function update(dt){
  updateSpecialEffects(dt);
  updateMeleeEffects(dt);
  zeroVoiceCooldown=Math.max(0,zeroVoiceCooldown-dt);
  radioCooldown=Math.max(0,radioCooldown-dt);
  if(cutscene.active){updateCutscene(dt);return;}
  if(!gameRunning||paused)return;


  /*
    Spieler
  */

  player.shootCd=Math.max(0,player.shootCd-dt);
  player.recoil=Math.max(0,(player.recoil||0)-dt);
  player.muzzle=Math.max(0,(player.muzzle||0)-dt);


  if(player.reload>0){

    player.reload-=dt;

    if(player.reload<=0)
      finishReload();
  }


  /*
    Tarnung
  */


  if(player.inv>0)
    player.inv-=dt;


  /*
    Bewegung Joystick
  */

  const mx=touch.move.x, my=touch.move.y;
  const inputLen=Math.hypot(mx,my);
  const dead=.12;
  if(inputLen>dead){
    const nx=mx/inputLen, ny=my/inputLen, speed=300;
    player.vx=nx*speed; player.vy=ny*speed;
    const nextX=player.x+player.vx*dt, nextY=player.y+player.vy*dt;
    if(canMoveTo(nextX,player.y,18))player.x=nextX; else player.vx=0;
    if(canMoveTo(player.x,nextY,22))player.y=nextY; else player.vy=0;
    if(Math.abs(nx)>.08)player.dir=nx>0?1:-1;
    player.walking=true; player.walkPhase+=dt*(8+Math.min(5,inputLen*6));
  }else{
    player.vx*=.72; player.vy*=.72; player.walking=false;
  }
  player.x=clamp(player.x,100,world.width-100);
  player.y=clamp(player.y,390,500);
  if(player.walking&&Math.random()<dt*7)particles.push({x:player.x-rand(-8,8),y:player.y-2,vx:rand(-12,12),vy:rand(-8,2),life:.28,type:"dust"});


  updateCompanion(dt);

  /*
    Zielen
  */

  if(
    Math.hypot(
      player.aimX,
      player.aimY
    )>.1
  ){

    player.dir=
      player.aimX>=0
      ?1
      :-1;
  }


  /*
    Feuer halten
  */

  if(touch.fire)
    shoot();


  /*
    Gegner
  */

  activateVisibleEnemies();

  for(
    const e of enemies
  ){

    updateEnemy(
      e,
      dt
    );
  }


  /*
    Spieler-Projektile
  */

  for(
    let i=bullets.length-1;
    i>=0;
    i--
  ){

    const b=
      bullets[i];

    b.x+=b.vx*dt;
    b.y+=b.vy*dt;

    b.life-=dt;

    let hit=false;

    /* Kisten sind echte Hindernisse und können kaputtgeschossen werden. */
    for(const p of props){
      if(p.type!=="crate" || p.broken)continue;
      if(circleHitsCrate(b.x,b.y,3,p)){
        damageCrate(p,b.damage);
        hit=true;
        break;
      }
    }

    if(hit){
      bullets.splice(i,1);
      continue;
    }

    for(
      const e of enemies
    ){

      if(e.dead)continue;

      const hb=e.hitbox||{head:13,body:30,legs:22,overall:32};
      const headDistance=Math.hypot(b.x-e.x,b.y-(e.y-91));
      const bodyDistance=Math.hypot(b.x-e.x,b.y-(e.y-48));
      const legDistance=Math.hypot(b.x-e.x,b.y-(e.y-16));
      const overallDistance=Math.hypot(b.x-e.x,b.y-(e.y-48));
      const headshot=headDistance<hb.head;
      const legshot=!headshot && legDistance<hb.legs;

      // Jeder Gegner hat eine zuverlässige Körper-Hitbox; der Overall-Fallback verhindert Fehltreffer.
      if(headshot || bodyDistance<hb.body || legshot || overallDistance<hb.overall){

        blacklistSfx&&blacklistSfx(headshot?"headshot":"hit");
        /* Kopfschuss = starker Treffer, aber niemals automatisch tödlich.
           Auch schwere Gegner sollen mehrere gezielte Treffer aushalten. */
        const damage=headshot
          ? Math.min(72,Math.max(38,b.damage*1.55))
          : legshot
            ? Math.max(10,b.damage*.42)
            : b.damage;
        e.hp-=damage;
        e.lastHitZone=headshot?"HEAD":(legshot?"LEGS":"BODY");

        /* ARSENAL-Spezialmunition: jeder direkte Treffer löst den Spezial-Kill aus.
           Die Spezialmunition ist bewusst ein eigener Kill-Typ und hängt nicht von
           der normalen Waffen-Schadensberechnung ab. */
        if(b.specialType && ownedSpecialAmmo.includes(b.specialType) && !e.specialEffectStarted){
          /* Spezialmunition ist ein eigener Kill-Pfad. Sie wird nur einmal ausgelöst. */
          e.hp=0;
          e.specialType=b.specialType;
        }
        e.hitFlash=headshot?.18:.10;

        /* Trefferreaktion: kurzer Stagger + sichtbarer Rückstoß + Alarm. */
        e.flash=.16;
        e.stagger=.16;
        e.knockback=(b.vx>0?1:-1)*Math.min(90,28+b.damage*.35);
        e.state="combat";
        e.alert=2;
        e.shoot=Math.min(e.shoot,.18);

        burst(b.x,b.y,headshot?"death":"blood");
        specialImpact(b,b.x,b.y,e);
        if(headshot){
          for(let k=0;k<7;k++)particles.push({x:e.x,y:e.y-91,vx:rand(-95,95),vy:rand(-110,35),life:.45,type:"blood"});
          showAlert("KOPFSCHUSS · STARKER TREFFER", "red");
        }else if(legshot){
          for(let k=0;k<3;k++)particles.push({x:e.x,y:e.y-16,vx:rand(-55,55),vy:rand(-45,5),life:.30,type:"spark"});
          e.stagger=Math.max(e.stagger||0,.10);
        }else{
          for(let k=0;k<3;k++)particles.push({x:e.x,y:e.y-48,vx:rand(-70,70),vy:rand(-80,10),life:.35,type:"spark"});
        }

        hit=true;

        if(e.hp<=0){
          e.hp=0;
          blacklistSfx&&blacklistSfx("death");
e.dead=true;
          e.fall=0;
          e.fallAngle=(Math.random()<.5?-1:1)*(1.25+Math.random()*.22);
          e.deathDir=Math.random()<.5?-1:1;
          e.weaponDropped=true;
          e.specialType=b.specialType||e.specialType||"";
          if(e.specialType)specialKillStart(e.specialType,e);
          else initRagdoll(e);
          e.knockback=(b.vx>0?1:-1)*85;
          awardCredits(e.type==="heavy"?90:55);
          awardXP(e.type==="heavy"?120:65);
          // Kill-Bonus direkt auf dem Spieler: +5 HP und +10 Schuss.
          player.hp=Math.min(player.maxHp||100,(player.hp||0)+5);
          const killBonusWeapon=getWeapon();
          player.reserve=Math.min(killBonusWeapon.reserve,(player.reserve||0)+10);
          burst(e.x,e.y-35,"death");
        }

        break;
      }
    }


    /*
      Ziel
    */

    if(
      !hit &&
      target &&
      target.alive &&
      Math.hypot(
        b.x-target.x,
        b.y-(target.y-25)
      )<55
    ){

      target.hp-=b.damage;
      specialImpact(b,b.x,b.y,null);

      burst(
        b.x,
        b.y,
        "spark"
      );

      hit=true;

      if(target.hp<=0){

        target.alive=false;

        burst(
          target.x,
          target.y,
          "explosion"
        );

        showAlert(
          "ZIEL ZERSTÖRT",
          "green"
        );
      }
    }


    if(
      hit ||
      b.life<=0 ||
      b.x<0 ||
      b.x>world.width
    ){

      bullets.splice(
        i,
        1
      );
    }
  }


  /*
    Gegner-Projektile
  */

  for(
    let i=enemyBullets.length-1;
    i>=0;
    i--
  ){

    const b=
      enemyBullets[i];

    b.x+=b.vx*dt;
    b.y+=b.vy*dt;

    b.life-=dt;


    if(
      Math.hypot(
        b.x-player.x,
        b.y-(player.y-42)
      )<25
    ){

      if(player.inv<=0){

        player.hp-=b.damage;

        player.inv=.35;

        camera.shake=7;

        document
          .getElementById(
            "damage"
          )
          .style.opacity=.75;

        setTimeout(
          ()=>{
            document
              .getElementById(
                "damage"
              )
              .style.opacity=0;
          },
          120
        );


        if(player.hp<=0)
          loseGame();
      }

      enemyBullets.splice(
        i,
        1
      );

      continue;
    }


    if(
      b.life<=0
    ){

      enemyBullets.splice(
        i,
        1
      );
    }
  }


  /*
    Partikel
  */

  for(
    let i=particles.length-1;
    i>=0;
    i--
  ){

    const p=
      particles[i];

    p.x+=p.vx*dt;
    p.y+=p.vy*dt;

    p.vy+=
      40*dt;

    p.life-=dt;

    if(p.life<=0)
      particles.splice(i,1);
  }


  /*
    Kamera
  */

  camera.x+=
    (
      player.x-
      W*.38-
      camera.x
    )*
    Math.min(
      1,
      dt*4
    );

  camera.x=
    clamp(
      camera.x,
      0,
      world.width-W
    );

  camera.shake*=.90;


  checkObjective();
  updateHUD();
}


/* =========================================================
   OBJECTIVE
========================================================= */

function checkObjective(){

  const m=
    missions[currentLevel];

  const alive=
    enemies.filter(
      e=>!e.dead
    ).length + pendingEnemies.length;


  if(
    m[5]==="clear" &&
    alive===0
  ){

    winGame();
  }


  if(
    m[5]==="target" &&
    target &&
    !target.alive
  ){

    winGame();
  }


  if(
    m[5]==="reach" &&
    player.x>extractX
  ){

    winGame();
  }
}


/* =========================================================
   WIN
========================================================= */

function winGame(){
  if(won)return;won=true;gameRunning=false;awardCredits(150); awardXP(180+currentLevel*25);
  if(currentLevel+1>=unlocked){unlocked=Math.max(unlocked,currentLevel+2);localStorage.setItem("blacklistMobileUnlocked",unlocked)}
  showAlert("MISSION ERFÜLLT","green");
    radio("Funk an Zero. Mission erfüllt. Saubere Arbeit. Extraktion wird vorbereitet.",true);
    zeroSpeak("Mission erledigt. Zeit für die Extraktion.",true);
  const finale=currentLevel===199;
  const endTitle=finale?"KAPITEL 1 · ENDE":"LEVEL "+missions[currentLevel][0]+" · ABSCHLUSS";
  const endText=levelEndTexts[currentLevel]+(finale?"\n\nKAPITEL 1–8 ABGESCHLOSSEN · LEVEL 1–200\n\nBONUS: +150 CREDITS. Die Operation ist beendet.":"\n\nBONUS: +150 CREDITS. Der nächste Einsatz wird freigeschaltet.");
  showCutscene(endTitle,endText,()=>{
    document.getElementById("hud").style.display="none";document.getElementById("mobileControls").style.display="none";document.getElementById("crosshair").style.display="none";document.getElementById("menu").style.display="flex";
    document.querySelector(".sub").textContent="MISSION "+missions[currentLevel][0]+" ABGESCHLOSSEN";document.getElementById("start").textContent=currentLevel<missions.length-1?"NÄCHSTE MISSION":"OPERATION · ENDE";document.getElementById("start").onclick=()=>startGame(Math.min(currentLevel+1,missions.length-1));
  });
}


/* =========================================================
   LOSE
========================================================= */

function loseGame(){
  if(playerDeath.active)return;
  gameRunning=false;
  paused=false;
  playerDeath={active:true,time:0};
  showAlert("AGENT DOWN","red");
  document.getElementById("hud").style.display="none";
  document.getElementById("mobileControls").style.display="none";
  document.getElementById("crosshair").style.display="none";
  document.getElementById("deathScreen").style.display="flex";
  document.getElementById("deathRetry").onclick=()=>{
    document.getElementById("deathScreen").style.display="none";
    playerDeath={active:false,time:0};
    startGame(currentLevel);
  };
  document.getElementById("deathMenu").onclick=()=>{
    document.getElementById("deathScreen").style.display="none";
    playerDeath={active:false,time:0};
    backMenu();
  };
}

/* =========================================================
   HUD
========================================================= */

function updateHUD(){

  if(!player)return;

  const m=
    missions[currentLevel];

  document.getElementById(
    "missionText"
  ).textContent=
    m[0]+" · "+m[1];

  const enemyCount =
    enemies.filter(e=>!e.dead).length +
    pendingEnemies.filter(e=>!e.dead).length;
  const enemyCountText=document.getElementById("enemyCountText");
  if(enemyCountText)enemyCountText.textContent=enemyCount;

  document.getElementById(
    "hpText"
  ).textContent=
    Math.max(
      0,
      Math.ceil(player.hp)
    );

  document.getElementById("ammoText").textContent=meleeWeapon(player.weapon)?"NAHKAMPF":""+(player.reload>0?"...":player.ammo+"/"+player.reserve);
  document.getElementById("weaponText").textContent=player.weapon;
  document.getElementById("creditsText").textContent=credits;
  const lvl=getRankLevel();
  const rank=document.getElementById("rankText");
  if(rank)rank.textContent=`LVL ${lvl} · ${getRankName(lvl)}`;


  let objective=
    m[3];


  if(m[5]==="clear"){

    objective=
      "Gegner: "+
      enemies.filter(
        e=>!e.dead
      ).length + pendingEnemies.length;
  }


  if(m[5]==="reach"){

    objective=
      "Extraktion: "+
      Math.max(
        0,
        Math.ceil(
          extractX-player.x
        )
      )+
      " m";
  }


  if(m[5]==="target"){

    objective=
      target &&
      target.alive
      ?
      "Ziel: "+
      Math.ceil(
        target.hp
      )+
      " HP"
      :
      "ZIEL ZERSTÖRT";
  }


  document.getElementById(
    "objectiveText"
  ).textContent=
    objective;
  const spent=xpSpentBeforeLevel(lvl);
  const current=Math.max(0,playerXP-spent);
  const need=xpForLevel(lvl);
  const pct=lvl>=1000?100:Math.min(100,Math.floor(current/need*100));
  const fill=document.getElementById("hudXpFill"); if(fill)fill.style.width=pct+"%";
  const xt=document.getElementById("hudXpText"); if(xt)xt.textContent=lvl>=1000?"MAX LEVEL · XP "+playerXP:"XP "+current+"/"+need;

  // Boss-Leiste wird jedes Frame mit dem tatsächlich sichtbaren Boss aktualisiert.
  const boss=enemies.find(e=>e.boss&&!e.dead && e.x>=camera.x-5 && e.x<=camera.x+W+5);
  const bossBar=document.getElementById("bossBar");
  if(bossBar){
    if(boss){
      bossBar.style.display="block";
      const bossName=document.getElementById("bossName");
      const bossFill=document.getElementById("bossFill");
      const bossHpText=document.getElementById("bossHpText");
      if(bossName)bossName.textContent="BOSS // "+boss.bossName;
      const pct=Math.max(0,Math.min(100,boss.hp/boss.maxHp*100));
      if(bossFill)bossFill.style.width=pct+"%";
      if(bossHpText)bossHpText.textContent=Math.ceil(boss.hp)+" / "+Math.ceil(boss.maxHp);
    }else{
      bossBar.style.display="none";
    }
  }
}






/* =========================================================
   ALERT
========================================================= */

function showAlert(
  text,
  type
){

  const el=
    document.getElementById(
      "alert"
    );

  el.textContent=text;

  el.style.color=
    type==="red"
    ?" #ff4b54"
    :
    type==="green"
    ?" #6bda91"
    :
    "#e2c74d";

  el.style.display="block";

  clearTimeout(
    alertTimeout
  );

  alertTimeout=
    setTimeout(
      ()=>{
        el.style.display="none";
      },
      1500
    );
}


/* =========================================================
   PARTICLES
========================================================= */

function burst(
  x,
  y,
  type
){

  const count=
    type==="explosion"
    ?60
    :
    type==="death"
    ?25
    :10;


  for(
    let i=0;
    i<count;
    i++
  ){

    const angle=
      Math.random()*
      Math.PI*2;

    const speed=
      rand(
        30,
        type==="explosion"
        ?300
        :150
      );

    particles.push({

      x:x,

      y:y,

      vx:
        Math.cos(angle)*
        speed,

      vy:
        Math.sin(angle)*
        speed,

      life:
        rand(
          .25,
          type==="explosion"
          ?1.2
          :.6
        ),

      type:type
    });
  }
}


/* =========================================================
   DRAW
========================================================= */

function worldX(x){

  return (
    x-camera.x+
    rand(
      -camera.shake,
      camera.shake
    )
  );
}


/* =========================================================
   SKY
========================================================= */

function drawSky(env){

  const theme=levelThemes[currentLevel]||levelThemes[0];
  let gradient=
    ctx.createLinearGradient(
      0,
      0,
      0,
      H
    );


  if(
    env==="NIGHT" ||
    env==="HARBOR"
  ){

    gradient.addColorStop(
      0,
      "#050b16"
    );

    gradient.addColorStop(
      .6,
      "#182934"
    );

    gradient.addColorStop(
      1,
      "#303c3e"
    );

  }else if(
    env==="DESERT"
  ){

    gradient.addColorStop(
      0,
      "#6e7882"
    );

    gradient.addColorStop(
      .6,
      "#aa9d80"
    );

    gradient.addColorStop(
      1,
      "#b58d63"
    );

  }else{

    gradient.addColorStop(
      0,
      "#496977"
    );

    gradient.addColorStop(
      .55,
      "#83989a"
    );

    gradient.addColorStop(
      1,
      "#5b695f"
    );
  }

  // Jeder Level bekommt seine eigene Farbwelt, Atmosphäre und Stimmung.
  gradient.addColorStop(0,theme.sky1);
  gradient.addColorStop(.62,theme.sky2);
  gradient.addColorStop(1,theme.ground);

  ctx.fillStyle=
    gradient;

  ctx.fillRect(
    0,
    0,
    W,
    H
  );


  /*
    Sonne / Mond
  */

  ctx.globalAlpha=.2;

  ctx.fillStyle="#eee1aa";

  ctx.beginPath();

  ctx.arc(
    W*.78,
    100,
    55,
    0,
    Math.PI*2
  );

  ctx.fill();

  ctx.globalAlpha=1;


  /*
    Berge
  */

  ctx.fillStyle=
    env==="DESERT"
    ?"#806c58"
    :"#34484e";

  ctx.beginPath();

  ctx.moveTo(
    0,
    350
  );


  for(
    let x=0;
    x<=W;
    x+=120
  ){

    const y=
      280+
      Math.sin(
        (x+camera.x*.12)*
        .006
      )*55;

    ctx.lineTo(
      x,
      y
    );
  }

  ctx.lineTo(
    W,
    450
  );

  ctx.lineTo(
    0,
    450
  );

  ctx.fill();
  // Level-spezifische Atmosphäre / Silhouetten
  ctx.save();
  ctx.globalAlpha=.32;
  if(theme.detail==='PINE' || theme.detail==='JUNGLE'){
    ctx.fillStyle='#15251e';
    for(let x=-80-(camera.x*.12%180);x<W+180;x+=180){
      ctx.beginPath();ctx.moveTo(x,365);ctx.lineTo(x+45,250);ctx.lineTo(x+90,365);ctx.closePath();ctx.fill();
    }
  }
  if(theme.detail==='CITY' || theme.detail==='BASE' || theme.detail==='LAB' || theme.detail==='GHOST' || theme.detail==='ZERO' || theme.detail==='FINAL'){
    ctx.fillStyle='#11171b';
    for(let x=-100-(camera.x*.08%150);x<W+150;x+=150){
      const h=70+((x*17)%70+70)%70;
      ctx.fillRect(x,390-h,105,h);
      ctx.fillStyle=theme.accent;ctx.globalAlpha=.12;
      for(let wy=0;wy<3;wy++)ctx.fillRect(x+18+wy*25,405-h,10,18);
      ctx.fillStyle='#11171b';ctx.globalAlpha=.32;
    }
  }
  if(theme.detail==='HARBOR' || theme.detail==='WAREHOUSE' || theme.detail==='FACTORY' || theme.detail==='IRON'){
    ctx.strokeStyle=theme.accent;ctx.globalAlpha=.22;ctx.lineWidth=3;
    for(let x=-60-(camera.x*.2%220);x<W+220;x+=220){ctx.beginPath();ctx.moveTo(x,390);ctx.lineTo(x+120,300);ctx.stroke();}
  }
  if(theme.weather==='rain'){
    ctx.strokeStyle='#b7cbd0';ctx.globalAlpha=.16;ctx.lineWidth=1;
    for(let i=0;i<80;i++){const x=(i*97+camera.x*.45)%W;const y=(i*53)%390;ctx.beginPath();ctx.moveTo(x,y);ctx.lineTo(x-7,y+24);ctx.stroke();}
  }
  if(theme.weather==='snow'){
    ctx.fillStyle='#e3ecee';ctx.globalAlpha=.55;
    for(let i=0;i<55;i++){const x=(i*83+camera.x*.12)%W;const y=(i*47)%390;ctx.beginPath();ctx.arc(x,y,1.5+(i%3),0,Math.PI*2);ctx.fill();}
  }
  if(theme.weather==='mist' || theme.weather==='smoke'){
    const g=ctx.createLinearGradient(0,250,0,430);g.addColorStop(0,'transparent');g.addColorStop(1,'#b8c7c522');ctx.fillStyle=g;ctx.globalAlpha=theme.fog+.08;ctx.fillRect(0,210,W,230);
  }
  if(theme.weather==='dust' || theme.weather==='wind'){
    ctx.strokeStyle=theme.accent;ctx.globalAlpha=.12;ctx.lineWidth=2;
    for(let i=0;i<20;i++){const y=280+i*7;const x=(i*137-camera.x*.3)%W;ctx.beginPath();ctx.moveTo(x,y);ctx.lineTo(x+80,y+3);ctx.stroke();}
  }
  ctx.restore();
}


/* =========================================================
   WORLD
========================================================= */


function drawMissionSet(env){
  const theme=levelThemes[currentLevel]||levelThemes[0];
  const offset=(camera.x*0.35)%220;
  ctx.save();
  ctx.globalAlpha=.8;

  if(env==="HARBOR"){
    ctx.strokeStyle="#4d676d"; ctx.lineWidth=4;
    for(let x=-220-offset;x<W+220;x+=220){
      ctx.strokeRect(x,250,120,110);
      ctx.beginPath();ctx.moveTo(x+10,250);ctx.lineTo(x+110,360);ctx.stroke();
      ctx.fillStyle="#9a7145";ctx.fillRect(x+28,320,62,9);
    }
  }else if(env==="BASE"){
    ctx.fillStyle="#263238";
    for(let x=-180-offset;x<W+200;x+=260){
      ctx.fillRect(x,285,180,105);
      ctx.fillStyle="#3e4b4f";ctx.fillRect(x+12,300,156,12);
      ctx.fillStyle="#6d7472";ctx.fillRect(x+25,330,32,35);ctx.fillRect(x+72,330,32,35);ctx.fillRect(x+119,330,32,35);
      ctx.fillStyle="#263238";
    }
  }else if(env==="FACTORY" || env==="LAB"){
    ctx.strokeStyle="#596367";ctx.lineWidth=5;
    for(let x=-160-offset;x<W+180;x+=210){
      ctx.beginPath();ctx.moveTo(x,390);ctx.lineTo(x+40,270);ctx.lineTo(x+80,390);ctx.stroke();
      ctx.fillStyle="#384246";ctx.fillRect(x+88,285,70,105);
    }
  }else if(env==="CITY"){
    ctx.fillStyle="#1b2529";
    for(let x=-200-offset;x<W+200;x+=180){
      const h=120+((Math.abs(Math.floor(x))+currentLevel*37)%61); ctx.fillRect(x,390-h,125,h);
      ctx.fillStyle="#65757a";for(let yy=405-h;yy<380;yy+=25)for(let xx=x+15;xx<x+110;xx+=25)ctx.fillRect(xx,yy,10,8);
      ctx.fillStyle="#1b2529";
    }
  }else if(env==="WALD"){
    ctx.fillStyle="#1a2d23";
    for(let x=-160-offset;x<W+160;x+=140){
      ctx.fillRect(x+45,300,12,90);ctx.beginPath();ctx.moveTo(x+50,210);ctx.lineTo(x,335);ctx.lineTo(x+100,335);ctx.closePath();ctx.fill();
    }
  }else if(env==="AIRPORT"){
    ctx.fillStyle="#414b4e";ctx.fillRect(0,350,W,18);
    ctx.strokeStyle="#9ba5a6";ctx.lineWidth=3;
    for(let x=-100-offset;x<W+100;x+=180){ctx.beginPath();ctx.moveTo(x,365);ctx.lineTo(x+90,350);ctx.stroke();}
  }else if(env==="DESERT" || env==="STEPPE"){
    ctx.fillStyle="#8a7659";
    for(let x=-100-offset;x<W+100;x+=170){ctx.beginPath();ctx.arc(x,380,45,Math.PI,Math.PI*2);ctx.fill();}
  }else if(env==="MOUNTAIN"){
    ctx.fillStyle="#53656a";
    for(let x=-100-offset;x<W+100;x+=250){ctx.beginPath();ctx.moveTo(x,390);ctx.lineTo(x+110,220);ctx.lineTo(x+230,390);ctx.closePath();ctx.fill();}
  }else if(env==="METRO"){
    ctx.fillStyle="#11171b";ctx.fillRect(0,95,W,295);
    ctx.fillStyle="#2b3539";ctx.fillRect(0,335,W,55);
    ctx.strokeStyle="#65757a";ctx.lineWidth=4;for(let x=-offset;x<W+180;x+=180){ctx.strokeRect(x,135,145,155);ctx.fillStyle="#152027";ctx.fillRect(x+12,150,121,58);ctx.fillStyle="#65757a";ctx.fillRect(x+12,150,121,5);ctx.fillStyle="#2b3539";}
    ctx.strokeStyle="#8a9ba0";ctx.lineWidth=3;for(let x=-offset;x<W+100;x+=100){ctx.beginPath();ctx.moveTo(x,95);ctx.lineTo(x+35,335);ctx.stroke();}
  }else if(env==="SNOWBASE"){
    ctx.fillStyle="#dce5e7";ctx.fillRect(0,300,W,90);ctx.fillStyle="#59676c";for(let x=-offset;x<W+220;x+=220){ctx.fillRect(x,190,165,170);ctx.fillStyle="#8fa0a4";ctx.fillRect(x+12,205,141,15);ctx.fillStyle="#59676c";ctx.fillRect(x+30,255,45,70);ctx.fillRect(x+90,255,45,70);}
    ctx.strokeStyle="#cfe3e8";ctx.lineWidth=5;for(let x=-offset;x<W+100;x+=100){ctx.beginPath();ctx.moveTo(x,340);ctx.lineTo(x+60,250);ctx.stroke();}
  }else if(env==="DAM"){
    ctx.fillStyle="#30383b";ctx.fillRect(0,190,W,200);ctx.fillStyle="#4a5559";for(let x=-offset;x<W+260;x+=260){ctx.fillRect(x,155,190,235);ctx.fillStyle="#667377";ctx.fillRect(x+15,175,160,10);ctx.fillStyle="#4a5559";}
    ctx.fillStyle="#20282b";ctx.fillRect(W*.66,125,95,260);ctx.fillStyle="#d44a4e";ctx.fillRect(W*.69,150,38,205);ctx.fillStyle="#141a1d";ctx.fillRect(W*.74,150,4,205);
  }
  ctx.restore();
}

function drawFinaleMap(){
  const lvl=currentLevel, t=performance.now()/1000, scroll=(camera.x*.22)%320;
  ctx.save();
  if(lvl===25){
    ctx.fillStyle="#151b20";ctx.fillRect(0,0,W,390);ctx.fillStyle="#252e33";ctx.fillRect(0,45,W,300);ctx.strokeStyle="#53636a";ctx.lineWidth=7;ctx.strokeRect(18,38,W-36,325);
    for(let x=-40-scroll;x<W+120;x+=190){ctx.fillStyle="#07151c";ctx.fillRect(x,82,142,155);ctx.strokeStyle="#78909a";ctx.lineWidth=4;ctx.strokeRect(x,82,142,155);ctx.fillStyle="#315968";ctx.globalAlpha=.45;ctx.fillRect(x+8,91,126,137);ctx.globalAlpha=1;ctx.strokeStyle="#4f6871";ctx.lineWidth=3;ctx.beginPath();ctx.moveTo(x+71,84);ctx.lineTo(x+71,235);ctx.stroke();}
    ctx.fillStyle="#3b4549";ctx.fillRect(0,345,W,42);ctx.fillStyle="#68757a";ctx.fillRect(0,338,W,7);ctx.strokeStyle="#8d9a9d";ctx.lineWidth=3;for(let x=-20-scroll;x<W+80;x+=120){ctx.beginPath();ctx.moveTo(x,345);ctx.lineTo(x+25,250);ctx.stroke();}
    ctx.fillStyle="#0b1115";ctx.fillRect(0,390,W,H-390);ctx.fillStyle="#39454a";ctx.fillRect(0,455,W,120);ctx.fillStyle="#20272b";ctx.fillRect(0,575,W,H-575);ctx.fillStyle="#a7b4b7";ctx.globalAlpha=.55;for(let x=-scroll;x<W;x+=120)ctx.fillRect(x,515,70,3);ctx.globalAlpha=1;ctx.fillStyle="#bd3b42";ctx.beginPath();ctx.arc(W-48,58,6+Math.sin(t*4)*2,0,Math.PI*2);ctx.fill();
  } else if(lvl===26 || lvl===27){
    ctx.fillStyle="#071b27";ctx.fillRect(0,360,W,H-360);ctx.strokeStyle="#2d6d7e";ctx.lineWidth=3;for(let y=390;y<H;y+=26){ctx.beginPath();ctx.moveTo(0,y+Math.sin(t+y)*3);ctx.lineTo(W,y);ctx.stroke();}
    ctx.fillStyle="#343c40";ctx.fillRect(0,382,W,H-382);ctx.fillStyle="#566066";ctx.fillRect(0,382,W,8);
    const cs=["#46555b","#5b4a3c","#394f59","#4d3e43"];let i=0;for(let x=-scroll-160;x<W+260;x+=170){ctx.fillStyle=cs[i++%cs.length];ctx.fillRect(x,265,145,105);ctx.strokeStyle="#87949a";ctx.lineWidth=2;ctx.strokeRect(x,265,145,105);ctx.strokeStyle="#263137";for(let k=1;k<6;k++){ctx.beginPath();ctx.moveTo(x+k*24,270);ctx.lineTo(x+k*24,365);ctx.stroke();}}
    ctx.fillStyle="#1e292e";ctx.fillRect(W*.72,120,170,160);ctx.fillStyle="#33454c";ctx.fillRect(W*.76,85,105,65);ctx.strokeStyle="#74858a";ctx.lineWidth=5;ctx.beginPath();ctx.moveTo(W*.72,120);ctx.lineTo(W*.9,55);ctx.lineTo(W*.96,55);ctx.stroke();ctx.strokeStyle="#9aa4a6";ctx.lineWidth=3;ctx.beginPath();ctx.moveTo(0,405);ctx.lineTo(W,405);ctx.stroke();for(let x=-scroll%80;x<W;x+=80){ctx.beginPath();ctx.moveTo(x,405);ctx.lineTo(x,382);ctx.stroke();}
  } else if(lvl===28){
    ctx.fillStyle="#202629";ctx.fillRect(0,350,W,225);ctx.fillStyle="#d9d3a2";for(let x=-scroll;x<W+180;x+=180)ctx.fillRect(x,500,90,7);ctx.strokeStyle="#777f80";ctx.lineWidth=4;ctx.beginPath();ctx.moveTo(0,455);ctx.lineTo(W,455);ctx.stroke();ctx.fillStyle="#323b3e";ctx.fillRect(0,245,220,120);ctx.fillRect(W-230,220,230,145);ctx.fillStyle="#9da8aa";for(let x=30;x<W;x+=95){ctx.fillRect(x,410,5,35);ctx.beginPath();ctx.arc(x+2,408,7,0,Math.PI*2);ctx.fill();}
    const px=W*.66,py=235+Math.sin(t*.8)*3;ctx.fillStyle="#b8c0c1";ctx.beginPath();ctx.ellipse(px,py,155,30,0,0,Math.PI*2);ctx.fill();ctx.beginPath();ctx.moveTo(px-25,py);ctx.lineTo(px-120,py+65);ctx.lineTo(px-45,py+55);ctx.lineTo(px+15,py+8);ctx.closePath();ctx.fill();ctx.beginPath();ctx.moveTo(px+35,py);ctx.lineTo(px+125,py-48);ctx.lineTo(px+80,py+4);ctx.closePath();ctx.fill();ctx.fillStyle="#27363c";ctx.beginPath();ctx.ellipse(px+125,py,24,18,0,0,Math.PI*2);ctx.fill();
    const carX=((t*115)%(W+240))-120;ctx.fillStyle="#12181b";ctx.fillRect(carX,438,72,24);ctx.fillStyle="#6d777a";ctx.fillRect(carX+12,426,38,15);ctx.fillStyle="#080b0d";ctx.beginPath();ctx.arc(carX+14,463,10,0,Math.PI*2);ctx.arc(carX+58,463,10,0,Math.PI*2);ctx.fill();
  } else if(lvl===29){
    ctx.fillStyle="#161d22";ctx.fillRect(0,0,W,390);ctx.fillStyle="#3c474c";ctx.fillRect(0,55,W,40);ctx.fillStyle="#11171b";ctx.fillRect(0,95,W,285);
    for(let x=-scroll;x<W+140;x+=155){ctx.fillStyle="#31566a";ctx.fillRect(x+20,125,105,82);ctx.strokeStyle="#7e969f";ctx.lineWidth=5;ctx.strokeRect(x+20,125,105,82);ctx.fillStyle="#8ea7b0";ctx.globalAlpha=.35;ctx.fillRect(x+25,130,95,32);ctx.globalAlpha=1;}
    for(let x=-scroll;x<W+100;x+=110){ctx.fillStyle="#4b2026";ctx.fillRect(x+8,235,42,105);ctx.fillRect(x+60,235,42,105);ctx.fillStyle="#6a3038";ctx.fillRect(x+12,250,34,48);ctx.fillRect(x+64,250,34,48);ctx.fillStyle="#8b9699";ctx.fillRect(x+8,340,42,8);ctx.fillRect(x+60,340,42,8);}
    ctx.fillStyle="#252e33";ctx.fillRect(0,365,W,25);ctx.fillStyle="#d54a50";ctx.beginPath();ctx.arc(35,75,6+Math.sin(t*5)*2,0,Math.PI*2);ctx.fill();ctx.fillStyle="#0b1115";ctx.fillRect(0,390,W,H-390);ctx.fillStyle="#323b3e";ctx.fillRect(0,475,W,100);
  } else if(lvl===30){
    ctx.fillStyle="#0b1014";ctx.fillRect(0,0,W,390);ctx.fillStyle="#273238";ctx.fillRect(0,55,W,30);ctx.fillStyle="#11171b";ctx.fillRect(0,85,W,300);
    for(let x=-scroll;x<W+160;x+=160){ctx.fillStyle="#182126";ctx.fillRect(x,120,135,190);ctx.strokeStyle="#718188";ctx.lineWidth=3;ctx.strokeRect(x,120,135,190);ctx.fillStyle="#8aa0a6";ctx.fillRect(x+12,135,111,52);ctx.fillStyle="#273238";ctx.fillRect(x+20,210,95,55);ctx.fillStyle="#b5c2c5";ctx.fillRect(x+35,292,65,5);}
    ctx.fillStyle="#46545a";ctx.fillRect(0,350,W,40);ctx.fillStyle="#9ba7aa";ctx.fillRect(0,345,W,5);
  } else if(lvl===31){
    ctx.fillStyle="#0a0f13";ctx.fillRect(0,0,W,390);ctx.fillStyle="#222d32";ctx.fillRect(0,110,W,280);ctx.strokeStyle="#607178";ctx.lineWidth=4;for(let x=-scroll;x<W+180;x+=180){ctx.strokeRect(x,135,150,145);ctx.fillStyle="#3b555f";ctx.fillRect(x+12,150,126,55);ctx.fillStyle="#222d32";ctx.fillRect(x+12,225,126,32);ctx.fillStyle="#8da0a5";ctx.fillRect(x+25,300,100,5);}
    ctx.fillStyle="#38464b";ctx.fillRect(0,345,W,45);ctx.strokeStyle="#a4b2b5";ctx.lineWidth=2;for(let x=-scroll;x<W;x+=90){ctx.beginPath();ctx.moveTo(x,345);ctx.lineTo(x+35,390);ctx.stroke();}
  } else if(lvl===32){
    ctx.fillStyle="#d7e1e3";ctx.fillRect(0,0,W,390);ctx.fillStyle="#596a70";ctx.fillRect(0,105,W,285);ctx.fillStyle="#263137";for(let x=-scroll;x<W+220;x+=220){ctx.fillRect(x,150,175,190);ctx.fillStyle="#789096";ctx.fillRect(x+18,170,139,12);ctx.fillStyle="#263137";ctx.fillRect(x+35,210,105,85);ctx.fillStyle="#263137";}
    ctx.fillStyle="#f2f7f8";for(let i=0;i<70;i++){const x=(i*97+camera.x*.2)%W,y=(i*53)%360;ctx.beginPath();ctx.arc(x,y,1+(i%3),0,Math.PI*2);ctx.fill();}
  } else if(lvl===33){
    ctx.fillStyle="#1b2225";ctx.fillRect(0,0,W,390);ctx.fillStyle="#4c3a3b";ctx.fillRect(0,90,W,290);ctx.fillStyle="#31393c";for(let x=-scroll;x<W+260;x+=260){ctx.fillRect(x,145,200,235);ctx.fillStyle="#5a6568";ctx.fillRect(x+18,165,164,10);ctx.fillStyle="#31393c";}
    ctx.fillStyle="#9b3037";ctx.fillRect(W*.72,110,8,260);ctx.fillStyle="#d44a4e";ctx.globalAlpha=.7;ctx.beginPath();ctx.arc(W*.72,120,24+Math.sin(t*4)*5,0,Math.PI*2);ctx.fill();ctx.globalAlpha=1;
  }
  ctx.restore();
}

function drawWorld(env){

  drawMissionSet(env);

  const ground=
    ctx.createLinearGradient(
      0,
      390,
      0,
      H
    );

  const theme=levelThemes[currentLevel]||levelThemes[0];
  ground.addColorStop(
    0,
    theme.ground
  );

  ground.addColorStop(
    1,
    "#202628"
  );

  ctx.fillStyle=
    ground;

  ctx.fillRect(
    0,
    390,
    W,
    H-390
  );

  // Spezial-/Story-Maps liegen bewusst ÜBER dem generischen Bodenlayer.
  drawFinaleMap();

  /*
    Straße
  */

  if(currentLevel<25){
    ctx.fillStyle="#3d4141";ctx.fillRect(0,475,W,100);


    ctx.fillStyle="#1f2425";ctx.fillRect(0,575,W,H-575);


  /*
    Straßenlinien
  */

  ctx.strokeStyle=
    "#b2a86f";

  ctx.lineWidth=3;

  for(
    let x=
      -camera.x%130;
    x<W;
    x+=130
  ){

    ctx.beginPath();

    ctx.moveTo(
      x,
      530
    );

    ctx.lineTo(
      x+65,
      530
    );

    ctx.stroke();
  }
  }


  /*
    Objekte
  */

  for(
    const p of props
  ){

    const x=
      p.x-camera.x;

    if(
      x<-250 ||
      x>W+250
    )continue;


    if(
      p.type==="building"
    ){

      drawBuilding(
        x,
        p.y,
        p.w,
        p.h
      );
    }


    if(
      p.type==="tree"
    ){

      drawTree(
        x,
        p.y,
        p.s
      );
    }


    if(
      p.type==="rock"
    ){

      drawRock(
        x,
        p.y,
        p.s
      );
    }


    if(p.type==="crate" && !p.broken){
      drawCrate(x,p.y,p.s,p.hp==null?100:p.hp);
    }
    if(p.type==="crate" && p.broken){
      ctx.save();
      ctx.globalAlpha=.55;
      ctx.fillStyle="#3a2b20";
      ctx.fillRect(x-18,p.y-7,36,7);
      ctx.restore();
    }
  }


  /*
    Extraktion
  */

  if(
    missions[currentLevel][5]
    ==="reach"
  ){

    const x=
      extractX-camera.x;

    ctx.fillStyle=
      "#5fc78822";

    ctx.fillRect(
      x-70,
      380,
      140,
      160
    );

    ctx.strokeStyle=
      "#62c987";

    ctx.lineWidth=3;

    ctx.strokeRect(
      x-70,
      380,
      140,
      160
    );

    ctx.fillStyle=
      "#72dc91";

    ctx.font=
      "bold 12px Arial";

    ctx.textAlign=
      "center";

    ctx.fillText(
      "EXTRAKTION",
      x,
      370
    );
  }


  /*
    Ziel
  */

  if(
    target &&
    target.alive
  ){

    drawTarget(
      target.x-camera.x,
      target.y
    );
  }
}


/* =========================================================
   BUILDING
========================================================= */

function drawBuilding(x,y,w,h){
  const groundY=390,baseY=groundY,topY=baseY-h;
  const seed=Math.abs(Math.floor(x*.173+w*1.37+h*2.11));
  const palettes=[
    ["#11181c","#273338","#3a474b"],
    ["#151a1d","#30393d","#4a5559"],
    ["#10161a","#252f34","#39464b"],
    ["#171a1d","#343b3f","#4a5053"]
  ];
  const pal=palettes[seed%palettes.length];
  ctx.save();

  // Bodenfundament: das Haus endet exakt an der Bodenlinie und wirkt dadurch
  // nicht schwebend.
  ctx.fillStyle="#080c0e";
  ctx.fillRect(x-5,baseY-12,w+10,16);
  ctx.fillStyle="#070a0c99";
  ctx.beginPath();ctx.ellipse(x+w*.5,baseY+3,w*.55,8,0,0,Math.PI*2);ctx.fill();

  ctx.fillStyle=pal[0];ctx.fillRect(x,topY,w,h);
  ctx.fillStyle=pal[1];ctx.fillRect(x+6,topY+6,w-12,h-20);

  // Dachkante.
  ctx.fillStyle=pal[2];ctx.fillRect(x-4,topY-5,w+8,7);

  // Fassadenstreben.
  const sections=Math.max(2,Math.floor(w/52));
  for(let c=1;c<sections;c++){
    ctx.fillStyle="#0c1215";
    ctx.fillRect(x+(w/sections)*c,topY+5,3,h-24);
  }

  // Fenster: deterministische Positionen, kein Flackern.
  const cols=Math.max(2,Math.floor((w-22)/30));
  const rows=Math.max(2,Math.floor((h-30)/31));
  for(let r=0;r<rows;r++)for(let c=0;c<cols;c++){
    const wx=x+13+c*30,wy=topY+18+r*31;
    if(wx+16>x+w-8||wy+16>baseY-22)continue;
    const lit=((seed+r*17+c*31)%11)<2;
    ctx.fillStyle=lit?"#d7b86a":"#46565c";
    ctx.fillRect(wx,wy,15,17);
    ctx.fillStyle="#172024";
    ctx.fillRect(wx+7,wy,2,17);ctx.fillRect(wx,wy+7,15,2);
    if(lit){
      ctx.globalAlpha=.12;ctx.fillStyle="#ffd978";
      ctx.fillRect(wx-3,wy-3,21,23);ctx.globalAlpha=1;
    }
  }

  // Tür bis zum Boden.
  const dw=Math.max(20,Math.min(30,w*.13));
  const dh=Math.max(42,Math.min(62,h*.25));
  const dx=x+w*.5-dw*.5;
  ctx.fillStyle="#080d10";ctx.fillRect(dx,baseY-dh,dw,dh);
  ctx.fillStyle="#59676b";ctx.fillRect(dx+3,baseY-dh+4,dw-6,3);
  ctx.fillStyle="#b99a59";ctx.fillRect(dx+dw-6,baseY-dh*.5,3,3);

  // Dachaufbauten.
  if(seed%3===0){
    ctx.fillStyle="#0b1114";ctx.fillRect(x+w*.58,topY-18,30,14);
    ctx.fillStyle="#657176";ctx.fillRect(x+w*.58+5,topY-22,20,4);
  }else if(seed%3===1){
    ctx.strokeStyle="#66767b";ctx.lineWidth=2;
    ctx.beginPath();ctx.moveTo(x+w*.78,topY-4);ctx.lineTo(x+w*.78,topY-31);ctx.stroke();
    ctx.fillStyle="#d34b54";ctx.beginPath();ctx.arc(x+w*.78,topY-34,2.5,0,Math.PI*2);ctx.fill();
  }

  if(seed%4===0&&w>145){
    ctx.strokeStyle="#59676b";ctx.lineWidth=3;
    ctx.strokeRect(x+w*.68,topY+h*.43,34,20);
    ctx.beginPath();ctx.moveTo(x+w*.68,topY+h*.43+10);ctx.lineTo(x+w*.68+34,topY+h*.43+10);ctx.stroke();
  }

  ctx.restore();
}

/* =========================================================
   TREE
========================================================= */

function drawTree(
  x,
  y,
  s
){
  ctx.save();
  ctx.translate(x,y);
  ctx.scale(s,s);

  ctx.fillStyle="#1b211d";
  ctx.fillRect(-8,-65,16,65);

  /* Ruhige, feste Blätterpositionen: keine Zufallsbewegung pro Frame mehr. */
  const leaves=[
    [-23,-86,27],[-2,-104,31],[22,-88,27],[-31,-66,23],
    [2,-70,29],[31,-67,22],[-10,-124,22],[16,-119,20]
  ];
  const colors=["#253a2d","#2d4934","#38563c"];
  for(let i=0;i<leaves.length;i++){
    const q=leaves[i];
    ctx.fillStyle=colors[i%colors.length];
    ctx.beginPath();ctx.arc(q[0],q[1],q[2],0,Math.PI*2);ctx.fill();
  }
  ctx.restore();
}


/* =========================================================
   ROCK
========================================================= */

function drawRock(
  x,
  y,
  s
){

  ctx.save();

  ctx.translate(
    x,
    y
  );

  ctx.scale(
    s,
    s
  );

  ctx.fillStyle=
    "#303638";

  ctx.beginPath();

  ctx.moveTo(
    -30,
    0
  );

  ctx.lineTo(
    -18,
    -25
  );

  ctx.lineTo(
    8,
    -32
  );

  ctx.lineTo(
    32,
    -12
  );

  ctx.lineTo(
    24,
    0
  );

  ctx.closePath();

  ctx.fill();

  ctx.restore();
}


/* =========================================================
   CRATE
========================================================= */

function drawCrate(
  x,
  y,
  s,
  hp=100
){

  ctx.save();

  ctx.translate(
    x,
    y
  );

  ctx.scale(
    s,
    s
  );

  ctx.fillStyle=
    "#654c31";

  ctx.fillRect(
    -20,
    -28,
    40,
    28
  );

  ctx.strokeStyle=
    "#94704a";

  ctx.lineWidth=3;

  ctx.strokeRect(
    -20,
    -28,
    40,
    28
  );

  ctx.beginPath();

  ctx.moveTo(
    -20,
    -28
  );

  ctx.lineTo(
    20,
    0
  );

  ctx.moveTo(
    20,
    -28
  );

  ctx.lineTo(
    -20,
    0
  );

  ctx.stroke();

  if(hp<100){
    ctx.strokeStyle="#241b16";
    ctx.lineWidth=2;
    ctx.beginPath();
    ctx.moveTo(-12,-22);ctx.lineTo(-2,-12);ctx.lineTo(-9,-3);
    if(hp<55){ctx.moveTo(8,-26);ctx.lineTo(2,-15);ctx.lineTo(12,-6);}
    ctx.stroke();
  }

  ctx.restore();
}


/* =========================================================
   TARGET
========================================================= */

function drawTarget(
  x,
  y
){

  ctx.fillStyle=
    "#151a1b";

  ctx.fillRect(
    x-55,
    y-45,
    110,
    65
  );

  ctx.fillStyle=
    "#394143";

  ctx.fillRect(
    x-48,
    y-38,
    96,
    55
  );

  ctx.fillStyle=
    "#aa3032";

  ctx.fillRect(
    x-35,
    y-25,
    70,
    25
  );

  ctx.fillStyle=
    "#eee";

  ctx.font=
    "bold 9px Arial";

  ctx.textAlign=
    "center";

  ctx.fillText(
    "PRIMARY TARGET",
    x,
    y-30
  );
}


/* =========================================================
   HUMAN
========================================================= */

function drawHuman(x,y,dir,enemy,camo=false,phase=0,walking=false,weaponName="PISTOLE",recoil=0,deathPose=0,drawShadow=true){
  const diamondSkin=(!enemy && equippedOutfit==="DIAMONDREACTIVE");

  ctx.save();
  ctx.translate(x,y);
  ctx.scale(dir,1);

  const outfit=enemy?"TACTICAL":(player?.outfit||"TACTICAL");
  const swing=walking?Math.sin(phase)*.32:0;
  const bob=walking?Math.abs(Math.sin(phase))*1.5:0;
  ctx.translate(0,-bob+deathPose*10);

  /* Schatten */
  if(drawShadow && deathPose<.95){
    ctx.fillStyle="#0009";
    ctx.beginPath();ctx.ellipse(0,5,27,7,0,0,Math.PI*2);ctx.fill();
  }

  /* Beine – schlanker, menschlicher proportioniert. In der Todesanimation
     beugen sich die Knie sichtbar, bevor der Körper nach vorn/hinten fällt. */
  const pants=outfit==="DIAMONDREACTIVE"&&!enemy?"#d9fbff":outfit==="EXECUTIVE"&&!enemy?"#17191a":outfit==="URBAN"&&!enemy?"#4d575a":outfit==="DESERT"&&!enemy?"#75664b":outfit==="RECON"&&!enemy?"#26352d":outfit==="BLACKOPS"&&!enemy?"#111416":outfit==="D-WOLF"&&!enemy?"#6f6047":outfit==="FROSTGUARD"&&!enemy?"#c3ced1":outfit==="GOLDFANG"&&!enemy?"#292421":outfit==="STORMBREAKER"&&!enemy?"#28343a":outfit==="APEXZERO"&&!enemy?"#161b20":"#1a2022";
  ctx.strokeStyle=pants;ctx.lineWidth=9;ctx.lineCap="round";
  if(deathPose>.05){
    const k=Math.min(1,deathPose);
    ctx.save();
    ctx.beginPath();ctx.moveTo(-8,-29);ctx.lineTo(-16,-12+8*k);ctx.lineTo(-22,0+3*k);ctx.stroke();
    ctx.beginPath();ctx.moveTo(8,-29);ctx.lineTo(16,-12+8*k);ctx.lineTo(22,0+3*k);ctx.stroke();
    ctx.restore();
    ctx.strokeStyle="#0b0f10";ctx.lineWidth=6;ctx.beginPath();
    ctx.moveTo(-22,0+3*k);ctx.lineTo(-31,1+3*k);
    ctx.moveTo(22,0+3*k);ctx.lineTo(31,1+3*k);ctx.stroke();
  }else{
    ctx.save();ctx.translate(-8,-29);ctx.rotate(-swing);ctx.beginPath();ctx.moveTo(0,0);ctx.lineTo(-4,27);ctx.stroke();ctx.restore();
    ctx.save();ctx.translate(8,-29);ctx.rotate(swing);ctx.beginPath();ctx.moveTo(0,0);ctx.lineTo(4,27);ctx.stroke();ctx.restore();
    ctx.strokeStyle="#0b0f10";ctx.lineWidth=6;ctx.beginPath();ctx.moveTo(-11,-3);ctx.lineTo(-20,-2);ctx.moveTo(11,-3);ctx.lineTo(20,-2);ctx.stroke();
  }

  /* Torso – weniger breit, mit klarer Taille */
  let torso="#263034",vest="#111719";
  if(outfit==="GHOST"&&!enemy){torso="#182127";vest="#0b1013"}
  else if(outfit==="EXECUTIVE"&&!enemy){torso="#16181a";vest="#23282a"}
  else if(outfit==="URBAN"&&!enemy){torso="#4b5558";vest="#252c2f"}
  else if(outfit==="DESERT"&&!enemy){torso="#77694e";vest="#3f392c"}
  else if(outfit==="RECON"&&!enemy){torso="#31443a";vest="#16231c"}
  else if(outfit==="BLACKOPS"&&!enemy){torso="#111416";vest="#242a2c"}
  else if(outfit==="JICKENWINGPRIME"&&!enemy){torso="#4b3529";vest="#2a211d"}
  else if(outfit==="DEVILMARKER"&&!enemy){torso="#111416";vest="#181b1e"}
  else if(outfit==="D-WOLF"&&!enemy){torso="#8b795b";vest="#171b1b"}
  else if(outfit==="DIAMONDREACTIVE"&&!enemy){torso="#c8f8ff";vest="#6dd8e8"}
  else if(outfit==="NEONRAID"&&!enemy){torso="#202a2d";vest="#17434b"}
  else if(outfit==="FROSTGUARD"&&!enemy){torso="#c5d0d3";vest="#6d7e84"}
  else if(outfit==="NIGHTVIPER"&&!enemy){torso="#10181d";vest="#152127"}
  else if(outfit==="REDSENTINEL"&&!enemy){torso="#211719";vest="#3b2025"}
  else if(outfit==="GOLDFANG"&&!enemy){torso="#2b2520";vest="#574526"}
  else if(outfit==="PHANTOMZERO"&&!enemy){torso="#15191e";vest="#252b32"}
  else if(outfit==="STORMBREAKER"&&!enemy){torso="#28343a";vest="#172126"}
  else if(outfit==="HAZARD"&&!enemy){torso="#3c3323";vest="#25241f"}
  else if(outfit==="APEXZERO"&&!enemy){torso="#11151a";vest="#303a42"}
  ctx.fillStyle=torso;ctx.beginPath();ctx.roundRect(-17,-73,34,43,8);ctx.fill();
  ctx.fillStyle=vest;ctx.beginPath();ctx.roundRect(-14,-68,28,29,5);ctx.fill();
  ctx.fillStyle="#566266";ctx.fillRect(-11,-61,7,8);ctx.fillRect(4,-61,7,8);

  /* Hals und menschlicher Kopf */
  ctx.fillStyle="#a5775b";ctx.fillRect(-5,-81,10,10);
  ctx.fillStyle="#b48768";ctx.beginPath();ctx.arc(0,-91,13,0,Math.PI*2);ctx.fill();
  ctx.fillStyle=outfit==="GHOST"&&!enemy?"#11191c":"#202628";
  ctx.beginPath();ctx.arc(0,-97,14,Math.PI,Math.PI*2);ctx.fill();ctx.fillRect(-14,-97,28,6);
  /* Ohr, Gesichtskontur und Blickrichtung */
  ctx.fillStyle="#a5775b";ctx.beginPath();ctx.arc(12,-91,3.2,0,Math.PI*2);ctx.fill();
  ctx.fillStyle="#151a1b";ctx.fillRect(7,-94,3,2);
  if(!enemy){
    ctx.fillStyle="#7c8b8e";ctx.fillRect(11,-93,4,7);
    ctx.strokeStyle="#6e7c80";ctx.lineWidth=2;ctx.strokeRect(-10,-92,8,5);ctx.strokeRect(2,-92,8,5);
    ctx.beginPath();ctx.moveTo(-2,-90);ctx.lineTo(2,-90);ctx.stroke();
  }
  if(!enemy&&outfit==="EXECUTIVE"){ctx.fillStyle="#25292b";ctx.beginPath();ctx.moveTo(0,-80);ctx.lineTo(-4,-69);ctx.lineTo(0,-64);ctx.lineTo(4,-69);ctx.closePath();ctx.fill();}
  if(!enemy&&outfit==="GHOST"){ctx.strokeStyle="#303b40";ctx.lineWidth=5;ctx.beginPath();ctx.arc(0,-91,18,Math.PI,Math.PI*2);ctx.stroke();}
  if(!enemy&&outfit==="DESERT"){ctx.strokeStyle="#9a8967";ctx.lineWidth=4;ctx.beginPath();ctx.arc(0,-91,17,Math.PI,Math.PI*2);ctx.stroke();ctx.fillStyle="#5c4f3b";ctx.fillRect(-15,-71,30,5);}
  if(!enemy&&outfit==="RECON"){ctx.fillStyle="#14231b";ctx.fillRect(-14,-75,28,7);ctx.strokeStyle="#55735e";ctx.lineWidth=2;ctx.beginPath();ctx.arc(0,-91,15,Math.PI,Math.PI*2);ctx.stroke();}
  if(!enemy&&outfit==="BLACKOPS"){ctx.fillStyle="#080a0b";ctx.beginPath();ctx.arc(0,-92,15,Math.PI,Math.PI*2);ctx.fill();ctx.fillRect(-16,-92,32,5);ctx.fillStyle="#343d40";ctx.fillRect(-15,-68,30,5);ctx.fillRect(-20,-58,7,13);ctx.fillRect(13,-58,7,13);}
  if(!enemy&&outfit==="JICKENWINGPRIME"){
    /* Braune Prime-Jacke mit goldenen Details und Wing-Emblem. */
    ctx.fillStyle="#2b211c";ctx.fillRect(-18,-69,36,7);
    ctx.strokeStyle="#c9a24d";ctx.lineWidth=2;ctx.beginPath();ctx.moveTo(-10,-63);ctx.lineTo(0,-57);ctx.lineTo(10,-63);ctx.stroke();
    ctx.fillStyle="#d7b65b";ctx.fillRect(-3,-65,6,10);
    ctx.fillStyle="#8a6a31";ctx.fillRect(-16,-51,6,10);ctx.fillRect(10,-51,6,10);
    /* goldene Krone */
    ctx.fillStyle="#d8b44d";ctx.beginPath();ctx.moveTo(-8,-99);ctx.lineTo(-5,-104);ctx.lineTo(0,-100);ctx.lineTo(5,-104);ctx.lineTo(8,-99);ctx.closePath();ctx.fill();
  }
  if(!enemy&&outfit==="DEVILMARKER"){
    /* Schwarzer Hoodie mit roten Devil-Markierungen. */
    ctx.fillStyle="#07090a";ctx.beginPath();ctx.arc(0,-76,22,Math.PI,Math.PI*2);ctx.fill();ctx.fillRect(-20,-72,40,9);
    ctx.fillStyle="#b52d3c";ctx.fillRect(-17,-65,4,25);ctx.fillRect(13,-65,4,25);
    ctx.strokeStyle="#d33a48";ctx.lineWidth=2;ctx.beginPath();ctx.moveTo(-10,-55);ctx.lineTo(0,-61);ctx.lineTo(10,-55);ctx.stroke();
    /* kleines Devil-Emblem */
    ctx.fillStyle="#d33a48";ctx.beginPath();ctx.moveTo(-7,-51);ctx.lineTo(-3,-56);ctx.lineTo(0,-53);ctx.lineTo(3,-56);ctx.lineTo(7,-51);ctx.lineTo(0,-44);ctx.closePath();ctx.fill();
  }
  if(!enemy&&outfit==="D-WOLF"){
    ctx.fillStyle="#171b1d";ctx.beginPath();ctx.arc(0,-94,17,Math.PI,Math.PI*2);ctx.fill();ctx.fillRect(-18,-94,36,6);
    ctx.fillStyle="#536066";ctx.fillRect(-13,-91,10,5);ctx.fillRect(3,-91,10,5);
    ctx.strokeStyle="#9aa4a6";ctx.lineWidth=1.5;ctx.strokeRect(-14,-92,12,7);ctx.strokeRect(2,-92,12,7);
    ctx.strokeStyle="#171b1d";ctx.lineWidth=3;ctx.beginPath();ctx.moveTo(-18,-86);ctx.lineTo(-10,-84);ctx.moveTo(18,-86);ctx.lineTo(10,-84);ctx.stroke();
    ctx.fillStyle="#4f3a2d";ctx.beginPath();ctx.arc(0,-86,7,0,Math.PI);ctx.fill();
    ctx.fillStyle="#4d4b45";ctx.fillRect(-21,-60,8,18);ctx.fillRect(13,-60,8,18);
  }

  if(!enemy&&outfit==="NEONRAID"){ctx.fillStyle="#57d9e8";ctx.fillRect(-4,-58,8,3);}
  if(!enemy&&outfit==="FROSTGUARD"){ctx.fillStyle="#e8f2f4";ctx.fillRect(-18,-73,36,5);}
  if(!enemy&&outfit==="NIGHTVIPER"){ctx.fillStyle="#0a0f12";ctx.beginPath();ctx.arc(0,-94,17,Math.PI,Math.PI*2);ctx.fill();}
  if(!enemy&&outfit==="REDSENTINEL"){ctx.fillStyle="#d33a48";ctx.fillRect(-3,-66,6,25);}
  if(!enemy&&outfit==="GOLDFANG"){ctx.fillStyle="#d7b65b";ctx.fillRect(-15,-58,6,5);ctx.fillRect(9,-58,6,5);}
  if(!enemy&&outfit==="PHANTOMZERO"){ctx.strokeStyle="#667b8a";ctx.lineWidth=2;ctx.strokeRect(-17,-70,34,28);}
  if(!enemy&&outfit==="STORMBREAKER"){ctx.fillStyle="#4a5d66";ctx.fillRect(-21,-62,7,17);ctx.fillRect(14,-62,7,17);}
  if(!enemy&&outfit==="HAZARD"){ctx.fillStyle="#d1a45c";ctx.fillRect(-13,-59,26,4);}
  if(!enemy&&outfit==="APEXZERO"){ctx.fillStyle="#7bd6e5";ctx.fillRect(-2,-67,4,29);}

  /* Waffenfarbe aus dem aktuell ausgerüsteten Skin */
  if(weaponName!=="NONE"){
  const skin=(!enemy && typeof weaponSkinCatalog!=="undefined"&&weaponSkinCatalog[equippedWeaponSkin])
    ? weaponSkinCatalog[equippedWeaponSkin] : null;
  const metal=skin?skin.color:(enemy?"#596468":"#667074");
  const dark="#101416";
  const grip="#171c1d";
  const hand="#b48768";
  const aimAngle=enemy ? 0 : Math.atan2(player?.aimY||0,player?.aimX||1);

  /*
     Beide Arme greifen die Waffe wirklich.
     Der hintere Arm geht vom Schulterpunkt zum Pistolengriff,
     der vordere Arm zum Vorderschaft. Keine schwebende Stab-Hand mehr.
  */
  let rearGrip={x:15,y:-54}, frontGrip={x:31,y:-54};
  if(weaponName==="PISTOLE"||weaponName==="FALCON") frontGrip={x:30,y:-54};
  else if(weaponName==="VECTOR"||weaponName==="SPECTRE") frontGrip={x:35,y:-54};
  else if(weaponName==="RAVEN"||weaponName==="PHANTOM") frontGrip={x:43,y:-54};
  else if(weaponName==="BREACH") frontGrip={x:45,y:-52};
  else if(weaponName==="NIGHTFALL") frontGrip={x:50,y:-55};
  else if(weaponName==="VANGUARD") frontGrip={x:47,y:-54};
  else if(weaponName==="SHADOW") frontGrip={x:52,y:-55};
  else if(weaponName==="HAMMER") frontGrip={x:46,y:-52};
  else if(weaponName==="FURY") frontGrip={x:48,y:-54};
  else if(weaponName==="VOLT") frontGrip={x:51,y:-54};
  else if(weaponName==="TITAN") frontGrip={x:45,y:-52};
  else if(weaponName==="D-WOLF") frontGrip={x:49,y:-54};
  else if(weaponName==="FAUSTE") frontGrip={x:28,y:-48};
  else if(weaponName==="MESSER") frontGrip={x:26,y:-49};
  else if(weaponName==="KATANA") frontGrip={x:34,y:-50};
  else if(weaponName==="SCHWERT") frontGrip={x:34,y:-50};
  else if(weaponName==="SPEER") frontGrip={x:42,y:-50};
  else if(weaponName==="STAB") frontGrip={x:42,y:-50};

  ctx.strokeStyle=torso;ctx.lineWidth=10;ctx.lineCap="round";
  ctx.beginPath();ctx.moveTo(-13,-62);ctx.lineTo(-8,-48);ctx.lineTo(rearGrip.x,rearGrip.y);ctx.stroke();
  ctx.beginPath();ctx.moveTo(13,-62);ctx.lineTo(19,-48);ctx.lineTo(frontGrip.x,frontGrip.y);ctx.stroke();
  ctx.strokeStyle=hand;ctx.lineWidth=5;
  ctx.beginPath();ctx.arc(rearGrip.x,rearGrip.y,4,0,Math.PI*2);ctx.fillStyle=hand;ctx.fill();
  ctx.beginPath();ctx.arc(frontGrip.x,frontGrip.y,4,0,Math.PI*2);ctx.fill();

  /* Waffe wird an den Händen ausgerichtet */
  ctx.save();
  ctx.translate(rearGrip.x,rearGrip.y);
  if(!enemy)ctx.rotate(aimAngle);
  const kick=recoil>0?recoil*8:0;
  ctx.translate(-kick,0);
  ctx.lineCap="round";

  if(weaponName==="FAUSTE"){
    ctx.fillStyle=hand;
    ctx.beginPath();ctx.arc(12,-2,8,0,Math.PI*2);ctx.fill();
    ctx.beginPath();ctx.arc(31,-2,8,0,Math.PI*2);ctx.fill();
    ctx.fillStyle=dark;ctx.fillRect(5,4,12,5);ctx.fillRect(24,4,12,5);
  }else if(weaponName==="MESSER"){
    ctx.fillStyle=dark;ctx.fillRect(2,-1,14,7);
    ctx.fillStyle=metal;ctx.beginPath();ctx.moveTo(14,-3);ctx.lineTo(58,-9);ctx.lineTo(48,1);ctx.lineTo(14,4);ctx.closePath();ctx.fill();
    ctx.fillStyle="#d8e1e4";ctx.fillRect(25,-5,28,2);
  }else if(weaponName==="KATANA"){
    ctx.fillStyle=dark;ctx.fillRect(0,-2,18,5);
    ctx.fillStyle=metal;ctx.fillRect(13,-5,84,5);
    ctx.fillStyle="#dce8ea";ctx.fillRect(26,-4,69,2);
    ctx.fillStyle="#1b2225";ctx.fillRect(5,-7,7,10);
  }else if(weaponName==="SCHWERT"){
    ctx.fillStyle=dark;ctx.fillRect(0,-2,18,6);
    ctx.fillStyle=metal;ctx.beginPath();ctx.moveTo(13,-8);ctx.lineTo(104,-4);ctx.lineTo(88,4);ctx.lineTo(13,1);ctx.closePath();ctx.fill();
    ctx.fillStyle="#f2fbff";ctx.fillRect(25,-5,67,2);
    ctx.fillStyle="#aeb7ba";ctx.fillRect(9,-10,4,19);
  }else if(weaponName==="SPEER"||weaponName==="STAB"){
    ctx.strokeStyle=metal;ctx.lineWidth=5;ctx.beginPath();ctx.moveTo(0,0);ctx.lineTo(118,-1);ctx.stroke();
    ctx.fillStyle="#dce8ea";ctx.beginPath();ctx.moveTo(118,-1);ctx.lineTo(104,-10);ctx.lineTo(104,8);ctx.closePath();ctx.fill();
    ctx.fillStyle=dark;ctx.fillRect(4,-7,11,14);
  }else if(weaponName==="PISTOLE"||weaponName==="FALCON"){
    const L=weaponName==="FALCON"?40:32;
    ctx.fillStyle=metal;ctx.fillRect(-2,-8,L,8);
    ctx.fillStyle=dark;ctx.fillRect(6,0,9,15);
    ctx.fillStyle=grip;ctx.fillRect(4,-10,L-10,3);
    ctx.fillStyle=dark;ctx.fillRect(L-1,-7,6,5);
  }else if(weaponName==="VECTOR"||weaponName==="SPECTRE"){
    const L=weaponName==="VECTOR"?49:47;
    ctx.fillStyle=metal;ctx.fillRect(-2,-8,L,8);
    ctx.fillStyle=dark;ctx.fillRect(7,0,10,17);
    ctx.fillRect(19,-5,10,5);ctx.fillRect(15,-13,15,4);
    ctx.fillRect(L-1,-7,8,5);
  }else if(weaponName==="RAVEN"||weaponName==="PHANTOM"){
    const L=weaponName==="RAVEN"?61:57;
    ctx.fillStyle=metal;ctx.fillRect(-2,-7,L,7);
    ctx.fillStyle=dark;ctx.fillRect(7,0,10,16);
    ctx.fillRect(20,-12,18,5);ctx.fillRect(43,-14,14,4);
    ctx.fillRect(L-1,-6,9,5);
    ctx.fillStyle="#252b2d";ctx.fillRect(34,-16,16,3);
  }else if(weaponName==="BREACH"){
    ctx.fillStyle=metal;ctx.fillRect(-2,-8,50,10);
    ctx.fillStyle=dark;ctx.fillRect(7,1,11,15);
    ctx.fillRect(20,3,18,6);ctx.fillRect(45,-6,14,5);
  }else if(weaponName==="NIGHTFALL"){
    ctx.fillStyle=metal;ctx.fillRect(-2,-6,76,6);
    ctx.fillStyle=dark;ctx.fillRect(7,0,10,17);
    ctx.fillRect(22,-11,29,5);ctx.fillStyle="#31383a";ctx.fillRect(28,-16,25,4);
    ctx.fillStyle=dark;ctx.fillRect(70,-5,13,4);
  }else if(weaponName==="VANGUARD"){
    ctx.fillStyle=metal;ctx.fillRect(-2,-8,67,8);
    ctx.fillStyle=dark;ctx.fillRect(7,0,10,17);ctx.fillRect(25,1,18,7);
    ctx.fillRect(28,-14,23,4);ctx.fillRect(59,-7,12,5);
    ctx.fillStyle="#31383a";ctx.fillRect(17,-11,13,3);
  }else if(weaponName==="SHADOW"){
    ctx.fillStyle=metal;ctx.fillRect(-2,-7,78,7);
    ctx.fillStyle=dark;ctx.fillRect(7,0,10,17);ctx.fillRect(23,-11,31,4);
    ctx.fillRect(69,-6,15,5);ctx.fillStyle="#1b2225";ctx.fillRect(47,-14,17,3);
  }else if(weaponName==="HAMMER"){
    ctx.fillStyle=metal;ctx.fillRect(-2,-9,53,10);
    ctx.fillStyle=dark;ctx.fillRect(7,1,11,16);ctx.fillRect(21,3,19,6);
    ctx.fillRect(47,-7,15,6);ctx.fillStyle="#333a3c";ctx.fillRect(2,-13,22,4);
  }else if(weaponName==="FURY"){
    ctx.fillStyle=metal;ctx.fillRect(-2,-8,72,8);ctx.fillStyle=dark;ctx.fillRect(7,0,10,17);ctx.fillRect(25,1,17,7);ctx.fillRect(26,-14,25,4);ctx.fillStyle="#8c353d";ctx.fillRect(48,-11,18,3);ctx.fillRect(65,-6,12,4);
  }else if(weaponName==="VOLT"){
    ctx.fillStyle=metal;ctx.fillRect(-2,-7,70,7);ctx.fillStyle=dark;ctx.fillRect(7,0,10,17);ctx.fillRect(23,-12,28,4);ctx.fillStyle="#5da8b5";ctx.fillRect(42,-16,18,4);ctx.fillRect(66,-5,13,4);
  }else if(weaponName==="TITAN"){
    ctx.fillStyle=metal;ctx.fillRect(-2,-10,58,11);ctx.fillStyle=dark;ctx.fillRect(7,1,12,18);ctx.fillRect(22,4,22,8);ctx.fillStyle="#b84a42";ctx.beginPath();ctx.arc(54,-5,8,0,Math.PI*2);ctx.fill();ctx.fillStyle="#343d40";ctx.fillRect(0,-15,25,4);
  }else if(weaponName==="RAILGUN"){
    /* Leuchtende Railgun: langer Energie-Lauf mit Cyan-Kern. */
    ctx.save();
    ctx.shadowBlur=16;ctx.shadowColor="#55eaff";
    ctx.fillStyle="#172329";ctx.fillRect(-2,-11,108,14);
    ctx.fillStyle="#2f454d";ctx.fillRect(8,-15,72,5);
    ctx.fillStyle="#55eaff";ctx.fillRect(18,-7,82,4);
    ctx.fillStyle="#b9fbff";ctx.fillRect(91,-8,17,5);
    ctx.fillStyle="#101719";ctx.fillRect(7,2,12,19);ctx.fillRect(29,3,28,9);
    ctx.fillStyle="#39dff4";ctx.beginPath();ctx.arc(48,-9,5,0,Math.PI*2);ctx.fill();
    ctx.restore();
  }else if(weaponName==="D-WOLF"){
    // AK-inspiriertes D-WOLF-Sturmgewehr: Holzmagazin, Handschutz, Visier und lange Laufkontur.
    ctx.fillStyle=metal;ctx.fillRect(-2,-8,78,8);
    ctx.fillStyle="#5a4229";ctx.fillRect(18,1,17,19);ctx.rotate(-.10);ctx.fillRect(12,0,12,22);ctx.rotate(.10);
    ctx.fillStyle=dark;ctx.fillRect(6,0,10,17);ctx.fillRect(30,-13,24,4);ctx.fillRect(52,-16,12,4);
    ctx.fillStyle="#6b4b2d";ctx.fillRect(26,1,12,8);ctx.fillStyle=dark;ctx.fillRect(69,-6,17,5);ctx.fillRect(0,-12,20,4);
  }else{
    ctx.fillStyle=metal;ctx.fillRect(-2,-8,45,8);ctx.fillStyle=dark;ctx.fillRect(7,0,10,16);
  }
  ctx.restore();

  /* Finger/Handkontakt über dem Griff */
  ctx.fillStyle=hand;ctx.beginPath();ctx.ellipse(rearGrip.x+5,rearGrip.y+1,5,3,0,0,Math.PI*2);ctx.fill();
  ctx.fillStyle=hand;ctx.beginPath();ctx.ellipse(frontGrip.x-1,frontGrip.y+1,5,3,0,0,Math.PI*2);ctx.fill();
  }
  if(diamondSkin){
    const t=performance.now()/260;
    ctx.save();
    ctx.globalCompositeOperation="lighter";
    ctx.globalAlpha=.42+.18*Math.sin(t);
    ctx.strokeStyle="#dffcff";
    ctx.lineWidth=2.2;
    ctx.shadowBlur=14;
    ctx.shadowColor="#8ff7ff";
    ctx.beginPath();
    ctx.moveTo(-13,-82);ctx.lineTo(0,-96);ctx.lineTo(13,-82);ctx.lineTo(0,-68);ctx.closePath();ctx.stroke();
    ctx.beginPath();ctx.arc(0,-48,29+2*Math.sin(t*1.7),0,Math.PI*2);ctx.stroke();
    ctx.restore();
  }
  ctx.restore();

}
/* =========================================================
   DEAD ENEMY ANIMATION
========================================================= */

function drawDeadEnemy(e,x,progress){
  const alpha=e.specialAlpha==null?.96:e.specialAlpha;
  if(alpha<=0 || e.portalHidden)return;
  const r=e.ragdoll;
  if(!r){return;}
  const P=r.pts;
  ctx.save();
  ctx.globalAlpha=alpha;
  ctx.lineCap="round";
  ctx.lineJoin="round";

  /* Schatten des Körpers */
  ctx.fillStyle="#080b0d";
  ctx.beginPath();
  const sx=(P.footL.x+P.footR.x+P.hipL.x+P.hipR.x)/4-camera.x;
  const sy=r.ground+4;
  ctx.ellipse(sx,sy,40,7,0,0,Math.PI*2);ctx.fill();

  const sx0=P.shL.x-camera.x, sy0=P.shL.y;
  const sx1=P.shR.x-camera.x, sy1=P.shR.y;
  const hx0=P.hipL.x-camera.x, hy0=P.hipL.y;
  const hx1=P.hipR.x-camera.x, hy1=P.hipR.y;

  /* Rump als echtes Gelenkviereck */
  ctx.fillStyle="#202729";
  ctx.beginPath();ctx.moveTo(sx0,sy0);ctx.lineTo(sx1,sy1);ctx.lineTo(hx1,hy1);ctx.lineTo(hx0,hy0);ctx.closePath();ctx.fill();
  ctx.strokeStyle="#111517";ctx.lineWidth=5;ctx.stroke();

  function bone(a,b,w,col){
    const A=P[a],B=P[b];ctx.strokeStyle=col;ctx.lineWidth=w;ctx.beginPath();ctx.moveTo(A.x-camera.x,A.y);ctx.lineTo(B.x-camera.x,B.y);ctx.stroke();
  }
  function joint(n,radius,col){const q=P[n];ctx.fillStyle=col;ctx.beginPath();ctx.arc(q.x-camera.x,q.y,radius,0,Math.PI*2);ctx.fill();}

  /* Arme: Oberarm + Unterarm */
  bone("shL","elL",11,"#15191b"); bone("elL","handL",7,"#b58f78");
  bone("shR","elR",11,"#15191b"); bone("elR","handR",7,"#b58f78");
  /* Beine: Oberschenkel + Unterschenkel */
  bone("hipL","kneeL",13,"#202729"); bone("kneeL","footL",9,"#111517");
  bone("hipR","kneeR",13,"#202729"); bone("kneeR","footR",9,"#111517");

  /* Gelenke */
  ["shL","shR","elL","elR","hipL","hipR","kneeL","kneeR"].forEach(n=>joint(n,5,"#202729"));
  ["handL","handR"].forEach(n=>joint(n,4,"#b58f78"));

  /* Hals + Kopf */
  bone("neck","head",8,"#b58f78");
  joint("neck",6,"#b58f78");
  const h=P.head;
  ctx.fillStyle="#b58f78";ctx.beginPath();ctx.arc(h.x-camera.x,h.y,14,0,Math.PI*2);ctx.fill();
  ctx.fillStyle="#0a0d0e";ctx.beginPath();ctx.arc(h.x-camera.x,h.y-5,15,Math.PI,Math.PI*2);ctx.fill();

  /* Schulter-/Hüftgurt für mehr Körperlesbarkeit */
  ctx.strokeStyle="#111517";ctx.lineWidth=5;
  ctx.beginPath();ctx.moveTo(sx0,sy0);ctx.lineTo(sx1,sy1);ctx.stroke();
  ctx.beginPath();ctx.moveTo(hx0,hy0);ctx.lineTo(hx1,hy1);ctx.stroke();

  ctx.restore();

  if(e.weaponDropped){
    const dir=e.deathDir||1;
    const dropX=(P.handR.x+P.handL.x)/2-camera.x+dir*18;
    const dropY=(P.handR.y+P.handL.y)/2+12;
    ctx.save();ctx.translate(dropX,dropY);ctx.rotate(dir*.85);
    ctx.globalAlpha=Math.max(.35,alpha);
    ctx.fillStyle="#101416";ctx.fillRect(-3,-3,38,6);
    ctx.fillStyle="#596468";ctx.fillRect(8,-6,14,5);
    ctx.fillStyle="#171c1d";ctx.fillRect(4,1,9,12);ctx.restore();
  }
}


/* =========================================================
   ACTORS
========================================================= */

function drawActors(){
  if(!player)return;

  /*
    Gegner
  */

  for(
    const e of enemies
  ){

    const x=
      e.x-camera.x;

    if(
      x<-100 ||
      x>W+100
    )continue;


    /*
      ALARM PFEIL
    */

    if(
      e.state==="alert" ||
      e.state==="combat"
    ){

      const red=
        e.state==="combat";

      ctx.save();

      ctx.translate(
        x,
        e.y-112
      );

      ctx.fillStyle=
        red
        ?"#ef3b42"
        :"#e2c43f";

      ctx.beginPath();

      ctx.moveTo(
        0,
        0
      );

      ctx.lineTo(
        -11,
        -18
      );

      ctx.lineTo(
        11,
        -18
      );

      ctx.closePath();

      ctx.fill();

      ctx.restore();
    }


    ctx.save();
    if(e.dead && !e.portalHidden){
      const deathProgress=Math.min(1,e.fall||0);
      drawDeadEnemy(e,x,deathProgress);
    }else{
      if(e.boss){
        ctx.save();
        ctx.translate(x,e.y);
        ctx.scale(1.32,1.32);
        drawHuman(0,0,e.dir,true,false,e.walkPhase,e.walking,e.weapon||"TITAN",e.flash);
        ctx.restore();
        ctx.save();ctx.fillStyle="#ff4b54";ctx.font="900 10px Arial";ctx.textAlign="center";ctx.fillText(e.bossName,x,e.y-154);ctx.restore();
      }else{
        drawHuman(x,e.y,e.dir,true,false,e.walkPhase,e.walking,e.weapon||"PISTOLE",e.flash);
      }
    }
    ctx.restore();

    if(!e.dead && e.lastHitZone==="HEAD" && (e.hitFlash||0)>0){
      ctx.save();
      ctx.fillStyle="#ef4b4b";
      ctx.font="900 9px Arial";
      ctx.textAlign="center";
      ctx.fillText("HEADSHOT",x,e.y-132);
      ctx.restore();
      e.hitFlash=Math.max(0,(e.hitFlash||0)-.016);
      if(e.hitFlash<=0)e.lastHitZone="";
    }


    /*
      Health
    */

    if(
      e.hp<e.maxHp &&
      e.x>=camera.x-10 &&
      e.x<=camera.x+W+10
    ){

      ctx.fillStyle=
        "#111";

      ctx.fillRect(
        x-(e.boss?42:23),
        e.y-(e.boss?166:120),
        e.boss?84:46,
        e.boss?7:5
      );

      ctx.fillStyle="#d74747";

      ctx.fillRect(
        x-(e.boss?41:22),
        e.y-(e.boss?165:119),
        (e.boss?82:44)*Math.max(0,Math.min(1,e.hp/e.maxHp)),
        e.boss?5:3
      );
      }
    }


  /*
    Begleiter
  */
  drawCompanion();

  /*
    Spieler
  */

  if(playerDeath.active){
    const p=Math.min(1,playerDeath.time/1.15);
    ctx.save();
    ctx.translate(player.x-camera.x,player.y);
    ctx.rotate((player.dir||1)*(-.95*p));
    ctx.globalAlpha=Math.max(.15,1-p*.55);
    drawHuman(0,0,player.dir,false,false,player.walkPhase,false,player.weapon,0);
    ctx.fillStyle="#121719";ctx.fillRect(18,-3,34,5);
    ctx.restore();
  }else{
    drawHuman(player.x-camera.x,player.y,player.dir,false,false,player.walkPhase,player.walking,player.weapon,player.recoil);
  }


  /*
    Spielername
  */

  ctx.fillStyle=
    "#dce5e7";

  ctx.font=
    "bold 10px Arial";

  ctx.textAlign=
    "center";

  ctx.fillText(
    "ZERO",
    player.x-camera.x,
    player.y-112
  );


  /*
    Mündungsfeuer
  */

  if(flash>0){

    const muzzle=getWeaponMuzzle(player.weapon);
    const aimLen=Math.hypot(player.aimX,player.aimY)||1;
    const ax=player.aimX/aimLen, ay=player.aimY/aimLen;
    const x=player.x-camera.x+muzzle.x*ax;
    const y=player.y-54+muzzle.x*ay;

    ctx.fillStyle=
      "#ffd16b";

    ctx.beginPath();

    ctx.arc(
      x,
      y,
      9,
      0,
      Math.PI*2
    );

    ctx.fill();

    flash-=.016;
  }
}


/* =========================================================
   BULLETS
========================================================= */

function drawBullets(){

  for(
    const b of bullets
  ){

    const x=
      b.x-camera.x;

    const y=
      b.y;

    ctx.strokeStyle=b.railgun?"#63efff":"#fff0a5";
    ctx.lineWidth=b.railgun?4:2;

    ctx.beginPath();

    ctx.moveTo(
      x,
      y
    );

    ctx.lineTo(
      x-b.vx*.012,
      y-b.vy*.012
    );

    ctx.stroke();
    if(b.railgun){
      ctx.save();ctx.globalAlpha=.38;ctx.strokeStyle="#55eaff";ctx.lineWidth=10;ctx.shadowBlur=18;ctx.shadowColor="#55eaff";ctx.beginPath();ctx.moveTo(x,y);ctx.lineTo(x-b.vx*.018,y-b.vy*.018);ctx.stroke();ctx.restore();
    }
  }


  for(
    const b of enemyBullets
  ){

    const x=
      b.x-camera.x;

    const y=
      b.y;

    ctx.strokeStyle=
      "#f28b63";

    ctx.lineWidth=2;

    ctx.beginPath();

    ctx.moveTo(
      x,
      y
    );

    ctx.lineTo(
      x-b.vx*.012,
      y-b.vy*.012
    );

    ctx.stroke();
  }
}


/* =========================================================
   PARTICLES
========================================================= */

function drawParticles(){

  for(
    const p of particles
  ){

    const x=
      p.x-camera.x;

    const y=
      p.y;

    ctx.globalAlpha=
      clamp(
        p.life*2,
        0,
        1
      );


    if(
      p.type==="blood" ||
      p.type==="death"
    ){

      ctx.fillStyle=
        "#b62f33";

    }else if(
      p.type==="explosion"
    ){

      ctx.fillStyle=
        Math.random()<.5
        ?"#ef9b38"
        :"#d84c2e";

    }else if(p.type==="dust"){
      ctx.fillStyle="#9a9a82";
    }else{
      ctx.fillStyle="#d7c56b";
    }


    ctx.beginPath();

    ctx.arc(
      x,
      y,
      2.5,
      0,
      Math.PI*2
    );

    ctx.fill();
  }

  ctx.globalAlpha=1;
}


/* =========================================================
   LIGHTING
========================================================= */

function drawLighting(env){

  if(
    env==="NIGHT"
  ){

    ctx.fillStyle=
      "rgba(5,12,25,.23)";

    ctx.fillRect(
      0,
      0,
      W,
      H
    );
  }


  /*
    Vignette
  */

  const g=
    ctx.createRadialGradient(
      W/2,
      H/2,
      Math.min(W,H)*.25,
      W/2,
      H/2,
      Math.max(W,H)*.75
    );

  g.addColorStop(
    0,
    "transparent"
  );

  g.addColorStop(
    1,
    "rgba(0,0,0,.55)"
  );

  ctx.fillStyle=g;

  ctx.fillRect(
    0,
    0,
    W,
    H
  );
}


/* =========================================================
   MINIMAP
========================================================= */

function drawMinimap(){

  const mw=170;
  const mh=45;

  const x=
    W-mw-12;

  const y=
    H-mh-12;

  ctx.fillStyle=
    "#05090ccc";

  ctx.fillRect(
    x,
    y,
    mw,
    mh
  );

  ctx.strokeStyle=
    "#526067";

  ctx.strokeRect(
    x,
    y,
    mw,
    mh
  );


  const scale=
    mw/world.width;


  /*
    Spieler
  */

  ctx.fillStyle=
    "#62d08a";

  ctx.fillRect(
    x+
    player.x*scale-2,
    y+
    mh/2-2,
    4,
    4
  );


  /*
    Gegner
  */

  for(
    const e of enemies
  ){

    if(e.dead)continue;

    if(
      e.state==="combat"
    ){

      ctx.fillStyle=
        "#e33b42";

      ctx.fillRect(
        x+
        e.x*scale-2,
        y+
        mh/2-2,
        4,
        4
      );
    }
  }


  /*
    Extraktion
  */

  ctx.fillStyle=
    "#66c988";

  ctx.fillRect(
    x+
    extractX*scale-2,
    y+
    mh/2-2,
    4,
    4
  );
}


/* =========================================================
   CROSSHAIR
========================================================= */

function moveCrosshair(){

  const cross=
    document.getElementById("crosshair");

  if(!player)return;

  /*
    Das Fadenkreuz sitzt jetzt dort, wohin der Spieler
    tatsächlich schießt: vom Spieler aus entlang der
    gespeicherten Aim-Richtung.
  */

  const px=player.x-camera.x;
  const py=player.y-42;

  const distance=Math.min(
    300,
    Math.max(170,W*.26)
  );

  cross.style.left=
    (px+player.aimX*distance)+"px";

  cross.style.top=
    (py+player.aimY*distance)+"px";
}


/* =========================================================
   GAME LOOP
========================================================= */

let last=
  performance.now();

function loop(time){

  const dt=
    Math.min(
      .033,
      (time-last)/1000
    );

  last=time;

  updatePlayerDeath(dt);
  update(dt);
  // Fadenkreuz folgt Zero immer – auch beim Laufen und bei Kamerabewegung.
  moveCrosshair();

  ctx.clearRect(
    0,
    0,
    W,
    H
  );


  if(player){

    const env=
      missions[currentLevel][2];

    drawSky(env);

    drawWorld(env);

    drawBullets();

    drawActors();

    drawSpecialEffects();
    drawMeleeEffects();

    drawParticles();

    drawLighting(env);
  }


  requestAnimationFrame(
    loop
  );
}


/* =========================================================
   INIT
========================================================= */

setupLevel(0);

moveCrosshair();

requestAnimationFrame(
  loop
);

</script>

<script>
/* BLACKLIST OPERATIV - tactical audio engine v23: music forced on after user gesture */
(function(){
  let AC=null, master=null, musicGain=null, sfxGain=null, timer=null, step=0, enabled=true;
  const btn=document.getElementById('audioToggle');

  function initAudio(){
    try{
      const C=window.AudioContext||window.webkitAudioContext;
      if(!C)return false;
      if(!AC){
        AC=new C();
        master=AC.createGain(); master.gain.value=.95; master.connect(AC.destination);
        musicGain=AC.createGain(); musicGain.gain.value=.48; musicGain.connect(master);
        sfxGain=AC.createGain(); sfxGain.gain.value=.9; sfxGain.connect(master);
        startMusic();
      }
      if(AC.state==='suspended') AC.resume();
      return true;
    }catch(e){ console.warn('Audio:',e); return false; }
  }

  function osc(freq,dur,type,gain,when=0,dest){
    if(!AC||!dest||!enabled)return;
    const t=AC.currentTime+when;
    const o=AC.createOscillator(), g=AC.createGain();
    o.type=type; o.frequency.setValueAtTime(freq,t);
    g.gain.setValueAtTime(.0001,t);
    g.gain.exponentialRampToValueAtTime(Math.max(.0003,gain),t+.018);
    g.gain.exponentialRampToValueAtTime(.0001,t+dur);
    o.connect(g); g.connect(dest); o.start(t); o.stop(t+dur+.05);
  }

  function startMusic(){
    if(timer)clearInterval(timer);
    step=0;
    /* Deutlich hörbare, dunkle Agenten-/Militär-Musik ohne externe Dateien. */
    const bass=[55,55,65.41,55,73.42,65.41,49,55];
    const lead=[220,0,196,0,220,246.94,0,196,220,0,164.81,0,196,0,146.83,0];
    timer=setInterval(function(){
      if(!AC||!enabled||AC.state!=='running')return;
      const i=step++%16;
      const b=bass[Math.floor(i/2)];
      osc(b,.34,'sawtooth',.14,0,musicGain);
      osc(b*2,.16,'triangle',.065,.015,musicGain);
      if(lead[i])osc(lead[i],.25,'square',.055,.025,musicGain);
      if(i%4===0)osc(82.41,.18,'sine',.15,0,musicGain);
      if(i%8===0){osc(110,.5,'triangle',.07,.02,musicGain);osc(164.81,.4,'triangle',.045,.08,musicGain);}
    },250);
  }

  function noise(dur,gain,when=0){
    if(!AC||!sfxGain||!enabled)return;
    const n=AC.createBufferSource(), f=AC.createBiquadFilter(), g=AC.createGain();
    const len=Math.max(1,Math.floor(AC.sampleRate*dur));
    const b=AC.createBuffer(1,len,AC.sampleRate), d=b.getChannelData(0);
    for(let i=0;i<len;i++)d[i]=(Math.random()*2-1)*(1-i/len);
    n.buffer=b; f.type='lowpass'; f.frequency.value=3000;
    const t=AC.currentTime+when; g.gain.setValueAtTime(.0001,t); g.gain.exponentialRampToValueAtTime(gain,t+.008); g.gain.exponentialRampToValueAtTime(.0001,t+dur);
    n.connect(f);f.connect(g);g.connect(sfxGain);n.start(t);n.stop(t+dur+.02);
  }

  window.blacklistSfx=function(kind){
    if(!initAudio())return;
    if(kind==='shoot'){noise(.06,.32);osc(95,.09,'sawtooth',.2,0,sfxGain);}
    else if(kind==='hit'){osc(135,.08,'square',.18,0,sfxGain);noise(.04,.12);}
    else if(kind==='death'){osc(75,.22,'sawtooth',.2,0,sfxGain);osc(45,.34,'sine',.15,.06,sfxGain);}
    else if(kind==='click')osc(440,.08,'triangle',.14,0,sfxGain);
  };

  function updateButton(){if(btn)btn.textContent=enabled?'🔊 MUSIK AN':'🔇 MUSIK AUS';}
  if(btn){
    btn.addEventListener('click',function(e){
      e.stopPropagation();
      if(!enabled){
        enabled=true; initAudio();
        if(musicGain&&AC)musicGain.gain.setTargetAtTime(.48,AC.currentTime,.04);
      }else{
        /* Erst sicherstellen, dass der Browser den AudioContext entsperrt hat. */
        initAudio();
        enabled=false;
        if(musicGain&&AC)musicGain.gain.setTargetAtTime(.0001,AC.currentTime,.04);
      }
      updateButton();
    });
  }

  /* iPad/iPhone/Safari: AudioContext muss aus einer echten Nutzeraktion kommen. */
  function unlock(){ if(enabled)initAudio(); }
  document.addEventListener('pointerdown',unlock,{passive:true});
  document.addEventListener('touchstart',unlock,{passive:true});
  document.addEventListener('click',unlock,{passive:true});
  updateButton();
})();
</script>

<script>
/* PAD TO HOME cinematic intro */
(function(){
  const intro=document.getElementById('studioIntro');
  if(!intro)return;
  const frames=[
    document.getElementById('introSceneFrame'),
    document.getElementById('introGameFrame')
  ];
  let done=false;
  function finishIntro(){
    if(done)return; done=true;
    intro.style.opacity='0';
    intro.style.transition='opacity .8s ease';
    setTimeout(()=>{intro.remove();document.getElementById('menu').style.display='flex';},800);
  }
  setTimeout(()=>{frames[0].classList.remove('show');frames[0].classList.add('hide');frames[1].classList.add('show');},1800);
  setTimeout(finishIntro,4100);
  intro.addEventListener('pointerdown',function(){ if(!done && performance.now()>900) finishIntro(); },{once:true});
})();
</script>

<script>
/* BLACKLIST OPERATIV // PWA helper */
(()=>{
  const card=document.getElementById('pwaInstallCard');
  const close=document.getElementById('pwaClose');
  const how=document.getElementById('pwaHow');
  const standalone=window.matchMedia('(display-mode: standalone)').matches||window.navigator.standalone;
  if(card&&!standalone&&!localStorage.getItem('blacklistPwaHintClosed')) setTimeout(()=>card.style.display='block',2200);
  close?.addEventListener('click',()=>{card.style.display='none';localStorage.setItem('blacklistPwaHintClosed','1')});
  how?.addEventListener('click',()=>alert('iPad/iPhone: Safari → Teilen → Zum Home-Bildschirm → Hinzufügen. Auf Mac/Chrome: Install-Symbol in der Adressleiste verwenden, falls angeboten.'));
})();
</script>

<script>
if('serviceWorker' in navigator && location.protocol !== 'file:'){
  window.addEventListener('load',()=>navigator.serviceWorker.register('./sw.js').catch(()=>{}));
}
</script>
</body>
</html>
