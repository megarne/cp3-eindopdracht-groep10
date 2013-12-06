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

import com.greensock.easing.Quad;

import feathers.controls.Button;

import feathers.controls.Header;

import feathers.themes.MetalWorksMobileTheme;

import flash.events.Event;
import flash.events.MouseEvent;

import starling.display.Quad;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.TouchEvent;

public class Application extends Sprite
{
    private var _appModel:AppModel;

    private var _header:Header;
    private var _menu:Menu;
    private var _help:Help;

    private var _home:starling.display.Button;

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







        addEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);

        _appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, pageChangedHandler);
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
        _header.x = stage.stageWidth/2 - _header.width/2;
    }

    private function layout():void
    {
        trace("[Starling]", stage.stageWidth, stage.stageHeight);


        _header.x = stage.stageWidth/2 - _header.width/2;

        _menu.y = 100;
        _menu.setSize(stage.stageWidth, 50);

        _help.setSize(stage.stageWidth, stage.stageHeight);
    }

    private function pageChangedHandler(event:flash.events.Event):void
    {
        var _home:Button = new Button();
        _home.label = "HOME";
        addChild(_home);

        _home.addEventListener( starling.events.Event.TRIGGERED, homeHandler );


        trace("huidige pagina = "+_appModel.currentPage);
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


        removeChild(_menu);
        removeChild(_help);
    }



    function homeHandler( event:starling.events.Event ):void
    {
        trace( "terug naar de home aub" );
        trace(_appModel.currentPage);


        switch(_appModel.currentPage)
        {
            case "recepten":
                _recipes = new Recipes();
                removeChild(_recipes);
                _appModel.currentPage= "Keuken omvormer";
                addChild(_menu);
                addChild(_help);
                break;

            case "eigen recepten":
                _recipes = new Recipes();
                removeChild(_recipes);
                removeChild(_home);
                _appModel.currentPage= "Keuken omvormer";
                addChild(_menu);
                addChild(_help);
                break;

            case "recept toevoegen":
                _add = new Add();
                removeChild(_add);
                removeChild(_home);
                _appModel.currentPage= "Keuken omvormer";
                addChild(_menu);
                addChild(_help);
                break;


            case "Keuken omvormer":
                this.removeChild(_home);
                break;

        }

       /* if(_header.title == "Keuken omvormer"){

            removeChild(home);
        }*/
    }
}
}
