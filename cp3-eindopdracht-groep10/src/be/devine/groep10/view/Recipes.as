/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 3/12/13
 * Time: 13:50
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.view
{
import be.devine.groep10.model.AppModel;
import be.devine.groep10.vo.RecipesVO;

import feathers.controls.Button;

import feathers.controls.List;
import feathers.data.ListCollection;
import feathers.layout.VerticalLayout;

import starling.display.Sprite;
import starling.events.Event;

public class Recipes extends Sprite
{
    private var _appModel:AppModel;

    private var _recipeList:List;
    private var _listCollection:ListCollection;

    private var _explicitWidth:Number = 0;
    private var _explicitHeight:Number = 0;

    public function Recipes()
    {
        _appModel = AppModel.getInstance();

        _recipeList = new List();
        _recipeList.width = 360;
        _recipeList.height = 650;
        _recipeList.itemRendererProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
        _recipeList.addEventListener(starling.events.Event.CHANGE, listChangeHandler);
        _recipeList.itemRendererProperties.labelField = "title";
        addChild(_recipeList);

        _listCollection = new ListCollection();


        //als je scrolt over de recepten krijg je een fout over "renderer map contains bad data"
        //om deze op te roepen moet je      _listCollection.push(recipe.name); uit commentaar halen en de andere er in zitten
        //ROCKET SCIENCE
        for each(var recipe in _appModel.recipes)
        {
           trace(recipe.name);


            _listCollection.push(recipe);
            //  _listCollection.push(recipe.name);
        }

        _recipeList.dataProvider = _listCollection;

        display();
    }

    private function listChangeHandler(event:starling.events.Event):void
    {
        if(_recipeList.selectedItem)
        {
            _appModel.currentRecipe = _recipeList.selectedItem as RecipesVO;
        }
    }

    private function display():void
    {
        //WASDADIER?
        _recipeList.selectedItem = _appModel.currentPage;

        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
        layout.gap = 30;
        layout.paddingTop = layout.paddingRight = layout.paddingBottom = layout.paddingLeft = 10;
        _recipeList.layout = layout;
    }

    public function setSize(w:Number, h:Number):void
    {
        _explicitWidth = w;
        _explicitHeight = h;

        _recipeList.x = Math.round((_explicitWidth - _recipeList.width) * .5);
    }
}
}