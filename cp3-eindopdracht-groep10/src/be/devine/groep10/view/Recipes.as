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
    private var _ownRecipeList:List;
    private var _listCollection:ListCollection;
    private var _ownListCollection:ListCollection;

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

        //NA DIT TOEGEVOEGD TE HEBBEN WERKT DE SCROLL NIET MEER
        _ownRecipeList = new List();
        _ownRecipeList.width = 360;
        _ownRecipeList.height = 650;
        _ownRecipeList.itemRendererProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
        _ownRecipeList.addEventListener(starling.events.Event.CHANGE, listChangeHandler);
        _ownRecipeList.itemRendererProperties.labelField = "title";
        addChild(_ownRecipeList);

        _listCollection = new ListCollection();
        _ownListCollection = new ListCollection();


        //als je scrolt over de recepten krijg je een fout over "renderer map contains bad data"
        //om deze op te roepen moet je      _listCollection.push(recipe.name); uit commentaar halen en de andere er in zitten
        //ROCKET SCIENCE
        for each(var recipe in _appModel.recipes)
        {
            // trace("[RECIPE] "+recipe.name);


            _listCollection.push(recipe.name);
            //  _listCollection.push(recipe.name);
        }

        _recipeList.dataProvider = _listCollection;
        // trace("[RECIPE] "  + _appModel.ownRecipes);

        //
        if(_appModel.ownRecipes != null)
        {
            for each(var ownRecipe in _appModel.ownRecipes){
                //   trace("[RECIPES] [RECIPES] [ownRecipes]" + ownRecipe.name);

                _ownListCollection.push(ownRecipe);
            }
        }else{
            //  trace("GEEN EIGEN RECEPTEN");
        }
        //IN COMMENTAAR WANT MOMENTEEL IS OWNRECIPE NOG NULL (ER IS NOG GEEN EIGEN RECEPT TOEGEVOEGD)
        // _ownRecipeList.dataProvider = _listCollection;



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
        //sorry voor het onbegrip maar waarom is selectedItem een currentPage?
        _recipeList.selectedItem = _appModel.currentPage;
        // _ownRecipesList.selectedItem = _appModel.currentPage;

        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
        layout.gap = 30;
        layout.paddingTop = layout.paddingRight = layout.paddingBottom = layout.paddingLeft = 10;
        _recipeList.layout = layout;

        //_ownRecipeList.layout = layout;
    }

    public function setSize(w:Number, h:Number):void
    {
        _explicitWidth = w;
        _explicitHeight = h;

        _recipeList.x = Math.round((_explicitWidth - _recipeList.width) * .5);
    }
}
}