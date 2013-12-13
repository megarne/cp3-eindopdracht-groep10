
package be.devine.groep10.model
{
import be.devine.groep10.factory.RecipesVOFactory;
import be.devine.groep10.vo.RecipesVO;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
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
    private var _ownRecipes:Array;

    public static const RECIPE_CHANGED:String = "recipeChanged";
    public static const CURRENT_RECIPE_CHANGED:String = "currentRecipeChanged";



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
        trace('[APPMODEL] [LOAD]');
        //var recipesFile:File = File.applicationStorageDirectory.resolvePath("testRecipes.json");


        var recipesFile:File = File.documentsDirectory.resolvePath("/Users/laurens/IdeaProjects/cp3-eindopdracht-groep10/cp3-eindopdracht-groep10/src/assets/json/recipes.json");


        var readStream:FileStream = new FileStream();
        readStream.open(recipesFile, FileMode.READ);
        var parsedJSON:Array = JSON.parse(
                readStream.readUTFBytes(readStream.bytesAvailable)
        ) as Array;
        readStream.close();
        //var recipes:Array = [];
        for each(var recipe:Object in parsedJSON) {
            //trace("[APPMODEL]" + parsedJSON);
           // trace("[APPMODEL] [FOREACH] " + recipe.name);
            _recipes.push(RecipesVOFactory.createRecipesVOFromObject(recipe));
        }

    }

    public function loadOwnRecipes():void {


      /// trace("[loadOwnRecipes]");
        //SLECHT GEBRUIK VAN CODE? 2MAAL BIJNA IDENTIEKE CODE IN 2 KLASSES
        var ownRecipesFile:File = File.applicationStorageDirectory.resolvePath("ownRecipes.json");
        if (!ownRecipesFile.exists) {
            trace("[APPMODEL] [LOADOWNRECIPES] FILE BESTAAT NIET//LEEG JSON FILE AANMAKEN");
            var writeStream:FileStream = new FileStream();
            writeStream.open(ownRecipesFile, FileMode.WRITE);
            writeStream.writeUTFBytes(JSON.stringify([



            ]));
            writeStream.close();
        } else {
            trace('ELSE LOAD OWN RECIPES');
            var readStream:FileStream = new FileStream();
            readStream.open(ownRecipesFile, FileMode.READ);
            var parsedJSON:Array = JSON.parse(
                    readStream.readUTFBytes(readStream.bytesAvailable)
            ) as Array;

            //PARSEDJSON
            trace("[APPMODEL]" + parsedJSON[0].name)
            readStream.close();



            for each(var ownRecipe:Object in parsedJSON) {
                trace("[APPMODEL] [LOAD OWN RECIPES]" + ownRecipe.name);

                //null reference
               // _ownRecipes.push(RecipesVOFactory.createRecipesVOFromObject(ownRecipe));
            }
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

    private var _currentRecipe:RecipesVO;
    private var currentRecipeChanged:Boolean;

    public function get currentRecipe():RecipesVO
    {
        return _currentRecipe;
    }

    public function set currentRecipe(value:RecipesVO):void
    {
        if (_currentRecipe != value)
        {
            currentRecipeChanged = true;
            _currentRecipe = value;
            dispatchEvent(new Event(CURRENT_RECIPE_CHANGED));
        }
    }

    public function get ownRecipes():Array {
        return _ownRecipes;
    }

    public function set ownRecipes(value:Array):void {

        if (value != _ownRecipes) {
            _ownRecipes = value;
            dispatchEvent(new Event(RECIPE_CHANGED));
        }
    }
}
}

internal class Enforcer
{};