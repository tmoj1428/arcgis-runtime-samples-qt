// [WriteFile Name=ViewshedLocation, Category=Analysis]
// [Legal]
// Copyright 2017 Esri.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// [Legal]

import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import Esri.Samples 1.0
import Esri.ArcGISExtras 1.1

ViewshedLocationSample {
    id: viewshedSample
    clip: true
    width: 800
    height: 600

    property real scaleFactor: System.displayScaleFactor

    SceneView {
        id: sceneView
        objectName: "sceneView"
        anchors.fill: parent

        Rectangle {
            anchors {
                right: parent.right
                bottom: sceneView.attributionTop
                margins: 10 * scaleFactor
            }
            visible: !optionPanel.visible
            width: 45 * scaleFactor
            height: width
            color: "white"
            radius: 25 * scaleFactor

            Image {
                anchors.centerIn: parent
                source: "qrc:/Samples/Analysis/ViewshedLocation/settings.png"
                width: 40 * scaleFactor
                height: width
            }

            MouseArea {
                anchors.fill: parent
                onClicked: optionPanel.visible = true;
            }
        }


        Rectangle {
            id: optionPanel
            anchors {
                right: parent.right
                top: parent.top
                bottom: sceneView.attributionTop
            }
            width: 260 * scaleFactor
            visible: false
            color: "white"
            opacity: 0.85

            Flickable {
                anchors {
                    fill: parent
                    margins: 5 * scaleFactor
                }
                contentWidth: parent.width
                contentHeight: parent.height
                flickableDirection: Flickable.VerticalFlick

                Column {
                    id: optionColumn
                    spacing: 10 * scaleFactor
                    width: optionPanel.width

                    Item {
                        width: parent.width
                        height: 25 * scaleFactor

                        Text {
                            text: "Viewshed Options"
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.pixelSize: 18 * scaleFactor
                            font.underline: true

                        }

                        Rectangle {
                            anchors {
                                right: parent.right
                                verticalCenter: parent.verticalCenter
                            }
                            width: 45 * scaleFactor
                            height: width
                            color: "transparent"

                            Image {
                                anchors.centerIn: parent
                                source: "qrc:/Samples/Analysis/ViewshedLocation/close.png"
                                width: 40 * scaleFactor
                                height: width
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: optionPanel.visible = false;
                            }
                        }
                    }

                    Item {
                        width: parent.width
                        height: 25 * scaleFactor

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width * 0.75
                            text: qsTr("Viewshed Visible")
                            font.pixelSize: 14 * scaleFactor
                        }

                        Switch {
                            anchors {
                                right: parent.right
                                margins: 10 * scaleFactor
                                verticalCenter: parent.verticalCenter
                            }
                            checked: true
                            onCheckedChanged: viewshedSample.viewshedVisible = checked;
                        }
                    }

                    Item {
                        width: parent.width
                        height: 25 * scaleFactor

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width * 0.75
                            text: qsTr("Frustum Outline Visible")
                            font.pixelSize: 14 * scaleFactor
                        }

                        Switch {
                            anchors {
                                right: parent.right
                                margins: 10 * scaleFactor
                                verticalCenter: parent.verticalCenter
                            }
                            checked: false
                            onCheckedChanged: viewshedSample.frustumVisible = checked;
                        }
                    }

                    ViewshedSlider {
                        titleText: qsTr("Min Distance (m)")
                        parameterValue: viewshedSample.minDistance
                        minValue: 1
                        maxValue: 2000
                        onParameterValueChanged: viewshedSample.minDistance = parameterValue;
                    }

                    ViewshedSlider {
                        titleText: qsTr("Max Distance (m)")
                        parameterValue: viewshedSample.maxDistance
                        minValue: 1
                        maxValue: 2000
                        onParameterValueChanged: viewshedSample.maxDistance = parameterValue;
                    }

                    ViewshedSlider {
                        titleText: qsTr("Vertical Angle")
                        parameterValue: viewshedSample.verticalAngle
                        minValue: 1
                        maxValue: 179
                        onParameterValueChanged: viewshedSample.verticalAngle = parameterValue;
                    }

                    ViewshedSlider {
                        titleText: qsTr("Horizontal Angle")
                        parameterValue: viewshedSample.horizontalAngle
                        minValue: 1
                        maxValue: 179
                        onParameterValueChanged: viewshedSample.horizontalAngle = parameterValue;
                    }

                    ViewshedSlider {
                        titleText: qsTr("Heading")
                        parameterValue: viewshedSample.heading
                        minValue: 1
                        maxValue: 359
                        onParameterValueChanged: viewshedSample.heading = parameterValue;
                    }

                    ViewshedSlider {
                        titleText: qsTr("Pitch")
                        parameterValue: viewshedSample.pitch
                        minValue: 1
                        maxValue: 179
                        onParameterValueChanged: viewshedSample.pitch = parameterValue;
                    }

                    Row {
                        width: parent.width
                        height: 25 * scaleFactor
                        spacing: 5 * scaleFactor

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width * 0.75
                            text: qsTr("Visible Color")
                            font.pixelSize: 14 * scaleFactor
                        }

                        Rectangle {
                            anchors {
                                margins: 10 * scaleFactor
                                verticalCenter: parent.verticalCenter
                            }
                            width: 25 * scaleFactor
                            height: width
                            border {
                                color: "black"
                                width: 1 * scaleFactor
                            }
                            color: viewshedSample.visibleColor
                            radius: 4 * scaleFactor

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    visibleColorDialog.open();
                                }
                            }
                        }
                    }

                    Row {
                        width: parent.width
                        height: 25 * scaleFactor
                        spacing: 5 * scaleFactor

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width * 0.75
                            text: qsTr("Obstructed Color")
                            font.pixelSize: 14 * scaleFactor
                        }

                        Rectangle {
                            anchors {
                                margins: 10 * scaleFactor
                                verticalCenter: parent.verticalCenter
                            }
                            width: 25 * scaleFactor
                            height: width
                            border {
                                color: "black"
                                width: 1 * scaleFactor
                            }
                            color: viewshedSample.obstructedColor
                            radius: 4 * scaleFactor

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    obstructedColorDialog.open();
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    ColorDialog {
        id: visibleColorDialog
        onAccepted: {
            close();
            viewshedSample.visibleColor = color;
        }
    }

    ColorDialog {
        id: obstructedColorDialog
        onAccepted: {
            close();
            viewshedSample.obstructedColor = color;
        }
    }
}