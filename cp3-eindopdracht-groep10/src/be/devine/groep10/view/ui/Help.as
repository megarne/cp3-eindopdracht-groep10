/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 2/12/13
 * Time: 22:45
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.view.ui
{

import be.devine.groep10.factory.TextFieldFactory;

import feathers.controls.Button;

import starling.animation.Transitions;

import starling.animation.Tween;

import starling.core.Starling;
import starling.display.Image;
import starling.display.Quad;

import starling.display.Sprite;
import starling.events.Event;

public class Help extends Sprite
{
    private var _bgContainer:Sprite;

    private var _textContainer:Sprite;
    private var _textHelp1:TextFieldFactory;
    private var _textHelp2:TextFieldFactory;
    private var _textBg:Quad;

    [Embed(source = "/../assets/custom/helpDecoration.png")]
    private static const Decoration:Class;
    private var _decoration:Image;

    private var _bg:Quad;

    private var _helpBtn:Button;

    private var _explicitWidth:Number = 0;
    private var _explicitHeight:Number = 0;

    public function Help()
    {
        _bgContainer = new Sprite();
        addChild(_bgContainer);

        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function addedToStageHandler(event:Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

        _bg = new Quad(stage.stageWidth, 600, 0x00c5a9);
        _bgContainer.addChild(_bg);

        _bgContainer.x = stage.stageWidth/2 - _bgContainer.width/2;

        _helpBtn = new Button();
        _helpBtn.addEventListener(Event.TRIGGERED, menuUp);
        _helpBtn.nameList.add( "help-button" );
        _helpBtn.width = _helpBtn.height = 58;
        _helpBtn.x = _bgContainer.width/2 - _helpBtn.width/2;
        _helpBtn.y = _bg.y - _helpBtn.height/2;
        _bgContainer.addChild( _helpBtn );

        addText();
    }
    private function menuUp(event:Event):void
    {
        var tweenUp:Tween = new Tween(_bgContainer, .5, Transitions.EASE_IN);
        tweenUp.animate("y",_explicitHeight/2 - _bgContainer.height/10);
        tweenUp.delay = .05;

        tweenUp.onComplete = onTweenComplete;
        tweenUp.onCompleteArgs = [_bgContainer];

        Starling.juggler.add(tweenUp);

    }

    private function onTweenComplete(_bgContainer:Sprite):void
    {
        _helpBtn.removeEventListener(Event.TRIGGERED, menuUp);
        _helpBtn.addEventListener(Event.TRIGGERED, menuDown);
    }

    private function menuDown(event:Event):void
    {
        var tweenDown:Tween = new Tween(_bgContainer, .5, Transitions.EASE_IN);
        tweenDown.animate("y", _explicitHeight);
        tweenDown.delay = .05;

        tweenDown.onComplete = onTweenCompleteDown;
        tweenDown.onCompleteArgs = [_bgContainer];

        Starling.juggler.add(tweenDown);
    }

    private function onTweenCompleteDown(_bgContainer:Sprite):void
    {
        _helpBtn.removeEventListener(Event.TRIGGERED, menuDown);
        this.removeEventListener(Event.TRIGGERED, menuDown);

        _helpBtn.y = _bg.y - _helpBtn.height/2;

        _helpBtn.addEventListener(Event.TRIGGERED, menuUp);
    }

    private function addText():void
    {
        _textContainer = new Sprite();
        _bgContainer.addChild(_textContainer);

        _textBg = new Quad(350, 210, 0xffffff);
        _textBg.x = stage.stageWidth/2 - _textBg.width/2;
        _textBg.y = _helpBtn.y + _textBg.height/2;
        _textContainer.addChild(_textBg);

        _decoration = Image.fromBitmap(new Decoration());
        _decoration.x = _textBg.x;
        _decoration.y = _textBg.y + _textBg.height - _decoration.height;
        _textContainer.addChild(_decoration);

        _textHelp1 = new TextFieldFactory(320, 120, "Deze app kan je gebruiken om te berekenen hoeveel je van je ingredienten moet gebruiken naar het aantal personen voor wie je kookt.", "BebasNeue", 23, 0x272727);
        _textHelp1.x = stage.stageWidth/2 - _textHelp1.width/2;
        _textHelp1.y = _textBg.y + 10;
        _textContainer.addChild(_textHelp1);

        _textHelp2 = new TextFieldFactory( 320, 25, "Extra! je kan de volumes en gewichten omvormen.", "BebasNeue", 19, 0xc90010);
        _textHelp2.x = stage.stageWidth/2 - _textHelp2.width/2;
        _textHelp2.y = _textHelp1.y + _textHelp1.height + 5;
        _textContainer.addChild(_textHelp2);
    }

    public function setSize(w:Number, h:Number):void
    {
        _explicitWidth = w;
        _explicitHeight = h;

        _bgContainer.width = _explicitWidth;
        _bgContainer.y = _explicitHeight;
    }
}
}
