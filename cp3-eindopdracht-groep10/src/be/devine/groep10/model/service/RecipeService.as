/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 19/12/13
 * Time: 14:51
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.model.service
{
import be.devine.groep10.factory.RecipesVOFactory;

import flash.events.Event;

import flash.net.URLLoader;
import flash.net.URLRequest;

import starling.events.EventDispatcher;

public class RecipeService  extends EventDispatcher
{
    public var recipes:Array;

    public function RecipeService()
    {
        recipes = [];
    }

    public function load():void
    {
        var urlRequest:URLRequest  = new URLRequest("assets/json/recipes.json");
        var urlLoader:URLLoader = new URLLoader();
        urlLoader.addEventListener(Event.COMPLETE, completeHandler);

        try
        {
            urlLoader.load(urlRequest);
        }
        catch (error:Error)
        {
            trace("Cannot load : " + error.message);
        }
    }

    private function completeHandler(event:Event):void
    {
        var loader:URLLoader = URLLoader(event.target);

        var data:Object = JSON.parse(loader.data);

        for each(var recipe:Object in data)
        {
            recipes.push(RecipesVOFactory.createRecipesVOFromObject(recipe));
        }

        this.recipes = recipes;
        dispatchEvent(new starling.events.Event(starling.events.Event.COMPLETE));
    }
}
}
