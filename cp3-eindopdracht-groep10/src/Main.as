package {

import be.devine.groep10.Application;

import flash.display.Bitmap;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.geom.Rectangle;

import starling.core.Starling;
import starling.display.Image;
import starling.textures.Texture;

[SWF(backgroundColor="#000000")]
public class Main extends Sprite
{
    private var starling:Starling;

    //fonts
    [Embed(source="/../media/fonts/DK_Crayon_Crumble.ttf", embedAsCFF="false", fontFamily="DK_Crayon_Crumble")]
    private static const UbuntuRegular:Class;

    [Embed(source="/../media/fonts/BebasNeue.otf", embedAsCFF="false", fontFamily="Bebas_Neue")]
    private static const BebasNeue:Class;

    public function Main()
    {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;

        starling = new Starling(Application, stage);
        starling.start();

        stage.addEventListener(Event.RESIZE, resizeHandler);
    }

    private function resizeHandler(event:Event):void
    {
        var rect:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
        starling.viewPort = rect;
        starling.stage.stageWidth = stage.stageWidth;
        starling.stage.stageHeight = stage.stageHeight;
    }

}
}
