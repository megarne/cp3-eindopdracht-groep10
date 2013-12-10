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

    private var _recipes:Array;

    public static const RECIPE_CHANGED:String = "recipeChanged";
    public static const CURRENT_RECIPE_CHANGED:String = "currentRecipeChanged";

    private var _currentRecipe:String;
    private var currentRecipeChanged:Boolean;

    public function AppModel(e:Enforcer)
    {
        if (e == null)
        {
            throw new Error("AppModel is a singleton, use getInstance() instead");
        }

        _pages = ["recepten", "eigen recepten", "recept toevoegen","detail"];
        _recipes = [];
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
            var recipe:String = recept[i].name;
            _recipes.push(recipe);
        }

        trace(_recipes);
        //_recipes.push("spaghetti", "sushi", "patatten", "griekse salade", "yoghurt", "hutsepot");
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

    public function get recipes():Array
    {
        return _recipes;
    }

    public function set recipes(value:Array):void
    {
        if (value != _recipes)
        {
            _recipes = value;
            dispatchEvent(new Event(RECIPE_CHANGED));
        }
    }

    public function get currentRecipe():String
    {
        return _currentRecipe;
    }

    public function set currentRecipe(value:String):void
    {
        if (_currentRecipe != value)
        {
            currentRecipeChanged = true;
            _currentRecipe = value;
            dispatchEvent(new Event(CURRENT_RECIPE_CHANGED));
        }
    }
}
}

internal class Enforcer
{};