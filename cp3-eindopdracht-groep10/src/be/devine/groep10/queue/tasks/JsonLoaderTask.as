/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 31/10/13
 * Time: 11:07
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.queue.tasks
{
import be.devine.groep10.model.AppModel;

import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.ProgressEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class JsonLoaderTask extends EventDispatcher implements ITask
{
    private var _url:String
    private var _result:*;

    private var _appModel:AppModel;

    public function JsonLoaderTask(url:String, appmodel:AppModel)
    {
        this._url = url;
        this._appModel = appmodel;
    }

    public function start():void
    {

        var urlLoader:URLLoader = new URLLoader();
        urlLoader.addEventListener(Event.COMPLETE, completeHandler);
        urlLoader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
        urlLoader.load(new URLRequest(_url));
    }

    private function completeHandler(event:Event):void
    {
        var loader:URLLoader = URLLoader(event.target);
        //trace("completeHandler: " + loader.data);
        _result = loader.data;

        var data:Object = JSON.parse(loader.data);
        //trace(data);

        for each(var recipe:Object in data)
        {
            var recipeData:String = recipe.result;

            /*for each(var recipeTitle:Object in recipe)
            {
                trace(recipeTitle.id);
            }*/
           // this._appModel.arrRecipes.push(recipe);
        }
        //trace("The answer is " + data.id+" ; "+data.first_var+" ; "+data.second_var);

        dispatchEvent(new Event(Event.COMPLETE));
    }

    private function progressHandler(event:ProgressEvent):void
    {
        dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, event.bytesLoaded, event.bytesTotal));
    }


    public function get result():*
    {
        return _result;
    }

    public function get url():String
    {
        return _url;
    }

    public function set url(value:String):void
    {
        _url = value;
    }
}
}
