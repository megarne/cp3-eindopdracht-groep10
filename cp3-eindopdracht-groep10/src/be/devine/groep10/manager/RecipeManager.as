/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 17/12/13
 * Time: 22:19
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.manager
{
import be.devine.groep10.model.AppModel;

import flash.events.Event;

public class RecipeManager
{
    private static var instance:RecipeManager;

    public static function getInstance():RecipeManager
    {
        if(instance == null)
        {
            instance = new RecipeManager(new Enforcer());
        }
        return instance;
    }

    private var _appModel:AppModel;
    private var currentRecipeChanged:Boolean;

    public function RecipeManager(e:Enforcer)
    {
        if(e == null)
        {
            throw new Error("PageManager is a Singleton");
        }

        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.CURRENT_RECIPE_CHANGED, currentRecipeChangedHandler);
    }

    private function currentRecipeChangedHandler(event:Event):void
    {
        currentRecipeChanged = true;
        commitProperties();
    }

    private function commitProperties():void
    {
        if(currentRecipeChanged)
        {
            currentRecipeChanged = false;
            trace("current recipe ="+_appModel.currentRecipe);

            //hier moet de view komen van de recepten?
        }
    }
}
}
internal class Enforcer{};