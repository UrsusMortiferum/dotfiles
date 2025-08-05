pragma Singleton

import Quickshell

Singleton {
    id: root

    property alias enabled: clock.enabled
    readonly property date date: clock.date
    readonly property int hours: clock.hours
    readonly property int minutes: clock.minutes
    readonly property int seconds: clock.seconds
    // readonly property string time: {
    //     Qt.formatDateTime(clock.date, "ddd MMM d hh:mm:ss AP t yyyy");
    // }

    function format(fmt: string): string {
        return Qt.formatDateTime(clock.date, fmt);
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
