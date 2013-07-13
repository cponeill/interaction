import SimpleOpenNI.*;
SimpleOpenNI context;

int closestValue, closestX, closestY;

float lastX;
float lastY;;

void setup()
{
    size(640, 480);
    context = new SimpleOpenNI(this);
    context.enableDepth();
    background(0);
}

void draw()
{
    closestValue = 8000;

    context.update();

    int[] depthValue = context.depthMap();
    for(int y = 0; y < 480; y++) {
        for(int x = 0; x < 640; x++) {
            int reversedX = 640 - x - 1;
            int i = reversedX + y * 640;
            int currentDepthValue = depthValue[i];

            if (currentDepthValue > 610 && currentDepthValue < 1525 && currentDepthValue < closestValue) { 
                closestValue = currentDepthValue;
                closestX = x;
                closestY = y;
            }
        }
     }
     float interpolatedX = lerp(lastX, lastY, 0.3f);
     float interpolatedY = lerp(lastY, closestY, 0.3f);  
     stroke(255, 0, 0);
     strokeWeight(3);
     line(lastX, lastY, interpolatedX, interpolatedY);
     lastX = interpolatedX;
     lastY = interpolatedY; 
}

void mousePressed()
{
    save("drawing.png");
    background(0);
}   