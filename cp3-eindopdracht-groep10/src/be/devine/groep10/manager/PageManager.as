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

public class PageManager
{
    private static var instance:PageManager;

    public static function getInstance():PageManager
    {
        if(instance == null)
        {
            instance = new PageManager(new Enforcer());
        }
        return instance;
    }

    private var _appModel:AppModel;
    private var currentPageChanged:Boolean;

    public function PageManager(e:Enforcer)
    {
        if(e == null)
        {
            throw new Error("PageManager is a Singleton");
        }

        _appModel = AppModel.getInstance();
        _appModel.addEventListener(AppModel.CURRENT_PAGE_CHANGED, currentPageChangedHandler);
    }

    private function currentPageChangedHandler(event:Event):void
    {
        currentPageChanged = true;
        commitProperties();
    }

    private function commitProperties():void
    {
        if(currentPageChanged)
        {
            currentPageChanged = false;
            trace("current page ="+_appModel.currentPage);

            //hier moet de view komen van de pagina's ipv ?
        }
    }
}
}
internal class Enforcer{};