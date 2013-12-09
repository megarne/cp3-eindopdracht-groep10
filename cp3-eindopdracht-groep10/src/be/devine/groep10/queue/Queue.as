/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 31/10/13
 * Time: 11:07
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.queue {
import be.devine.groep10.queue.tasks.ITask;

import flash.events.Event;

import flash.events.EventDispatcher;
import flash.events.ProgressEvent;

public class Queue extends EventDispatcher
{
    private var _arrWaitingTasks:Array;
    private var _arrBusyTasks:Array;
    private var _arrLoadedTasks:Array;

    public function Queue()
    {
        _arrWaitingTasks = [];
        _arrBusyTasks = [];
        _arrLoadedTasks = [];
    }

    public function add(task:ITask):void
    {
        _arrWaitingTasks.push(task);
    }

    public function start():void
    {
        if(_arrWaitingTasks.length > 0)
        {
            var loadItem:ITask = _arrWaitingTasks.shift();
            loadItem.addEventListener(ProgressEvent.PROGRESS, taskProgressHandler);
            loadItem.addEventListener(Event.COMPLETE, loadedItemCompleteHandler);
            loadItem.start();

            _arrBusyTasks.push(loadItem);
        }
        else
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }

    private function taskProgressHandler(event:ProgressEvent):void
    {
        //trace('[Queue] Task progress: '+event.bytesLoaded + '/' + event.bytesTotal);
    }

    private function loadedItemCompleteHandler(event:Event):void
    {
        var completedTask:ITask = event.currentTarget as ITask;

        var index:uint = _arrBusyTasks.indexOf(_arrLoadedTasks);

        _arrBusyTasks.splice(index,  1);

        _arrLoadedTasks.push(completedTask);
        start();
    }

    public function get arrLoadedTasks():Array
    {
        return _arrLoadedTasks;
    }
}
}
