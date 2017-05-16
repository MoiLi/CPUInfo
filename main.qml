import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import org.device.info 1.0;

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("CPU Info")

    TabView {
        id: tabView
        anchors.fill: parent

        style: TabViewStyle {
            frameOverlap: 1
            tab: Rectangle {
                color: styleData.selected ? "steelblue" :"lightsteelblue"
                border.color:  "#343434"
                implicitWidth: Math.max(text.width + 4, 80)
                implicitHeight: 30
                radius: 2
                Text {
                    id: text
                    anchors.centerIn: parent
                    text: styleData.title
                    color: styleData.selected ? "white" : "black"
                }
            }
            frame: Rectangle { color: "#343434" }
        }

        Component{
            id:viewComp
            ListView{
                anchors.fill:parent
                anchors.margins: 20

                model: ListModel {}
                delegate: infoDelegate
            }
        }

        Component {
            id: infoDelegate

            Item {
                id: wrapper
                width: parent.width
                height: contactInfo.height + 8
                clip: true
                Column {
                    id: contactInfo
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 6
                    Text {
                        text: name
                        font.pixelSize: 14
                        font.bold: true
                        color: "white"
                    }
                    Grid {
                        spacing: 8
                        leftPadding: 12
                        columns: 6
                        Repeater {
                            model: value.split(" ")

                            Text {
                                text: modelData
                                color: "#a1a1a1"
                                font.italic: true
                                font.pixelSize: 12
                            }
                        }
                    }
                }
            }
        }

        function loadTab(){
            var t=tabView.addTab("CPU " + count,viewComp);
            currentIndex=count-1;
            return t.item;
        }
    }

    LoadingScreen {
        id: loading
    }

    CPUInfo {
        id : cpuInfo
        source: "/proc/cpuinfo"

        onDataChanged: {
            for (var i=0; i < data.length; i++) {
                var t = tabView.loadTab();

                for (var k in data[i]) {
                    t.model.append({"name":k, "value": data[i][k]});
                }
            }
            tabView.currentIndex = 0;
            timer.start()
        }
    }

    Timer {
        id: timer
        interval: 1500; running: false;
        onTriggered: {
            loading.hide()
        }
    }

    Component.onCompleted: {
        cpuInfo.startLoadCPUInfo();
    }
}
