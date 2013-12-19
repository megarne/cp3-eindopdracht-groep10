package be.devine.groep10.view.pages
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

    private var _ownRecipeList:List;
    private var _ownRecipeListCollection:ListCollection;

    private var _explicitWidth:Number = 0;
    private var _explicitHeight:Number = 0;

    public function Recipes()
    {
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);

        _appModel = AppModel.getInstance();

        _recipeList = new List();
        _ownRecipeList = new List();

        //if(_appModel.currentPage == "recepten")
        //{
            _recipeList.itemRendererProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
            _recipeList.addEventListener(starling.events.Event.CHANGE, listChangeHandler);
            _recipeList.itemRendererProperties.labelField = "title";
            addChild(_recipeList);

            _listCollection = new ListCollection();

            for each(var recipe:Object in _appModel.recipes)
            {
                _listCollection.push(recipe.name);
            }

            _recipeList.dataProvider = _listCollection;
            display();
        /*}
        else
        {
            _ownRecipeList.itemRendererProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
            _ownRecipeList.addEventListener(starling.events.Event.CHANGE, listChangeHandler);
            _ownRecipeList.itemRendererProperties.labelField = "title";
            _ownRecipeList.height = 800;
            addChild(_ownRecipeList);

            _ownRecipeListCollection = new ListCollection();

            for each(var recipe:Object in _appModel.ownRecipes)
            {
                _ownRecipeListCollection.push(recipe.name);
            }

            _ownRecipeList.dataProvider = _ownRecipeListCollection;
            display();
        }*/

    }

    private function addedToStageHandler(event:starling.events.Event):void
    {
        _recipeList.x = stage.stageWidth/2 - _recipeList.width/2;
    }


    private function listChangeHandler(event:starling.events.Event):void
    {
        if(_recipeList.selectedItem)
        {
            //_appModel.currentRecipe = _recipeList.selectedItem as RecipesVO;
        }
    }

    private function display():void
    {
        if(_appModel.currentPage == "recepten")
        {
            _recipeList.selectedItem = _appModel.currentRecipe;
        }
        else
        {
           // _ownRecipeList.selectedItem = _appModel.ownCurrentRecipe;
        }

        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
        layout.gap = 30;
        layout.paddingTop = layout.paddingRight = layout.paddingBottom = layout.paddingLeft = 10;

        _recipeList.layout = layout;
        _ownRecipeList.layout = layout;
    }

    public function setSize(w:Number, h:Number):void
    {
        _explicitWidth = w;
        _explicitHeight = h;

        //_recipeList.x = Math.round((_explicitWidth - _recipeList.width) * .5);

        _recipeList.setSize(_explicitWidth, _explicitHeight);
        _ownRecipeList.setSize(_explicitWidth, _explicitHeight);
    }
}
}