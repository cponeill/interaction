import SimpleOpenNI.*;
SimpleOpenNI context;

int closestValue, closestX, closestY;

int previousX, previousY;

void setup()
{
    size(640, 480);
    context = new SimpleOpenNI(this);
    context.enableDepth();
}

void draw()
{
    closestValue = 8000;

    context.update();

    int[] depthValue = kinect.depthMap();
    for(int y = 0; y < 480; y++) {
        for(int x = 0; x < 640; x++) {
            int i = x + y * 640;
            int currentDepthValue = depthValues[i];

            if (currentDepthValue > 0 && currentDepthValue < closestValue) {
                closestValue = currentDepthValue;
                closestX = x;
                closestY = y;
            }
        }
     }
     image.context(depthImage(), 0, 0);
     stroke(255, 0, 0);
     line(previousX, previousY, closestX, closestY);
     previousX = closestX;
     previousY = closestY;
}