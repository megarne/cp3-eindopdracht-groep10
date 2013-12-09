/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 31/10/13
 * Time: 11:08
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.queue.tasks {
import flash.events.IEventDispatcher;

    public interface ITask extends IEventDispatcher
    {
        function start():void;
        function get result():*;
    }
}
