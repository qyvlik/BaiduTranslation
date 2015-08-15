import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

TabView {
    width: 400;
    height: 500;
    Tab{
        title:"翻译"
        BaiduTranslate{ }
    }

    Tab{
        title:"词典"
        BaiduDictionary {
            id:dist;
           }
    }

    style: TabViewStyle {
        // tab's topMargin
        frameOverlap:-1;

        tab: Rectangle {
            color: styleData.selected ? "steelblue" :"lightsteelblue"
            border.color:  "steelblue"
            implicitWidth: Math.max(text.width + 4, 80)
            implicitHeight: 20
            radius: 2
            Text {
                id: text
                anchors.centerIn: parent
                text: styleData.title
                color: styleData.selected ? "white" : "black"
            }
        }
        frame: Rectangle { color: "steelblue" }
    }
}

