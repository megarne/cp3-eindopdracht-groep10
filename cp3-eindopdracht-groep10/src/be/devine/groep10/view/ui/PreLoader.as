/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 30/11/13
 * Time: 14:19
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.view.ui
{

import flash.display.Sprite;
import flash.events.Event;

public class PreLoader extends Sprite
{
    private const DEBUG_MODE:Boolean = false;

    public var MAX_WIDTH:uint;
    public var MAX_HEIGHT:uint;
    public var COLOR:uint;

    private var percentage:Number;
    private var bar:Sprite;

    public function Preloader( barWidth:uint = 100, barHeight:uint = 10, barColor:uint = 0x000000 )
    {
        MAX_WIDTH = barWidth;
        MAX_HEIGHT = barHeight;
        COLOR = barColor;

        percentage = 0;

        bar = new Sprite();
        addChild(bar);

        if( DEBUG_MODE == true )
        {
            this.addEventListener( Event.ENTER_FRAME, enterFrameHandler );
        }
    }

    private function enterFrameHandler(event:Event):void
    {
        if( percentage < 1 )
        {
            var newPercentage:Number = percentage + 0.1;
            update( newPercentage );
        }
        else
        {
            this.removeEventListener( Event.ENTER_FRAME, enterFrameHandler );
        }
    }

    public function update( newPercentage:Number ):void
    {
        percentage = newPercentage;

        draw(percentage);
    }

    private function draw( newPercentage:Number ):void
    {
        var barWidth:Number = MAX_WIDTH * newPercentage;

        bar.graphics.beginFill( COLOR );
        bar.graphics.drawRect( 0, 0, barWidth,MAX_HEIGHT );
        bar.graphics.endFill();
    }
}
}