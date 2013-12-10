/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 30/11/13
 * Time: 13:48
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.model
{
import be.devine.groep10.vo.RecipesVO;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.html.__HTMLScriptArray;
import flash.net.URLLoader;
import flash.net.URLRequest;

import starling.display.Quad;

public class AppModel extends EventDispatcher
{
    private static var instance:AppModel;

    private var _pages:Array;


    public static const PAGE_CHANGED:String = "pageChanged";
    public static const CURRENT_PAGE_CHANGED:String = "currentPageChanged";
    public static const LIST_RECEPES:String = "listrecepes";

    private var _currentPage:String;
    private var currentPageChanged:Boolean;

    private var _arrRecipes:Array;



    public function AppModel(e:Enforcer)
    {
        if (e == null)
        {
            throw new Error("AppModel is a singleton, use getInstance() instead");
        }

        _pages = ["recepten", "eigen recepten", "recept toevoegen"];
        _arrRecipes = [];
    }
    public static function getInstance():AppModel
    {
        if (instance == null)
        {
            instance = new AppModel(new Enforcer());
        }
        return instance;
    }

    public function load():void
    {
        var urlLoader:URLLoader = new URLLoader();
        urlLoader.addEventListener(Event.COMPLETE, jsonCompleteHandler);
        urlLoader.load(new URLRequest("assets/json/recipes.json"));
    }

    private function jsonCompleteHandler(event:Event):void
    {


        var raw:String = String(event.target.data);
        var recept:Array = JSON.parse(raw) as Array;

        for (var i:int = 0; i < recept.length; i++)
        {
            trace('Name: ' + recept[i].name);

            _arrRecipes.push(recept[i].name);
            trace(_arrRecipes);


        }
    }

    public function get currentPage():String
    {
        return _currentPage;
    }

    public function set currentPage(value:String):void
    {
        if (_currentPage != value)
        {
            currentPageChanged = true;
            _currentPage = value;
            dispatchEvent(new Event(CURRENT_PAGE_CHANGED));
        }
    }

    public function get pages():Array
    {
        return _pages;
    }

    public function set pages(value:Array):void
    {
        if (value != _pages)
        {
            _pages = value;
            dispatchEvent(new Event(PAGE_CHANGED));
        }
    }

    public function get arrRecipes():Array
    {
        return _arrRecipes;
    }

    public function set arrRecipes(value:Array):void
    {
        _arrRecipes = value;
    }
}
}

internal class Enforcer
{};