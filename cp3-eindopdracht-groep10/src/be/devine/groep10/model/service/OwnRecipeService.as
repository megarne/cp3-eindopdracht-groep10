/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 19/12/13
 * Time: 14:35
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.model.service
{
import be.devine.groep10.factory.RecipesVOFactory;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import starling.events.Event;

import starling.events.EventDispatcher;

public class OwnRecipeService extends EventDispatcher
{
    public var ownRecipes:Array;

    public function OwnRecipeService()
    {}

    public function load():void
    {
        var ownRecipesFile:File = File.applicationStorageDirectory.resolvePath("ownRecipes.json");
        if (ownRecipesFile.exists)
        {
            var readStream:FileStream = new FileStream();
            readStream.open(ownRecipesFile, FileMode.READ);
            var readString:String = readStream.readUTFBytes(readStream.bytesAvailable);
            var parsedJSON:Array = JSON.parse( readString ) as Array;
            readStream.close();

            var ownRecipes:Array = [];
            for each(var ownRecipe:Object in parsedJSON)
            {
                trace("[OWN RECIPE OBJECT]:" + ownRecipe);
                ownRecipes.push(RecipesVOFactory.createRecipesVOFromObject(ownRecipe));
            }
            this.ownRecipes = ownRecipes;
            dispatchEvent(new starling.events.Event(starling.events.Event.COMPLETE));
        }
    }

}
}
