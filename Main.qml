import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    visible: true
    width: 800
    height: 600
    title: "Visual_Classium"

    Canvas {
        id: drawingCanvas
        anchors.fill: parent //canvas takes whole window
        property bool drawing: false //created a bool named drawing
        //property are var but in qml it can be accessed outside of object(eg:canvas, onpaint...)
        //two variable are created to track mouse movements
        property real lastX: 0
        property real lastY: 0

        //event is a parameter in this case MouseEvent and => just a syntax to differentiate between event and code
        onPaint: (event) => {
            var ctx = getContext("2d"); //get all the things happening on windows
            ctx.lineWidth = 2;
            ctx.strokeStyle = "black";
        }

        MouseArea {
            anchors.fill: parent //detect mouse in all area of canvas as mouse.x and mouse.y

            onPressed: (event) => {
                drawingCanvas.drawing = true;
                drawingCanvas.lastX = event.x;
                drawingCanvas.lastY = event.y;

            }
            onReleased: (event) => {
                            drawingCanvas.drawing = false;
                        }

            onPositionChanged: (event) => {
                if (drawingCanvas.drawing) {
                    var ctx = drawingCanvas.getContext("2d"); //new var to get all the context of canvas id:drawingCanvas
                    ctx.beginPath();//for refresh start and not create a mess
                    ctx.moveTo(drawingCanvas.lastX, drawingCanvas.lastY);//moves pen
                    ctx.lineTo(event.x, event.y); //line cordinates are specified lastX,lastY,x,y and drawn
                    ctx.stroke(); //the drawing becomes visible
                    //updates the lastX and lastY to new position of mouse which isnot much far
                    drawingCanvas.lastX = event.x;
                    drawingCanvas.lastY = event.y;
                }
            }
        }
    }
}
