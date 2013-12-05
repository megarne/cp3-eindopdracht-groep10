/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 3/12/13
 * Time: 13:50
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.view
{
import flash.display.Bitmap;

import starling.display.Button;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

public class Recipes extends Sprite
    {

        public function Recipes()
        {
            addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

        }


    private function addedToStageHandler(event:Event):void
    {

    }
}
}
