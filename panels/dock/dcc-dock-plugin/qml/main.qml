//SPDX-FileCopyrightText: 2024 UnionTech Software Technology Co., Ltd.
//
//SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.15

import org.deepin.dcc 1.0
import org.deepin.dtk 1.0 as D

DccObject {
    DccTitleObject {
        name: "taskBarTitle"
        weight: 500
        parentName: "personalization/taskBar"
        displayName: qsTr("Dock")
    }

    DccObject {
        name: "taskBarModeGroup"
        parentName: "personalization/taskBar"
        weight: 600
        pageType: DccObject.Item
        page: DccGroupView {}

        DccObject {
            name: "dockmode"
            parentName: "personalization/taskBar/taskBarModeGroup"
            displayName: qsTr("Mode")
            weight: 10
            pageType: DccObject.Item
            page: ColumnLayout {
                Label {
                    Layout.topMargin: 10
                    font: D.DTK.fontManager.t7
                    text: dccObj.displayName
                    Layout.leftMargin: 10
                }
                GridLayout {
                    id: modeLayout
                    rows: 1
                    Layout.bottomMargin: 10

                    ListModel {
                        id: modeData
                        ListElement { text: qsTr("Classic Mode"); icon: "effcient_left"; value: 1 }
                        ListElement { text: qsTr("Centered Mode"); icon: "effcient_center"; value: 0 }
                        // ListElement { text: qsTr("Fashion Mode"); icon: "fashion"; value: 2 }
                    }

                    Repeater {
                        model: modeData
                        ColumnLayout {
                            Item {
                                id: borderRect
                                Layout.preferredWidth: 206
                                Layout.preferredHeight: 100
                                Layout.alignment: Qt.AlignHCenter

                                Rectangle {
                                    anchors.fill: parent
                                    radius: 12
                                    color: "transparent"
                                    border.width: 2
                                    border.color: D.DTK.platformTheme.activeColor
                                    visible: dccData.dockInter.DisplayMode === model.value
                                }

                                D.DciIcon {
                                    anchors.fill: parent
                                    anchors.margins: 4
                                    sourceSize: Qt.size(width, height)
                                    name: model.icon
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        dccData.dockInter.setDisplayMode(model.value)
                                    }
                                }
                            }

                            Text {
                                text: model.text
                                Layout.fillWidth: true
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                color: dccData.dockInter.DisplayMode === model.value ? 
                                    D.DTK.platformTheme.activeColor : this.palette.windowText
                            }
                        }
                    }
                }
            }
        }
    }

    DccObject {
        name: "dockSettingsGroup"
        parentName: "personalization/taskBar"
        weight: 700
        pageType: DccObject.Item
        page: DccGroupView {}

        DccObject {
            name: "docksize"
            parentName: "personalization/taskBar/dockSettingsGroup"
            displayName: qsTr("Dock size")
            weight: 10
            pageType: DccObject.Editor
            page: RowLayout {
                spacing: 10
                Label {
                    Layout.alignment: Qt.AlignVCenter
                    font: D.DTK.fontManager.t7
                    text: qsTr("Small")
                }
                D.Slider {
                    Layout.alignment: Qt.AlignVCenter
                    id: balanceSlider
                    handleType: Slider.HandleType.ArrowBottom
                    implicitHeight: 24
                    highlightedPassedGroove: true
                    stepSize: 1
                    value: dccData.dockInter.DisplayMode === 2 ? dccData.dockInter.WindowSizeFashion : dccData.dockInter.WindowSizeEfficient 
                    from: 37
                    to: 100

                    onValueChanged: {
                        dccData.dockInter.resizeDock(value, true)
                    }

                    onPressedChanged: {
                        dccData.dockInter.resizeDock(value, pressed)
                    }
                }
                D.Label {
                    Layout.alignment: Qt.AlignVCenter
                    font: D.DTK.fontManager.t7
                    text: qsTr("Large")
                }
            }
        }

        DccObject {
            name: "positionInScreen"
            parentName: "personalization/taskBar/dockSettingsGroup"
            displayName: qsTr("Position on the screen")
            weight: 100
            pageType: DccObject.Editor
            page: CustomComBobox {
                flat: true
                model: alignModel
                currentIndex: indexByValue(dccData.dockInter.Position)

                ListModel {
                    id: alignModel
                    ListElement { text: qsTr("Top"); value: 0 }
                    ListElement { text: qsTr("Bottom"); value: 2 }
                    ListElement { text: qsTr("Left"); value: 3 }
                    ListElement { text: qsTr("Right"); value: 1 }
                }

                onCurrentIndexChanged: {
                    var selectedValue = model.get(currentIndex).value;
                    dccData.dockInter.setPosition(selectedValue)
                }
            }
        }

        DccObject {
            name: "positionInScreen"
            parentName: "personalization/taskBar/dockSettingsGroup"
            displayName: qsTr("Status")
            weight: 200
            pageType: DccObject.Editor
            page: CustomComBobox {
                flat: true
                model: hideModel
                currentIndex: indexByValue(dccData.dockInter.HideMode)

                ListModel {
                    id: hideModel
                    ListElement { text: qsTr("Keep shown"); value: 0 }
                    ListElement { text: qsTr("Keep hidden"); value: 1 }
                    ListElement { text: qsTr("Smart hide"); value: 2 }
                }

                onCurrentIndexChanged: {
                    var selectedValue = model.get(currentIndex).value;
                    dccData.dockInter.setHideMode(selectedValue)
                }
            }
        }
    }

    DccObject {
        name: "multiscreenGroup"
        parentName: "personalization/taskBar"
        weight: 800
        pageType: DccObject.Item
        page: DccGroupView {}

        DccObject {
            name: "multiscreenItem"
            parentName: "personalization/taskBar/multiscreenGroup"
            displayName: qsTr("Multiple Displays")
            description: qsTr("Set the position of the taskbar on the screen")
            visible: Qt.application.screens.length > 1
            weight: 10
            pageType: DccObject.Editor
            page: CustomComBobox {
                flat: true
                model: showModeModel
                currentIndex: indexByValue(dccData.dockInter.showInPrimary)

                ListModel {
                    id: showModeModel
                    ListElement { text: qsTr("Only on main"); value: true }
                    ListElement { text: qsTr("On screen where the cursor is"); value: false }
                }

                onCurrentIndexChanged: {
                    var selectedValue = model.get(currentIndex).value;
                    dccData.dockInter.setShowInPrimary(selectedValue)
                }
            }
        }
    }

    DccObject {
        name: "pluginArea"
        weight:900
        icon: "plugin"
        parentName: "personalization/taskBar"
        displayName: qsTr("Plugin Area")
        description: qsTr("Select which icons appear in the Dock")

        PluginArea {}
    }
}
