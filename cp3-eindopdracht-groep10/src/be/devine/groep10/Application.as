/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 1/12/13
 * Time: 19:49
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10
{
import be.devine.groep10.model.AppModel;
import be.devine.groep10.view.Add;
import be.devine.groep10.view.Menu;
import be.devine.groep10.view.Recipes;
import be.devine.groep10.view.ui.Help;

import feathers.controls.Header;

import feathers.themes.MetalWorksMobileTheme;

import flash.display.Bitmap;

import flash.events.Event;

import starling.display.Button;

import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

public class Application extends Sprite
{
    private var _appModel:AppModel;

    private var _header:Header;
    private var _menu:Menu;
    private var _help:Help;

    [Embed(source = "/../assets/custom/house.png")]
    private static const ButtonTexture:Class;
    private var _homeBtn:starling.display.Button;

    private var _recipes:Recipes;
    private var _add:Add;

    public function Application()
    {
        new MetalWorksMobileTheme();

        _header = new Header();
        _header.title = "Keuken omvormer";
        addChild( _header );

        _appModel = AppModel.getInstance();
        _appModel.load();

        _menu = new Menu();
        addChild(_menu);

        _help = new Help();
        addChild(_help);

        _add = new Add();

        var homeBtnSkin:Bitmap = new ButtonTexture();
        var homeBtnTexture:Texture = Texture.fromBitmap(homeBtnSkin);
        _homeBtn = new starling.display.Button(homeBtnTexture, "");

        _appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, pageChangedHandler);

        addEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
    }

    private function addedHandler(event:starling.events.Event):void
    {
        removeEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
        stage.addEventListener(starling.events.Event.RESIZE, resizeHandler);
        layout();
    }

    private function resizeHandler(event:starling.events.Event):void
    {
        layout();
    }

    private function layout():void
    {
        _header.y = 20;
        _header.setSize(stage.stageWidth, 50);

        _menu.y = 100;
        _menu.setSize(stage.stageWidth, 50);

        _help.setSize(stage.stageWidth, stage.stageHeight);

        _homeBtn.x = stage.stageWidth - _homeBtn.width - 20;
        _homeBtn.y = 10;

        _add.y = 100;
        _add.setSize(stage.stageWidth, stage.stageHeight);
    }

    private function pageChangedHandler(event:flash.events.Event):void
    {
        addChild(_homeBtn);

        _homeBtn.addEventListener( starling.events.Event.TRIGGERED, GoBackHomeHandler );

        _header.title = _appModel.currentPage;

        switch(_appModel.currentPage)
        {
            case "recepten":
                _recipes = new Recipes();
                addChild(_recipes);
                break;

            case "eigen recepten":
                _recipes = new Recipes();
                addChild(_recipes);
                break;

            case "recept toevoegen":
                _add = new Add();
                addChild(_add);
                break;
        }

        layout();

        removeChild(_menu);
        removeChild(_help);
    }

    function GoBackHomeHandler( event:starling.events.Event ):void
    {
        switch(_appModel.currentPage)
        {
            case "recepten":
                _recipes = new Recipes();
                removeChild(_recipes);
                _appModel.currentPage= "Keuken omvormer";
                break;

            case "eigen recepten":
                _recipes = new Recipes();
                removeChild(_recipes);
                removeChild(_homeBtn);
                _appModel.currentPage= "Keuken omvormer";
                break;

            case "recept toevoegen":
                _add = new Add();
                removeChild(_add);
                removeChild(_homeBtn);
                _appModel.currentPage= "Keuken omvormer";
                break;
        }

        if(_header.title == "Keuken omvormer")
        {
            removeChild(_homeBtn);
            addChild(_menu);
            addChild(_help);
        }

    }
}
}
