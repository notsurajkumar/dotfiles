let audioContext = null;

let octave = 4;

let sustain = false;

const activeNotes = new Map();

const keyboardMap = {
    "a": 0,
    "w": 1,
    "s": 2,
    "e": 3,
    "d": 4,
    "f": 5,
    "t": 6,
    "g": 7,
    "y": 8,
    "h": 9,
    "u": 10,
    "j": 11,
    "k": 12,
    "o": 13,
    "l": 14,
    "p": 15,
    ";": 16
};

const noteNames = [
    "C",
    "C#",
    "D",
    "D#",
    "E",
    "F",
    "F#",
    "G",
    "G#",
    "A",
    "A#",
    "B",
    "C",
    "C#",
    "D",
    "D#",
    "E"
];

const keys = document.querySelectorAll(".key");

const octaveDisplay =
    document.getElementById("octaveDisplay");

const sustainButton =
    document.getElementById("sustain");

const status =
    document.getElementById("status");


function getAudioContext() {

    if (!audioContext) {

        audioContext =
            new (
                window.AudioContext ||
                window.webkitAudioContext
            )();

    }

    if (audioContext.state === "suspended") {
        audioContext.resume();
    }

    return audioContext;
}


/*
    Convert MIDI number to frequency.

    MIDI 69 = A4 = 440Hz
*/

function midiToFrequency(midi) {

    return 440 * Math.pow(
        2,
        (midi - 69) / 12
    );

}


/*
    Create a slightly more piano-like sound.

    Instead of a single oscillator,
    we use multiple harmonics.
*/

function playNote(index, keyElement) {

    if (activeNotes.has(index)) {
        return;
    }

    const ctx = getAudioContext();

    const noteName = noteNames[index];

    const baseMidi =
        12 * (octave + 1);

    const midi =
        baseMidi + index;

    const frequency =
        midiToFrequency(midi);

    const master =
        ctx.createGain();

    master.gain.setValueAtTime(
        0.0001,
        ctx.currentTime
    );

    master.gain.exponentialRampToValueAtTime(
        0.28,
        ctx.currentTime + 0.015
    );

    /*
        Piano harmonics.
    */

    const oscillators = [];

    const harmonics = [
        [1, 1.0],
        [2, 0.30],
        [3, 0.15],
        [4, 0.07],
        [5, 0.03]
    ];

    harmonics.forEach(([multiple, volume]) => {

        const oscillator =
            ctx.createOscillator();

        const gain =
            ctx.createGain();

        oscillator.type = "sine";

        oscillator.frequency.value =
            frequency * multiple;

        gain.gain.value = volume;

        oscillator.connect(gain);
        gain.connect(master);

        oscillator.start();

        oscillators.push(oscillator);

    });

    /*
        Small low-pass filter.
    */

    const filter =
        ctx.createBiquadFilter();

    filter.type = "lowpass";

    filter.frequency.value = 5000;

    master.connect(filter);

    filter.connect(ctx.destination);

    activeNotes.set(index, {
        oscillators,
        master,
        filter
    });

    keyElement.classList.add("active");

    status.textContent =
        `${noteName}${octave} playing`;
}


function stopNote(index) {

    const note =
        activeNotes.get(index);

    if (!note) {
        return;
    }

    const ctx = getAudioContext();

    /*
        If sustain is enabled,
        don't immediately release.
    */

    if (sustain) {
        return;
    }

    releaseNote(index, note, ctx);
}


function releaseNote(index, note, ctx) {

    const now = ctx.currentTime;

    note.master.gain.cancelScheduledValues(now);

    note.master.gain.setValueAtTime(
        Math.max(note.master.gain.value, 0.0001),
        now
    );

    note.master.gain.exponentialRampToValueAtTime(
        0.0001,
        now + 0.5
    );

    setTimeout(() => {

        note.oscillators.forEach(
            oscillator => {
                try {
                    oscillator.stop();
                } catch {}
            }
        );

        note.master.disconnect();

    }, 600);

    activeNotes.delete(index);

    const key =
        [...keys].find(
            k => keyboardMap[k.dataset.key] === index
        );

    if (key) {
        key.classList.remove("active");
    }
}


function releaseAll() {

    const ctx = getAudioContext();

    for (const [index, note] of activeNotes) {

        releaseNote(
            index,
            note,
            ctx
        );

    }

}


function getKeyElement(index) {

    return [...keys].find(
        key =>
            keyboardMap[key.dataset.key] === index
    );

}


/*
    Physical keyboard
*/

document.addEventListener(
    "keydown",
    event => {

        /*
            Don't interfere with typing
            in future input fields.
        */

        if (
            event.target.tagName === "INPUT" ||
            event.target.tagName === "TEXTAREA"
        ) {
            return;
        }

        const key =
            event.key.toLowerCase();

        if (key === "z") {

            octave = Math.max(
                1,
                octave - 1
            );

            updateOctave();

            return;
        }

        if (key === "x") {

            octave = Math.min(
                7,
                octave + 1
            );

            updateOctave();

            return;
        }

        if (key === " ") {

            event.preventDefault();

            toggleSustain();

            return;
        }

        if (!(key in keyboardMap)) {
            return;
        }

        /*
            Prevent repeated keydown events.
        */

        if (event.repeat) {
            return;
        }

        const index =
            keyboardMap[key];

        const element =
            getKeyElement(index);

        if (element) {
            playNote(index, element);
        }

    }
);


/*
    Physical keyboard release
*/

document.addEventListener(
    "keyup",
    event => {

        const key =
            event.key.toLowerCase();

        if (!(key in keyboardMap)) {
            return;
        }

        const index =
            keyboardMap[key];

        stopNote(index);

    }
);


/*
    Mouse / touch
*/

keys.forEach((keyElement, index) => {

    const noteIndex =
        keyboardMap[keyElement.dataset.key];

    keyElement.addEventListener(
        "pointerdown",
        event => {

            event.preventDefault();

            playNote(
                noteIndex,
                keyElement
            );

        }
    );

    keyElement.addEventListener(
        "pointerup",
        event => {

            event.preventDefault();

            stopNote(noteIndex);

        }
    );

    keyElement.addEventListener(
        "pointerleave",
        () => {

            if (
                activeNotes.has(noteIndex) &&
                !sustain
            ) {
                stopNote(noteIndex);
            }

        }
    );

});


function toggleSustain() {

    sustain = !sustain;

    sustainButton.textContent =
        `Sustain: ${sustain ? "ON" : "OFF"}`;

    if (!sustain) {
        releaseAll();
    }

}


function updateOctave() {

    octaveDisplay.textContent =
        `Octave: ${octave}`;

    /*
        Changing octave while notes are held
        is easiest handled by releasing them.
    */

    releaseAll();

}


document
    .getElementById("octaveDown")
    .addEventListener(
        "click",
        () => {

            octave = Math.max(
                1,
                octave - 1
            );

            updateOctave();

        }
    );


document
    .getElementById("octaveUp")
    .addEventListener(
        "click",
        () => {

            octave = Math.min(
                7,
                octave + 1
            );

            updateOctave();

        }
    );


sustainButton.addEventListener(
    "click",
    toggleSustain
);


/*
    Release notes if the browser window
    loses focus.
*/

window.addEventListener(
    "blur",
    releaseAll
);
