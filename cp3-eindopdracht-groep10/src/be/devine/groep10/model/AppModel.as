
package be.devine.groep10.model
{
import be.devine.groep10.factory.RecipesVOFactory;
import be.devine.groep10.model.service.OwnRecipeService;
import be.devine.groep10.model.service.RecipeService;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.net.URLLoader;
import flash.net.URLRequest;

import starling.events.Event;

public class AppModel extends EventDispatcher
{
    private static var instance:AppModel;

    public static const PAGE_CHANGED:String = "pageChanged";
    public static const CURRENT_PAGE_CHANGED:String = "currentPageChanged";

    private var _pages:Array;
    private var currentPageChanged:Boolean;
    private var _currentPage:String;

    public static const RECIPE_CHANGED:String = "recipeChanged";
    public static const OWNRECIPE_CHANGED:String = "ownrecipeChanged";
    public static const CURRENT_RECIPE_CHANGED:String = "currentRecipeChanged";

    private var _recipes:Array;
    private var _ownRecipes:Array;
    private var currentRecipeChanged:Boolean;
    private var _currentRecipe:String;

    public function AppModel(e:Enforcer)
    {
        if (e == null)
        {
            throw new Error("AppModel is a singleton, use getInstance() instead");
        }

        _pages = ["recepten", "eigen recepten", "recept toevoegen","conversie toevoegen"];
        _recipes = []
        _ownRecipes = [];
    }
    public static function getInstance():AppModel
    {
        if (instance == null)
        {
            instance = new AppModel(new Enforcer());
        }
        return instance;
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
            dispatchEvent(new flash.events.Event(PAGE_CHANGED));
        }
    }

    public function get currentPage():String
    {
        return _currentPage;
    }

    public function set currentPage(value:String):void
    {
            currentPageChanged = true;
            _currentPage = value;
            dispatchEvent(new flash.events.Event(CURRENT_PAGE_CHANGED));
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
            dispatchEvent(new flash.events.Event(RECIPE_CHANGED));
        }
    }

    public function get ownRecipes():Array
    {
        return _ownRecipes;
    }

    public function set ownRecipes(value:Array):void
    {
        if (value != _ownRecipes)
        {
            _ownRecipes = value;
            dispatchEvent(new flash.events.Event(OWNRECIPE_CHANGED));
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
            dispatchEvent(new flash.events.Event(CURRENT_RECIPE_CHANGED));
        }
    }

    public function load():void
    {
        var recipeService:RecipeService = new RecipeService();
        recipeService.addEventListener(starling.events.Event.COMPLETE, loadRecipesCompleteHandler);
        recipeService.load();
    }

    public function loadRecipesCompleteHandler(event:starling.events.Event):void
    {
        var recipeService:RecipeService = event.target as RecipeService;
        this.recipes = recipeService.recipes;
        this._currentRecipe = recipes[0];
    }

    public function loadOwnRecipes():void
    {
        var recipeService:OwnRecipeService = new OwnRecipeService();
        recipeService.addEventListener(starling.events.Event.COMPLETE, loadOwnRecipesCompleteHandler);
        recipeService.load();
    }

    public function loadOwnRecipesCompleteHandler(event:starling.events.Event):void
    {
        var recipeService:OwnRecipeService = event.target as OwnRecipeService;
        this.ownRecipes = recipeService.ownRecipes;
        this._currentRecipe = recipes[0];
    }
}
}

internal class Enforcer
{};