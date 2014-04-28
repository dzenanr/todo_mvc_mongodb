part of todo_mvc;

// http://www.json.org/
// http://jsonformatter.curiousconcept.com/

// lib/todo/mvc/json/model.dart

var todoMvcModelJson = r'''
{
    "width":990,
    "height":580,
    "boxes":[
        {
            "name":"Task",
            "entry":true,
            "x":81,
            "y":88,
            "width":80,
            "height":60,
            "items":[
                {
                    "sequence":10,
                    "name":"title",
                    "category":"identifier",
                    "type":"String",
                    "init":"",
                    "essential":true,
                    "sensitive":false
                },
                {
                    "sequence":20,
                    "name":"completed",
                    "category":"required",
                    "type":"bool",
                    "init":"false",
                    "essential":true,
                    "sensitive":false
                }
            ]
        }
    ],
    "lines":[
        
    ]
}
''';
  