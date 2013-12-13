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
import be.devine.groep10.view.Detail;
import be.devine.groep10.view.Menu;
import be.devine.groep10.view.Recipes;
import be.devine.groep10.view.ui.Help;

import feathers.controls.Header;
import feathers.themes.ConverterTheme;

import flash.display.Bitmap;

import flash.events.Event;

import starling.display.Button;
import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

public class Application extends Sprite
{
    [Embed(source = "/../assets/custom/bg.png")]
    private static const BackgroundClass:Class;
    private var _bg:Image;

    [Embed(source = "/../assets/custom/bgImage.png")]
    private static const ImageBgClass:Class;
    private var _bgImage:Image;

    private var _appModel:AppModel;

    private var _header:Header;
    [Embed(source = "/../assets/custom/line.png")]
    private static const LineTexture:Class;
    private var _line:Image;

    private var _menu:Menu;
    private var _help:Help;

    [Embed(source = "/../assets/custom/house.png")]
    private static const ButtonTexture:Class;
    private var _homeBtn:Button;

    private var _recipes:Recipes;
    private var _ownRecipes:Recipes;
    private var _add:Add;
    private var _detail:Detail;

    private var _container:Sprite;

    public function Application()
    {
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);

        _bg = Image.fromBitmap(new BackgroundClass());
        addChild(_bg);

        _bgImage = Image.fromBitmap(new ImageBgClass());
        addChild(_bgImage);

        new ConverterTheme();

        _header = new Header();
        _header.title = "Keuken omvormer";
        addChild( _header );
        _line = Image.fromBitmap(new LineTexture());
        _line.y = 40;
        _header.addChild(_line);

        _appModel = AppModel.getInstance();
        _appModel.load();

        _menu = new Menu();
        addChild(_menu);

        _help = new Help();
        addChild(_help);

        _recipes = new Recipes();
        _ownRecipes = new Recipes();

        _add = new Add();

        var homeBtnSkin:Bitmap = new ButtonTexture();
        var homeBtnTexture:Texture = Texture.fromBitmap(homeBtnSkin);
        _homeBtn = new Button(homeBtnTexture, "");

        _header.addChild(_homeBtn);
        _homeBtn.visible = false;

        _appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, pageChangedHandler);
    }

    private function addedHandler(event:starling.events.Event):void
    {
        removeEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
        stage.addEventListener(starling.events.Event.RESIZE, resizeHandler);
        layout();

        _bgImage.x = stage.stageWidth/2 - _bgImage.width/2;
        _bgImage.y = _menu.y + _menu.height + _bgImage.height + 50;
    }

    private function resizeHandler(event:starling.events.Event):void
    {
        layout();
    }

    private function layout():void
    {
        _bg.width = stage.stageWidth;
        _bg.height = stage.stageHeight;

        _bgImage.x = stage.stageWidth/2 - _bgImage.width/2;
        _bgImage.y = _menu.y + _menu.height + _bgImage.height + 50;

        _header.y = 20;
        _header.setSize(stage.stageWidth, 50);
        _line.x = _header.width/2 - _line.width/2;
        _line.width = 360;

        _menu.x = 40;
        _menu.y = 100;
        _menu.setSize(stage.stageWidth, stage.stageHeight);

        _help.setSize(stage.stageWidth, stage.stageHeight - 50);

        _homeBtn.x = 20;
        _homeBtn.y = _header.height/2 - _homeBtn.height/2 - 5;

        _recipes.y = 100;
        _recipes.setSize(stage.stageWidth, 50);

        _ownRecipes.y = 100;
        _ownRecipes.setSize(stage.stageWidth, 50);

        _add.x = 70;
        _add.y = 100;
        _add.setSize(stage.stageWidth, stage.stageHeight);
    }

    private function pageChangedHandler(event:flash.events.Event):void
    {
        _homeBtn.visible = true;

        _homeBtn.addEventListener( starling.events.Event.TRIGGERED, GoBackHomeHandler );

        _header.title = _appModel.currentPage;

        _container = new Sprite();

        switch(_appModel.currentPage)
        {
            case "recepten":
                _recipes = new Recipes();
                _appModel.addEventListener(AppModel.CURRENT_RECIPE_CHANGED, recipeChangedHandler);
                _container.addChild(_recipes);
                break;

            case "eigen recepten":
                _ownRecipes = new Recipes();
                _appModel.addEventListener(AppModel.CURRENT_RECIPE_CHANGED, recipeChangedHandler);

                _container.addChild(_ownRecipes);
                _appModel.loadOwnRecipes();
                break;

            case "recept toevoegen":
                _add = new Add();
                _container.addChild(_add);
                break;

            case "detail":
                _detail = new Detail();
                _container.addChild(_detail);
                break;
        }


        layout();

        removeChild(_menu);
        //removeChild(_help);
        _help.visible = false;
        _bgImage.visible = false;
        addChild(_container);
    }

    private function GoBackHomeHandler( event:starling.events.Event ):void
    {
        removeChild(_container);
        _header.title = "keuken omvormer";
        _homeBtn.visible = false;

        addChild(_menu);
        //addChild(_help);
        _help.visible = true;
        _bgImage.visible = true;
    }

    private function recipeChangedHandler(event:flash.events.Event):void
    {
        trace("recept = "+_appModel.currentRecipe);
    }
}
}