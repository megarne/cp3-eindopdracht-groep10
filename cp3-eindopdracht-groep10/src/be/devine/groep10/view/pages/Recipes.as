package be.devine.groep10.view.pages
{
import be.devine.groep10.model.AppModel;

import feathers.controls.Button;

import feathers.controls.List;
import feathers.controls.ScrollContainer;
import feathers.data.ListCollection;
import feathers.layout.VerticalLayout;

import starling.display.Sprite;
import starling.events.Event;

public class Recipes extends Sprite
{
    private var _appModel:AppModel;

    private var _recipeList:List;
    private var _listCollection:ListCollection;

    private var _ownRecipesList:List;
    private var _ownListCollection:ListCollection;

    private var _explicitWidth:Number = 0;
    private var _explicitHeight:Number = 0;

    private var _scrollContainer:ScrollContainer;

    public function Recipes()
    {
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);

       //_scrollContainer = new ScrollContainer();
        //addChild( _scrollContainer );

        _appModel = AppModel.getInstance();

        _recipeList = new List();
        _ownRecipesList = new List();

        if(_appModel.currentPage == "recepten")
        {
            _recipeList.itemRendererProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
            _recipeList.addEventListener(starling.events.Event.CHANGE, listChangeHandler);
            _recipeList.itemRendererProperties.labelField = "title";
            //_scrollContainer.addChild(_recipeList);
            addChild(_recipeList);
        }

        if(_appModel.currentPage == "eigen recepten")
        {
            _ownRecipesList.itemRendererProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
            _ownRecipesList.addEventListener(starling.events.Event.CHANGE, listChangeHandler);
            _ownRecipesList.itemRendererProperties.labelField = "title";
            addChild(_ownRecipesList);
            //_scrollContainer.addChild(_ownRecipesList);
        }

        display();
    }

    private function addedToStageHandler(event:starling.events.Event):void
    {
       // _scrollContainer.width = stage.stageWidth
       // _scrollContainer.height = stage.stageHeight - 120;

        _recipeList.x = stage.stageWidth/2 - _recipeList.width/2;
        _ownRecipesList.x = stage.stageWidth/2 - _ownRecipesList.width/2;
    }


    private function listChangeHandler(event:starling.events.Event):void
    {
        if(_appModel.currentPage == "recepten")
        {
            if(_recipeList.selectedItem)
            {
                _appModel.currentRecipe = _recipeList.selectedItem as String;
            }
        }

        if(_appModel.currentPage == "eigen recepten")
        {
            if(_ownRecipesList.selectedItem)
            {
                trace("currentIngredient");
                //_appModel.currentRecipe = _recipeList.selectedItem as String;
            }
        }
    }

    private function display():void
    {
        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
        layout.gap = 30;
        layout.paddingTop = layout.paddingRight = layout.paddingBottom = layout.paddingLeft = 10;

        if(_appModel.currentPage == "recepten")
        {
            _listCollection = new ListCollection();

            for each(var recipe:Object in _appModel.recipes)
            {
                _listCollection.push(recipe.name);
            }
            _recipeList.dataProvider = _listCollection;
            _recipeList.selectedItem = _appModel.currentRecipe;

            _recipeList.layout = layout;
        }

        if(_appModel.currentPage == "eigen recepten")
        {
            _ownListCollection = new ListCollection();

            for each(var recipe:Object in _appModel.ownRecipes)
            {
                _ownListCollection.push(recipe.name);
            }
            _ownRecipesList.dataProvider = _ownListCollection;
            //_ownRecipesList.selectedItem = _appModel.currentRecipe;

            _ownRecipesList.layout = layout;
        }
    }

    public function setSize(w:Number, h:Number):void
    {
        _explicitWidth = w;
        _explicitHeight = h;

        /*_scrollContainer.width = _explicitWidth;
        _scrollContainer.height = _explicitHeight - 120;*/

        _recipeList.setSize(_explicitWidth - 120, _explicitHeight - 120);
        _ownRecipesList.setSize(_explicitWidth - 120, _explicitHeight - 120);
    }
}
}