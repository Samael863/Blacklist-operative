/* PAD AI // Overlay für BLACKLIST OPERATIVE
 * Lokale Assistenz ohne API-Schlüssel oder externe KI.
 */
(function () {
  'use strict';

  const state = { enabled: false, listening: false, stream: null };
  const Recognition = window.SpeechRecognition || window.webkitSpeechRecognition;

  const styles = `
    #padAiRoot{position:fixed;right:18px;bottom:18px;z-index:10001;width:min(390px,calc(100vw - 36px));color:#eafaff;font:14px Arial,sans-serif;pointer-events:none}
    #padAiRoot *{box-sizing:border-box}
    #padAiToggle{pointer-events:auto;display:block;margin-left:auto;margin-bottom:8px;padding:9px 13px;border:1px solid #00d9ff;border-radius:10px;background:#061722;color:#65eaff;font-weight:700;cursor:pointer;box-shadow:0 0 18px #00d9ff33}
    #padAiPanel{display:none;pointer-events:auto;border:1px solid #00d9ff66;border-radius:13px;overflow:hidden;background:#030b11f5;box-shadow:0 14px 45px #000b}
    #padAiPanel.open{display:block}
    .padAiHead{display:flex;align-items:center;justify-content:space-between;padding:12px 14px;border-bottom:1px solid #00d9ff44;background:#07131d}
    .padAiTitle{color:#65eaff;font-weight:700;letter-spacing:1px}.padAiClose{border:0;background:none;color:#71909e;font-size:20px;cursor:pointer}
    #padAiMessages{max-height:245px;overflow:auto;padding:12px}.padAiMsg{margin:7px 0;padding:9px 11px;border:1px solid #00d9ff33;border-radius:9px;background:#081722;line-height:1.45;white-space:pre-wrap}.padAiMsg.user{background:#07314a}
    .padAiComposer{display:flex;gap:6px;padding:9px;border-top:1px solid #00d9ff44}.padAiComposer input{min-width:0;flex:1;padding:10px;border:1px solid #00d9ff44;border-radius:8px;background:#06131d;color:#fff;outline:0}.padAiComposer button{border:1px solid #00d9ff66;border-radius:8px;background:#061722;color:#65eaff;cursor:pointer;padding:0 10px}.padAiComposer .send{background:#00a9d0;color:#001017;font-weight:700}
    .padAiActions{display:flex;gap:6px;padding:0 9px 9px}.padAiActions button{flex:1;padding:7px 4px;border:1px solid #00d9ff44;border-radius:7px;background:#06131c;color:#bfeef8;cursor:pointer;font-size:11px}
  `;

  function say(text) {
    if (!state.enabled || !('speechSynthesis' in window) || !text) return;
    window.speechSynthesis.cancel();
    const utterance = new SpeechSynthesisUtterance(String(text).slice(0, 1200));
    utterance.lang = 'de-DE'; utterance.rate = .95; utterance.pitch = 1;
    window.speechSynthesis.speak(utterance);
  }

  function answer(text) {
    const q = String(text || '').toLowerCase();
    if (/munition|ammo/.test(q)) return 'Behalte deine Munition im Blick und lade rechtzeitig nach.';
    if (/gegner|feind/.test(q)) return 'Bleib in Bewegung, nutze Deckung und beobachte zuerst die Gegner.';
    if (/mission|auftrag|ziel/.test(q)) return 'Mission aktiv. Konzentriere dich auf dein aktuelles Ziel.';
    if (/waffe|balanc/.test(q)) return 'Spezialmunition ist stark, sollte aber begrenzt bleiben. Nutze sie für schwierige Gegner.';
    if (/hilfe|tipp|was soll/.test(q)) return 'Nutze Bewegung, Deckung und sparsame Schüsse. Ich begleite dich durch die Mission.';
    if (/hallo|hey|hi/.test(q)) return 'Hey! PAD AI ist online. Bereit für die Mission.';
    return 'Verstanden. Ich begleite dich durch die Mission.';
  }

  function addMessage(text, user) {
    const box = document.getElementById('padAiMessages');
    if (!box) return;
    const item = document.createElement('div');
    item.className = 'padAiMsg' + (user ? ' user' : '');
    item.textContent = text;
    box.appendChild(item);
    box.scrollTop = box.scrollHeight;
  }

  function send() {
    const input = document.getElementById('padAiInput');
    const text = input && input.value.trim();
    if (!text) return;
    addMessage(text, true); input.value = '';
    const reply = answer(text);
    setTimeout(() => { addMessage(reply); say(reply); }, 180);
  }

  function listen() {
    if (!Recognition || state.listening) return;
    const recognition = new Recognition();
    recognition.lang = 'de-DE'; recognition.interimResults = false; recognition.continuous = false;
    state.listening = true;
    recognition.onresult = e => { document.getElementById('padAiInput').value = e.results[0][0].transcript; send(); };
    recognition.onend = () => { state.listening = false; };
    recognition.onerror = recognition.onend;
    recognition.start();
  }

  async function shareScreen() {
    if (!navigator.mediaDevices?.getDisplayMedia) { addMessage('Bildschirmfreigabe wird von diesem Browser nicht unterstützt.'); return; }
    try {
      state.stream?.getTracks().forEach(track => track.stop());
      state.stream = await navigator.mediaDevices.getDisplayMedia({ video: true, audio: false });
      addMessage('Bildschirm verbunden. PAD AI empfängt den Stream lokal im Browser.');
      state.stream.getVideoTracks()[0].addEventListener('ended', () => addMessage('Bildschirmfreigabe beendet.'));
    } catch (_) { addMessage('Die Bildschirmfreigabe wurde abgebrochen.'); }
  }

  function notify(name, detail) {
    if (!state.enabled) return;
    const messages = { start:'Mission gestartet. Viel Erfolg, Agent Zero.', enemy:'Achtung, Gegner in der Nähe.', lowhp:'Warnung: Deine Lebenspunkte sind niedrig.', lowammo:'Deine Munition wird knapp.', reload:'Nachladen abgeschlossen.', win:'Mission erfolgreich abgeschlossen.', lose:'Mission fehlgeschlagen. Du kannst es erneut versuchen.' };
    say(detail || messages[name] || 'Ereignis erkannt.');
  }

  function build() {
    if (document.getElementById('padAiRoot')) return;
    const style = document.createElement('style'); style.textContent = styles; document.head.appendChild(style);
    const root = document.createElement('div'); root.id = 'padAiRoot';
    root.innerHTML = `<button id="padAiToggle" type="button">🤖 PAD AI</button><section id="padAiPanel" aria-label="PAD AI Chat"><div class="padAiHead"><span class="padAiTitle">PAD AI · MISSION ASSISTANT</span><button class="padAiClose" type="button" aria-label="Schließen">×</button></div><div id="padAiMessages"></div><div class="padAiActions"><button type="button" data-action="listen">🎙️ Sprache</button><button type="button" data-action="share">🖥️ Bildschirm</button><button type="button" data-action="speak">🔊 Vorlesen</button></div><div class="padAiComposer"><input id="padAiInput" placeholder="PAD AI fragen …" autocomplete="off"><button type="button" data-action="send" class="send">➤</button></div></section>`;
    document.body.appendChild(root);
    const panel = root.querySelector('#padAiPanel');
    root.querySelector('#padAiToggle').onclick = () => { state.enabled = !state.enabled; panel.classList.toggle('open', state.enabled); root.querySelector('#padAiToggle').textContent = state.enabled ? '🤖 PAD AI AN' : '🤖 PAD AI'; if (state.enabled && !document.getElementById('padAiMessages').children.length) addMessage('PAD AI ist online. Bereit für BLACKLIST OPERATIVE.'); };
    root.querySelector('.padAiClose').onclick = () => { state.enabled = false; panel.classList.remove('open'); root.querySelector('#padAiToggle').textContent = '🤖 PAD AI'; };
    root.querySelector('[data-action="send"]').onclick = send;
    root.querySelector('#padAiInput').onkeydown = e => { if (e.key === 'Enter') send(); };
    root.querySelector('[data-action="listen"]').onclick = listen;
    root.querySelector('[data-action="share"]').onclick = shareScreen;
    root.querySelector('[data-action="speak"]').onclick = () => { const items = [...document.querySelectorAll('.padAiMsg:not(.user)')]; say(items.at(-1)?.textContent || 'PAD AI ist bereit.'); };
  }

  window.padAi = { say, notify, ask: answer, enable: () => { state.enabled = true; }, disable: () => { state.enabled = false; } };
  window.addEventListener('pad-ai', event => notify(event.detail?.name, event.detail?.text));
  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', build); else build();
})();
