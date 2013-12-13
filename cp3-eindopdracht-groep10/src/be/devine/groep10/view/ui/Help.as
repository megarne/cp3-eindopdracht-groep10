
package be.devine.groep10.view.ui
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
import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.Color;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class Help extends Sprite
{
    private var _bg:Quad;
    private var _bgContainer:Sprite;

    private var _helpBtn:Button;
    private var _circleSize:uint = 60;

    private var _textBg:Quad;
    private var _textContainer:Sprite;
    private var _textHelp:TextField;

    private var _explicitWidth:Number = 0;
    private var _explicitHeight:Number = 0;

    public function Help()
    {

        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    private function addedToStageHandler(event:Event):void
    {
        _bgContainer = new Sprite();
        addChild(_bgContainer);
        setChildIndex(_bgContainer, numChildren -1);

        _bg = new Quad(stage.stageWidth, 600, 0x00c5a9);
        _bg.x = stage.stageWidth/2 - _bg.width/2;
        _bg.y = stage.stageHeight - _bg.height/10;
        _bgContainer.addChild(_bg);

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
        _bgContainer.addChild(_helpBtn);

        _helpBtn.x = stage.stageWidth/2 - _helpBtn.width/2;
        _helpBtn.y = _bg.y - _helpBtn.height/2;

        addText();
    }

    private function menuUp(event:Event):void
    {
        var tweenUp:Tween = new Tween(_bgContainer, .5, Transitions.EASE_IN);
        tweenUp.animate("y",-(stage.stageHeight/2 + _bg.height/5));
        tweenUp.delay = .05;

        tweenUp.onComplete = onTweenComplete;
        tweenUp.onCompleteArgs = [_bgContainer];

        Starling.juggler.add(tweenUp);
    }

    private function onTweenComplete(_bg:Sprite):void
    {
        _helpBtn.removeEventListener(Event.TRIGGERED, menuUp);

        _helpBtn.text = "X";
        _helpBtn.fontSize = 40;

        _helpBtn.addEventListener(Event.TRIGGERED, menuDown);
    }

    private function menuDown(event:Event):void
    {
        var tweenDown:Tween = new Tween(_bgContainer, .5, Transitions.EASE_IN);
        tweenDown.animate("y", -(stage.stageHeight - _bg.height - 200));
        //tweenDown.animate("y", -(stage.stageHeight - _bg.height));
        tweenDown.delay = .05;

        tweenDown.onComplete = onTweenCompleteDown;
        tweenDown.onCompleteArgs = [_bgContainer];

        Starling.juggler.add(tweenDown);
    }

    private function onTweenCompleteDown(_bgContainer:Sprite):void
    {
        _helpBtn.removeEventListener(Event.TRIGGERED, menuDown);

        _helpBtn.y = _bg.y - _helpBtn.height/2;
        _helpBtn.text = "?";
        _helpBtn.fontSize = 45;

        _helpBtn.addEventListener(Event.TRIGGERED, menuUp);
    }

    private function addText():void
    {
        _textContainer = new Sprite();
        _bgContainer.addChild(_textContainer);

        _textBg = new Quad(350, 350, 0xffffff);
        _textBg.x = stage.stageWidth/2 - _textBg.width/2;
        _textBg.y = _bg.height + _textBg.height/2 + 50;

        _textContainer.addChild(_textBg);

        _textHelp = new starling.text.TextField( 320, 320, "Deze app kan je gebruiken om te berekenen hoeveel je van je ingredienten moet gebruiken naar het aantal personen voor wie je kookt. Extra! je kan de volumes en gewichten omvormen.", "Bebas_Neue", 23, 0x272727);
        _textHelp.hAlign = HAlign.LEFT;
        _textHelp.vAlign = VAlign.TOP;
        _textHelp.kerning = true;
        _textHelp.x = stage.stageWidth/2 - _textHelp.width/2;
        _textHelp.y = _textBg.y + 10;
        _textContainer.addChild(_textHelp);
    }

    public function setSize(w:Number, h:Number):void
    {
        _explicitWidth = w;
        _explicitHeight = h;
    }
}
}
