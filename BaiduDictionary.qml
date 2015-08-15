import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

import "./api" as API

Item {
    id:root;
    width: 400;
    height: 400;

    API.BaiduDictionaryAPI{
        id:dist;
        translateSource: input.text;
        onFinish: {
            show.text = dist.translateResult;
        }
    }
    focus:true;
    Keys.onPressed: {
        if(event.key == Qt.Key_Return){
            dist.startTranslater();
            event.accepted = true;
        }
    }

    TextField{
        id:input;
        anchors{
            right: root.right;
            left:root.left;
            rightMargin: root.width*0.2;
            leftMargin:root.width*0.2;
        }

        placeholderText: qsTr("在此输入要查询的单词");
        style: TextFieldStyle {
            textColor: "black"
            background: Rectangle {
                radius: 2
                implicitWidth: 100
                implicitHeight: 24
                border.color: "#333"
                border.width: 1
            }
        }
    }
    Button{
        text:qsTr("翻译");
        onClicked: {
            dist.startTranslater();
        }
    }
    TextArea {
        id:show;
        width: root.width;
        anchors.top:input.bottom;
        anchors.topMargin: 10
        height: root.width*0.4;
        readOnly:true;
        textFormat:TextEdit.RichText;
        style: TextAreaStyle {
            textColor: "#333"
            selectionColor: "steelblue"
            selectedTextColor: "#eee"
            backgroundColor: "#eee"
        }
    }
}

/*
{
    "errno": 0,
    "data": {
        "word_name": "do",
        "symbols": [
            {
                "ph_am": "du",
                "ph_en": "du:",
                "parts": [
                    {
                        "part": "aux.",
                        "means": [
                            "（构成疑问句和否定句）",
                            "（代替动词）",
                            "（用于加强语气）"
                        ]
                    },
                    {
                        "part": "vt.& vi.",
                        "means": [
                            "做",
                            "干",
                            "学习",
                            "研究"
                        ]
                    }
                ]
            }
        ]
    },
    "to": "zh",
    "from": "en"
}

errno	 错误码	 0为成功返回，其他都为失败
from	 源语言语种
to	 请求词典的语种
word_name	 请求的词语
ph_am	 美式音标	 英中方向
ph_en	 英式音标	 英中方向
ph_zh	中文拼音	中英方向
part	每个翻译的词性
means	该词性情况下的释义

*/


