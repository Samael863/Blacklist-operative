/* PAD AI // local game assistant for BLACKLIST OPERATIVE
 * No API key or external AI service is used. The assistant speaks locally
 * through the browser and reacts to custom game events.
 */
(function () {
  'use strict';

  const state = { enabled: false, listening: false, last: '' };
  const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;

  function say(text) {
    if (!state.enabled || !('speechSynthesis' in window) || !text || text === state.last) return;
    state.last = text;
    window.speechSynthesis.cancel();
    const utterance = new SpeechSynthesisUtterance(text);
    utterance.lang = 'de-DE';
    utterance.rate = 0.95;
    utterance.pitch = 1;
    window.speechSynthesis.speak(utterance);
  }

  function ask(text) {
    const q = String(text || '').toLowerCase();
    if (/munition|ammo/.test(q)) return 'Behalte deine Munition im Blick und lade rechtzeitig nach.';
    if (/gegner|feind/.test(q)) return 'Bleib in Bewegung und nutze Deckung. Beobachte zuerst die Gegner.';
    if (/mission|auftrag/.test(q)) return 'Mission aktiv. Konzentriere dich auf dein aktuelles Ziel.';
    if (/hilfe|tipp|was soll/.test(q)) return 'Ich bin da. Nutze Bewegung, Deckung und sparsame Schüsse.';
    if (/hallo|hey|hi/.test(q)) return 'Hey! PAD AI ist online. Bereit für die Mission.';
    return 'Verstanden. Ich begleite dich durch die Mission.';
  }

  function notify(eventName, detail) {
    if (!state.enabled) return;
    const messages = {
      start: 'Mission gestartet. Viel Erfolg, Agent Zero.',
      enemy: 'Achtung, Gegner in der Nähe.',
      lowhp: 'Warnung: Deine Lebenspunkte sind niedrig.',
      lowammo: 'Deine Munition wird knapp.',
      reload: 'Nachladen abgeschlossen.',
      win: 'Mission erfolgreich abgeschlossen. Sehr gute Arbeit.',
      lose: 'Mission fehlgeschlagen. Du kannst es erneut versuchen.'
    };
    say(detail || messages[eventName] || 'Ereignis erkannt.');
  }

  function build() {
    const button = document.createElement('button');
    button.id = 'padAiToggle';
    button.type = 'button';
    button.textContent = '🤖 KI AUS';
    Object.assign(button.style, {
      position: 'fixed', right: '82px', top: '10px', zIndex: '10001',
      padding: '8px 11px', borderRadius: '10px', cursor: 'pointer',
      background: '#101418', color: '#fff', border: '1px solid #59636a',
      fontWeight: '700'
    });

    const mic = document.createElement('button');
    mic.id = 'padAiMic';
    mic.type = 'button';
    mic.textContent = '🎙️';
    Object.assign(mic.style, {
      position: 'fixed', right: '10px', top: '52px', zIndex: '10001',
      padding: '8px 11px', borderRadius: '10px', cursor: 'pointer',
      background: '#101418', color: '#fff', border: '1px solid #59636a',
      display: 'none'
    });

    button.addEventListener('click', () => {
      state.enabled = !state.enabled;
      button.textContent = state.enabled ? '🤖 KI AN' : '🤖 KI AUS';
      mic.style.display = state.enabled && SpeechRecognition ? 'block' : 'none';
      if (state.enabled) say('PAD AI aktiviert. Ich begleite dich durch das Spiel.');
      else window.speechSynthesis?.cancel();
    });

    mic.addEventListener('click', () => {
      if (!SpeechRecognition || state.listening) return;
      const recognition = new SpeechRecognition();
      recognition.lang = 'de-DE';
      recognition.interimResults = false;
      state.listening = true;
      mic.textContent = '⏺️';
      recognition.onresult = event => say(ask(event.results[0][0].transcript));
      recognition.onend = () => { state.listening = false; mic.textContent = '🎙️'; };
      recognition.onerror = recognition.onend;
      recognition.start();
    });

    document.body.append(button, mic);
  }

  window.padAi = { say, notify, ask, enable: () => { state.enabled = true; }, disable: () => { state.enabled = false; } };
  window.addEventListener('pad-ai', event => notify(event.detail?.name, event.detail?.text));

  if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', build);
  else build();
})();
