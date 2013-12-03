/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 1/12/13
 * Time: 19:49
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10
{
import be.devine.groep10.view.Help;

import flash.display.Bitmap;
import flash.display.BitmapData;


import starling.display.Button;
import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.Color;
import starling.utils.HAlign;
import starling.utils.VAlign;


public class Application extends Sprite
{
    //bg aanmaken
    [Embed(source="/assets/images/bg.png")]
    public static const BackgroundImage:Class;
    private var _background:Image;

    //title
    private var _appTitle:TextField;

    //menubtn
    private var _menuBtn:Button;
    private var _arrMenu:Array;
    private var _menuContainer:Sprite;

    [Embed(source="/assets/images/decoration.png")]
    public static const Decoration:Class;
    private var _decoration:Image;

    //line
    [Embed(source="/assets/images/line.png")]
    public static const Line:Class;
    private var _line:Image;

    //help
    private var _help:Help;

    public function Application()
    {
        //bg aanmaken
        var backgroundData:Bitmap = new BackgroundImage();
        var textureBackground:Texture = Texture.fromBitmap(backgroundData);
        _background = new Image(textureBackground);
        addChild(_background);

        _appTitle = new starling.text.TextField( 350, 52, "Ingrediënten omvormer", "DK_Crayon_Crumble", 40, Color.WHITE);
        _appTitle.hAlign = HAlign.CENTER;
        _appTitle.vAlign = VAlign.TOP;
        _appTitle.y = 20;
        addChild(_appTitle);

        //line
        var lineData:Bitmap = new Line();
        var textureLine:Texture = Texture.fromBitmap(lineData);
        _line = new Image(textureLine);
        _line.y = _appTitle.y + _appTitle.height - 10;
        _line.width = _appTitle.width;
        addChild(_line);

        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

        _arrMenu = ["recepten", "eigen recepten", "recept toevoegen"];

        _menuContainer = new Sprite();
        addChild(_menuContainer);

        var yPos:uint = 0;

        for each(var _menuLabel:String in _arrMenu)
        {
            var bmpData:BitmapData = new BitmapData(350, 60, false, 0xffffff);
            _menuBtn = new Button(Texture.fromBitmapData(bmpData), _menuLabel);
            _menuBtn.fontColor = 0x00c5a9;
            _menuBtn.fontSize = 25;
            _menuBtn.fontName = "Bebas_Neue";
            _menuBtn.addEventListener(Event.TRIGGERED, buttonHandler);
            _menuBtn.y = yPos;

            yPos += _menuBtn.height + 100;

            _menuContainer.addChild(_menuBtn);

            //decoration
            var decorationData:Bitmap = new Decoration();
            var textureDecoration:Texture = Texture.fromBitmap(decorationData);
            _decoration = new Image(textureDecoration);
            _decoration.x = _menuBtn.x - 20;
            _decoration.y = _menuBtn.y + _menuBtn.height - (_decoration.height/2);
            _menuContainer.addChild(_decoration);
        }

        _help = new Help();
        addChild(_help);
    }

    private function buttonHandler(event:Event):void
    {
        var geklikteButton:Button = event.currentTarget as Button;
        trace(geklikteButton.text);
    }

    private function addedToStageHandler(event:Event):void
    {
        //bg
        _background.x = stage.x;
        _background.y = stage.y;
        _background.width = stage.stageWidth;
        _background.height = stage.stageHeight;

        //line
        _line.x = stage.stageWidth/2 - _line.width/2;

        _menuContainer.x = stage.stageWidth/2 - _menuContainer.width/2;
        _menuContainer.y = 200;

        _appTitle.x = stage.stageWidth/2 - _appTitle.width/2;
    }
}
}
