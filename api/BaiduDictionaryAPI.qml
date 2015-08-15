import QtQuick 2.0

QtObject {

    id:dict

    signal finish;

    // 开发者在百度开发者中心注册得到的授权API key    
    // 现在竟然不用api也可以进行翻译

    // YQwRndnR16HFR7DiB8YOiEkD
    // 如果需要可以使用上面这个apikey
    property string apiKey;

    property string from :"auto";
    property string to :"auto";

    property string error;

    property bool hasError: false;
    property string error_code : "";
    property string error_msg : "";

    // 待翻译内容	 该字段必须为UTF-8编码，并且以GET方式调用API时，需要进行 urlencode 编码。
    property string translateSource;

    property string translateResult : "";  // 翻译的内容

    readonly property variant
    fromAndToList : ["auto","zh", "en"];

    readonly property variant
    fromAndToListUser:["自动检测","中文", "英语"];

    function startTranslater(){
        var translateUrl = String("http://openapi.baidu.com/public/2.0/translate/dict/simple");
        var doc = new XMLHttpRequest();
        doc.onreadystatechange =
                function() {
                    if (doc.readyState == XMLHttpRequest.DONE) {
                        if(doc.status == 200){
                            //console.debug(doc.responseText);
                            getResult(doc.responseText);
                        }else {
                            console.log("status:"+doc.status);
                        }
                    }
                }
        doc.open("GET", translateUrl+"?client_id="+apiKey+"&q="+translateSource+"&from="+from+"&to="+to);
        doc.send();
    }


    function getResult(result_json_text){
        var jsonObj = JSON.parse(result_json_text);
        if(jsonObj.hasOwnProperty("errno")){
            if(jsonObj.errno !== 0){
                dict.error_code = jsonObj.errno;
                hasError = true;
                return "";
            }
        }

        if(jsonObj.hasOwnProperty("data")){
            // clear
            translateResult = "";
            var s1 = "";
            var s2 = "";
            var i,j;

            for(j=0; j<jsonObj.data.symbols.length;j++){
                s1 += "<p><h1>"+jsonObj.data.word_name+"</h1></p>"
                       +"<p> 美 ["+jsonObj.data.symbols[j].ph_am+"]"+" / "+"英 ["
                       +jsonObj.data.symbols[j].ph_en+"]"
                       +" / 拼 ["+ jsonObj.data.symbols[j].ph_zh+"]"
                       +"</p>";
               for(i=0; i<jsonObj.data.symbols[0].parts.length;i++){
                   s2 += "<p>"+jsonObj.data.symbols[0].parts[i].part + " "
                               +jsonObj.data.symbols[0].parts[i].means+"</p>";
               }
               translateResult += s1+s2;
               s1 = "";
               s2 = "";
            }

            dict.finish();
            return translateResult;
        }
        return "";
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

{
    "errno": 0,
    "data": {
        "word_name": "干",
        "symbols": [
            {
                "ph_zh": "gān",
                "parts": [
                    {
                        "part": "名",
                        "means": [
                            "shield",
                            "short for the ten Heavenly Stems",
                            "[书]the edge of waters",
                            "a surname"
                        ]
                    },
                    {
                        "part": "形",
                        "means": [
                            "dry",
                            "waterless",
                            "empty",
                            "hollow"
                        ]
                    },
                    {
                        "part": "动",
                        "means": [
                            "[书]offend",
                            "have to do with",
                            "be concerned with",
                            "be implicated in"
                        ]
                    },
                    {
                        "part": "副",
                        "means": [
                            "with no result",
                            "futilely",
                            "superficially",
                            "in vain"
                        ]
                    }
                ]
            },
            {
                "ph_zh": "gàn",
                "parts": [
                    {
                        "part": "名",
                        "means": [
                            "trunk",
                            "main part",
                            "short for cadre",
                            "a surname"
                        ]
                    },
                    {
                        "part": "动",
                        "means": [
                            "do",
                            "work",
                            "hold the post of",
                            "be engaged in"
                        ]
                    },
                    {
                        "part": "形",
                        "means": [
                            "able",
                            "capable",
                            "[方]worse",
                            "bad "
                        ]
                    }
                ]
            }
        ]
    },
    "to": "en",
    "from": "zh"
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
