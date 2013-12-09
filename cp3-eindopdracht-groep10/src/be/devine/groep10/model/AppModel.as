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
import flash.net.URLLoader;
import flash.net.URLRequest;

public class AppModel extends EventDispatcher
{
    private static var instance:AppModel;

    private var _pages:Array;

    public static const PAGE_CHANGED:String = "pageChanged";
    public static const CURRENT_PAGE_CHANGED:String = "currentPageChanged";

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
       /*var loader:URLLoader = URLLoader(event.target);
        var data:Object = JSON.parse(loader.data);
        trace('[app=model]?');



        var recipes:Array = [];
        for each(var recipe:Object in data)
        {
            var recipeVO:RecipesVO = new RecipesVO();
            recipeVO.name = recipe.name;
            _arrRecipes.push(recipeVO);

            trace(_arrRecipes);
            trace('[app=model]?');
            trace(data.toString());
            trace(recipe.name);
        }
        this._arrRecipes = recipes;   */

        var raw:String = String(event.target.data);
        var person:Array = JSON.parse(raw) as Array;

        trace('EMPLOYEES --------------------------------------');

        for (var i:int = 0; i < person.length; i++)
        {
            trace('Name: ' + person[i].name);
            trace('ingredients: ' + person[i].ingredients);
            trace('preparation: ' + person[i].preparation);
            trace('');
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
}
}

internal class Enforcer
{};