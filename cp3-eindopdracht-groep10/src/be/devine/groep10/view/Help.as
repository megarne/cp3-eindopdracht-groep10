/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 2/12/13
 * Time: 22:45
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.view
{

import flash.display.BitmapData;
import flash.display.Shape;

import starling.animation.Transitions;

import starling.animation.Tween;
import starling.core.Starling;


import starling.display.Button;
import starling.display.Quad;

import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;
import starling.utils.Color;

public class Help extends Sprite
{
    private var _bg:Quad;

    private var _helpBtn:Button;
    private var _circleSize:uint = 60;

    public function Help()
    {
        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function addedToStageHandler(event:Event):void
    {
        _bg = new Quad(stage.stageWidth, 600, 0x00c5a9);
        _bg.x = stage.stageWidth/2 - _bg.width/2;
        _bg.y = stage.stageHeight - 60;
        addChild(_bg);

        var shape:Shape = new Shape();
        shape.graphics.beginFill(0x00c5a9);
        shape.graphics.drawEllipse(0, 0, _circleSize, _circleSize);
        shape.graphics.endFill();

        var shapeData:BitmapData = new BitmapData(_circleSize, _circleSize, true, 0);
        shapeData.draw(shape);
        var texture:Texture = Texture.fromBitmapData(shapeData);

        _helpBtn = new Button(texture, "?");
        _helpBtn.fontColor = Color.WHITE;
        _helpBtn.fontName = "Bebas_Neue";
        _helpBtn.fontSize = 45;
        _helpBtn.addEventListener(Event.TRIGGERED, menuUp);
        addChild(_helpBtn);

        _helpBtn.x = stage.stageWidth/2 - _helpBtn.width/2;
        _helpBtn.y = _bg.y - (_helpBtn.height/2);
    }

    private function menuUp(event:Event):void
    {
        var tweenUp:Tween = new Tween(_bg, .5, Transitions.EASE_IN);
        tweenUp.animate("y", stage.stageHeight - _bg.height);
        tweenUp.delay = .05;

        tweenUp.onComplete = onTweenComplete;
        tweenUp.onCompleteArgs = [_bg];

        Starling.juggler.add(tweenUp);
    }

    private function onTweenComplete(_bg:Quad):void
    {
        _helpBtn.removeEventListener(Event.TRIGGERED, menuUp);

        _helpBtn.y = _bg.y - (_helpBtn.height/2);
        _helpBtn.text = "X";
        _helpBtn.fontSize = 40;

        _helpBtn.addEventListener(Event.TRIGGERED, menuDown);
    }

    private function menuDown(event:Event):void
    {
        var tweenDown:Tween = new Tween(_bg, .5, Transitions.EASE_IN);
        tweenDown.animate("y", stage.stageHeight - 60);
        tweenDown.delay = .05;

        tweenDown.onComplete = onTweenCompleteDown;
        tweenDown.onCompleteArgs = [_bg];

        Starling.juggler.add(tweenDown);
    }

    private function onTweenCompleteDown(_bg:Quad):void
    {
        _helpBtn.removeEventListener(Event.TRIGGERED, menuDown);

        _helpBtn.y = _bg.y - (_helpBtn.height/2);
        _helpBtn.text = "?";
        _helpBtn.fontSize = 45;

        _helpBtn.addEventListener(Event.TRIGGERED, menuUp);
    }
}
}
