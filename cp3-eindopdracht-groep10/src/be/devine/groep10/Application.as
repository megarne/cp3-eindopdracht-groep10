/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 1/12/13
 * Time: 19:49
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10
{
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
    private var background:Image;

    [Embed(source="/../media/fonts/DK_Crayon_Crumble.ttf", embedAsCFF="false", fontFamily="DK_Crayon_Crumble")]
    private static const UbuntuRegular:Class;

    private var _appTitle:TextField;

    private var _menuBtn:Button;
    private var _arrMenu:Array;
    private var _menuContainer:Sprite;

    public function Application()
    {
        //bg aanmaken
        var backgroundData:Bitmap = new BackgroundImage();
        var textureBackground:Texture = Texture.fromBitmap(backgroundData);
        background = new Image(textureBackground);
        addChild(background);

        _appTitle = new starling.text.TextField( 350, 100, "Ingrediënten omvormer", "DK_Crayon_Crumble", 40, Color.WHITE);
        _appTitle.hAlign = HAlign.CENTER;
        _appTitle.vAlign = VAlign.TOP;
        _appTitle.y = 20;
        addChild(_appTitle);


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
            _menuBtn.addEventListener(Event.TRIGGERED, buttonHandler);
            _menuBtn.y = yPos;

            yPos += _menuBtn.height + 40;

            _menuContainer.addChild(_menuBtn);
        }


    }

    private function buttonHandler(event:Event):void
    {
        var geklikteButton:Button = event.currentTarget as Button;
        trace(geklikteButton.text);
        //geklikteButton.alpha = 0;
        //trace(geklikteButton);
    }

    private function addedToStageHandler(event:Event):void
    {
        //bg
        background.x = stage.x;
        background.y = stage.y;
        background.width = stage.stageWidth;
        background.height = stage.stageHeight;


        _menuContainer.x = stage.stageWidth/2 - _menuContainer.width/2;
        _menuContainer.y = 200;

        _appTitle.x = stage.stageWidth/2 - _appTitle.width/2;
    }
}
}
