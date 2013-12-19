/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 1/12/13
 * Time: 19:49
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10
{
import be.devine.groep10.manager.PageManager;
import be.devine.groep10.manager.RecipeManager;
import be.devine.groep10.model.AppModel;
import be.devine.groep10.view.Menu;
import be.devine.groep10.view.pages.Add;
import be.devine.groep10.view.pages.Detail;
import be.devine.groep10.view.pages.Recipes;
import be.devine.groep10.view.ui.Help;
import feathers.controls.Button;

import feathers.controls.Header;
import feathers.themes.ConverterTheme;

import flash.events.Event;
import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;

public class Application extends Sprite
{
    [Embed(source = "/../assets/custom/bg.png")]
    private static const BackgroundClass:Class;
    private var _bg:Image;

    [Embed(source = "/../assets/custom/bgImage.png")]
    private static const ImageBgClass:Class;
    private var _bgImage:Image;

    private var _appModel:AppModel;
    private var _pageManager:PageManager;
    private var _recipeManager:RecipeManager;

    private var _header:Header;
    [Embed(source = "/../assets/custom/line.png")]
    private static const LineTexture:Class;
    private var _line:Image;

    private var _menu:Menu;
    private var _help:Help;

    private var _homeBtn:Button;

    private var _recipes:Recipes;
    private var _ownRecipes:Recipes;
    private var _add:Add;
    private var _detail:Detail;

    private var _container:Sprite;

    public function Application()
    {
        new ConverterTheme();

        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);

        _appModel = AppModel.getInstance();
        _pageManager = PageManager.getInstance();
        _recipeManager = RecipeManager.getInstance();
        _appModel.load();
        _appModel.loadOwnRecipes();

        _bg = Image.fromBitmap(new BackgroundClass());
        addChild(_bg);

        _bgImage = Image.fromBitmap(new ImageBgClass());
        addChild(_bgImage);

        _header = new Header();
        _header.title = "Keuken omvormer";
        addChild( _header );

        _line = Image.fromBitmap(new LineTexture());
        _line.width = 360;
        _line.y = 40;
        _header.addChild(_line);

        _menu = new Menu();
        addChild(_menu);

        _help = new Help();
        addChild(_help);

        _recipes = new Recipes();
        _ownRecipes = new Recipes();

        _add = new Add();

        _homeBtn = new Button();
        _homeBtn.nameList.add( "home-button" );
        _homeBtn.width = _homeBtn.height = 60;
        _header.addChild( _homeBtn );

        _homeBtn.visible = false;

        _appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, pageChangedHandler);
    }

    private function addedHandler(event:starling.events.Event):void
    {
        removeEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
        stage.addEventListener(starling.events.Event.RESIZE, resizeHandler);
        layout();

        _bgImage.y = _menu.y + _menu.height - _bgImage.height - 50;
        _line.x = _header.width/2 - _line.width/2;
    }

    private function resizeHandler(event:starling.events.Event):void
    {
        layout();
    }

    private function layout():void
    {
        _bg.width = stage.stageWidth;
        _bg.height = stage.stageHeight;

        _bgImage.x = _bg.width/2 - _bgImage.width/2;
        _bgImage.y = _menu.y + _menu.height + _bgImage.height + 50;

        _header.y = 20;
        _header.setSize(stage.stageWidth, 50);
        _line.x = _header.width/2 - _line.width/2;

        _menu.y = 100;
        _menu.setSize(stage.stageWidth - 80, stage.stageHeight - 200);

        _help.setSize(stage.stageWidth, stage.stageHeight - 50);

        _homeBtn.x = 20;
        _homeBtn.y = _header.height/2 - _homeBtn.height/2 - 1;

        _recipes.y = _ownRecipes.y =  100;
        _recipes.setSize(stage.stageWidth, stage.stageHeight);
        _ownRecipes.setSize(stage.stageWidth, stage.stageHeight);

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
                    _add.addEventListener(starling.events.Event.COMPLETE, completeHandler);
                break;

            case "detail":
                _detail = new Detail();
                _container.addChild(_detail);
                break;
        }

        layout();

        removeChild(_menu);
        _help.visible = false;
        _bgImage.visible = false;
        addChild(_container);
    }

    private function GoBackHomeHandler( event:starling.events.Event ):void
    {
        removeChild(_container);
        _header.title = "keuken omvormer";
        _homeBtn.visible = false;

        _menu.deselectMenuItems();
        addChild(_menu);

        _help.visible = true;
        _bgImage.visible = true;
    }

    private function recipeChangedHandler(event:flash.events.Event):void
    {
        //trace("recept = "+_appModel.currentRecipe);
    }

    private function completeHandler(event:starling.events.Event):void
    {
        _container.removeChild(_add);
        _appModel.currentPage = "eigen recepten";
    }
}
}