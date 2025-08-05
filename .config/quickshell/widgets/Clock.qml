import QtQuick
import "../services/"

Text {
    // text: Time.time
    text: Time.format("hh:mm:ss A")
    // text: Time.format("hh\nmm")
}
