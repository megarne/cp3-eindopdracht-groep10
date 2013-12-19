/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 5/12/13
 * Time: 10:57
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.view
{
import be.devine.groep10.model.AppModel;
import be.devine.groep10.view.ui.Help;

import feathers.controls.Button;

import feathers.controls.List;
import feathers.data.ListCollection;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;

import starling.display.Sprite;
import starling.events.Event;

public class Menu extends Sprite
{
    private var _appModel:AppModel;

    private var _menuList:List;

    private var _explicitWidth:Number = 0;
    private var _explicitHeight:Number = 0;

    public function Menu()
    {
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);

        _appModel = AppModel.getInstance();

        _menuList = new List();
        _menuList.itemRendererProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
        _menuList.addEventListener(starling.events.Event.CHANGE, listChangeHandler);
        _menuList.itemRendererProperties.labelField = "title";
        addChild(_menuList);

        display();
    }

    private function addedToStageHandler(event:starling.events.Event):void
    {
        _menuList.x = stage.stageWidth/2 - _menuList.width/2;
    }

    private function listChangeHandler(event:starling.events.Event):void
    {
        if(_menuList.selectedItem)
        {
            _appModel.currentPage = _menuList.selectedItem as String;
        }
    }

    private function display():void
    {
        _menuList.dataProvider = new ListCollection(_appModel.pages);
        _menuList.selectedItem = _appModel.currentPage;

        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
        layout.gap = 30;
        layout.paddingTop = layout.paddingRight = layout.paddingBottom = layout.paddingLeft = 10;
        _menuList.layout = layout;
    }

    public function setSize(w:Number, h:Number):void
    {
        _explicitWidth = w;
        _explicitHeight = h;

        _menuList.setSize(_explicitWidth, _explicitHeight);
    }
}
}
