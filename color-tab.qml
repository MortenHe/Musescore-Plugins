//=============================================================================
//  MuseScore
//  Music Composition & Notation
//
//  Copyright (C) 2020 Martin Helfer
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License version 2
//  as published by the Free Software Foundation and appearing in
//  the file LICENCE.GPL
//=============================================================================

import QtQuick 2.0
import MuseScore 3.0

MuseScore {
    version: "3.0"
    description: "This plugin colors the TAB notes depending on their string"
    menuPath: "Plugins.ColorTab"

    property variant colors: [
        "#00aa00", // 1. string (high e)
        "#ff0000", // 2. string
        "#0000ff", // 3. string
        "#aa5500", // 4. string
        "#aa00ff", // 5. string
        "#000000", // 6. string (low e)
    ];

    onRun: {
        if (!curScore) {
            Qt.quit();
        }

        const cursor = curScore.newCursor();
        cursor.voice = 0;
        cursor.staffIdx = 1;
        cursor.rewind(Cursor.SCORE_START);

        //iterate elements
        while (cursor.segment) {
            const e = cursor.element;
            if (e && e.type === Element.CHORD) {
                const notes = e.notes;
                for (var i = 0; i < notes.length; i++) {
                    const note = notes[i];
                    note.color = colors[note.string];
                }
            }
            cursor.next();
        }
        Qt.quit();
    }
}
