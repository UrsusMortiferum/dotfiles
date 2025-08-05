import Quickshell
import qs.widgets

Scope {

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30

            Clock {
                anchors.centerIn: parent
            }
            Date {
                anchors.centerIn: parent
            }
        }
    }
}
