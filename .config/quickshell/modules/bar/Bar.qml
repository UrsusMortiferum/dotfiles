import Quickshell
import qs.widgets
import QtQuick

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

            Row {
              anchors.centerIn: parent
              spacing: 10

              Clock { }
              Date { }
          }
        }
    }
}
