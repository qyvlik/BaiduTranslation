import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

import "./api" as API;
import "./component" as Com;

Item {
    id:root;
    width: 400;
    height: 400;

    API.BaiduTranslateAPI{
        id:tr;
        translateSource: input.text;
        onHasErrorChanged: {
            if(tr.hasError){
                //show.color = "red";
                show.text = tr.error_code + '\n'+tr.error_msg;
            } else {
                //show.color = "black";
            }
        }
    }

    Column{

        TextArea {
            id:input;
            width: root.width;
            style: TextAreaStyle {
                textColor: "#333"
                selectionColor: "steelblue"
                selectedTextColor: "#eee"
                backgroundColor: "#eee"
            }
        }
        Row{
            id:d;

            Com.DropDownButton{
                tr:tr;
                flag:true;
            }

            Button{
                text:"==>";
                onClicked: {
                    tr.startTranslater();
                }
            }

            Com.DropDownButton{
                tr:tr;
                flag:false;
            }

        }
        TextArea {
            id:show;
            width: root.width;
            height: root.width*0.3;
            text:tr.translateResult;
            readOnly:true;
            style: TextAreaStyle {
                textColor: "#333"
                selectionColor: "steelblue"
                selectedTextColor: "#eee"
                backgroundColor: "#eee"
            }
        }
    }

}
