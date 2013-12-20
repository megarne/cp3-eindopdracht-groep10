package be.devine.groep10.view.pages {
import be.devine.groep10.model.AppModel;
import be.devine.groep10.vo.RecipesVO;

import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.List;
import feathers.controls.PickerList;
import feathers.controls.ScrollContainer;
import feathers.data.ListCollection;
import feathers.layout.VerticalLayout;
<<<<<<< HEAD
<<<<<<< HEAD
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import starling.display.Sprite;
public class Detail extends Sprite
{
=======

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import starling.display.Sprite;

public class Detail extends Sprite {
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
=======

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import starling.display.Sprite;

public class Detail extends Sprite {
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
    private var _appModel:AppModel;
    private var container:Sprite;
    private var _explicitWidth:Number = 480;
    private var _listingredient:ListCollection;
    private var _listvalue:ListCollection;
    private var _listunit:ListCollection;
    private var _scrollContainer:ScrollContainer;

<<<<<<< HEAD
<<<<<<< HEAD
    private var _arrLists:Array;
    public function Detail()
    {
        _arrLists = new Array();

        _scrollContainer = new ScrollContainer();
        _scrollContainer.width = 460;
=======
    public function Detail() {

        _scrollContainer = new ScrollContainer();
        _scrollContainer.width = 460;
=======
    public function Detail() {

        _scrollContainer = new ScrollContainer();
        _scrollContainer.width = 460;
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
        // _scrollContainer.x = Math.round((_explicitWidth - _scrollContainer.width) * .5);
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
        _scrollContainer.height = 700;
        _scrollContainer.y = 100;
        addChild(_scrollContainer);

        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
        layout.gap = 30;
        layout.paddingTop = layout.paddingRight = layout.paddingBottom = layout.paddingLeft = 10;

        var listingredient:List = new List();
        listingredient.layout = layout;
        listingredient.itemRendererProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
        listingredient.itemRendererProperties.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
        listingredient.itemRendererProperties.iconPosition = Button.ICON_POSITION_TOP;
        listingredient.itemRendererProperties.gap = 10;

<<<<<<< HEAD
<<<<<<< HEAD
        listingredient.width = 200;

=======
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
=======
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
        var layin:VerticalLayout = new VerticalLayout();
        layin.gap = 30;
        layin.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
        layin.paddingTop = layin.paddingRight = layin.paddingBottom = layin.paddingLeft = 10;

        var listvalue:List = new List();
        listvalue.layout = layin;
        listvalue.itemRendererProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
        listvalue.itemRendererProperties.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
        listvalue.itemRendererProperties.iconPosition = Button.ICON_POSITION_TOP;
        listvalue.itemRendererProperties.gap = 10;
<<<<<<< HEAD
<<<<<<< HEAD
        //listvalue.x = Math.round((_explicitWidth - listvalue.width) * .5);
        listvalue.x = listingredient.x + listingredient.width;

        listvalue.width = 150;

=======

        listvalue.x = Math.round((_explicitWidth - listvalue.width) * .5);
        //listingredient.y = 100;
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
=======

        listvalue.x = Math.round((_explicitWidth - listvalue.width) * .5);
        //listingredient.y = 100;
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
        _appModel = AppModel.getInstance();

        _listingredient = new ListCollection();
        _listunit = new ListCollection();
        _listvalue = new ListCollection();

<<<<<<< HEAD
<<<<<<< HEAD
        for each(var recipe:Object in _appModel.recipes)
        {
            if (recipe.name == _appModel.currentRecipe)
            {
                trace(recipe.ingredientname);
                for each(var ingredient:Object in recipe.ingredients)
                {
                    _listingredient.push(ingredient.ingredientname);
                    _listunit.push(ingredient.ingredientunit);
                    if (ingredient.ingredientvalue != null)
                    {
                        _listvalue.push(ingredient.ingredientvalue);
=======
        for each(var recipe:Object in _appModel.recipes) {
            if (recipe.name == _appModel.currentRecipe) {
                trace(recipe.ingredientname);
                for each(var ingredient:Object in recipe.ingredients) {
                    _listingredient.push(ingredient.ingredientname);
                    _listunit.push(ingredient.ingredientunit);
                    if (ingredient.ingredientvalue != null) {
                        _listvalue.push(ingredient.ingredientvalue);

>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
=======
        for each(var recipe:Object in _appModel.recipes) {
            if (recipe.name == _appModel.currentRecipe) {
                trace(recipe.ingredientname);
                for each(var ingredient:Object in recipe.ingredients) {
                    _listingredient.push(ingredient.ingredientname);
                    _listunit.push(ingredient.ingredientunit);
                    if (ingredient.ingredientvalue != null) {
                        _listvalue.push(ingredient.ingredientvalue);

>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
                        //list moet de waarden hebben
                        var conversionFile:File = File.applicationStorageDirectory.resolvePath("conversions.json");
                        var readStr:String = readStream(conversionFile);
                        var parsedJSON:Array = JSON.parse(readStr) as Array;
<<<<<<< HEAD
<<<<<<< HEAD
                        var conversions:Array = [];
                        var lists:Array=[];
                        var yPos:uint = 0;
                        for (var i:uint=0; i < parsedJSON.length; i++)
                        {
=======
=======
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94


                        var conversions:Array = [];
                        var lists:Array=[];
                        var yPos:uint = 0;
                        for (var i:uint=0; i < parsedJSON.length; i++) {


<<<<<<< HEAD
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
=======
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
                            var list:PickerList = new PickerList();
                            var listCol:ListCollection = new ListCollection([
                                { text: "kg"},
                                { text: "g"},
                                { text: "el"},
                                { text: "tl"},
                                { text: "l"},
                                { text: "ml"},
                                { text: "cl"},
                                { text: "mg"},
                                { text: "°C"},
                                { text: "°F"},
                                { text: "°K"}
                            ]);
<<<<<<< HEAD
<<<<<<< HEAD
                            for each(var conversion:Object in parsedJSON)
                            {
                                listCol.push(conversion.conversie.deel1.eenheid1);
                                listCol.push(conversion.conversie.deel2.eenheid2);
                            }
=======
=======
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
                            for each(var conversion:Object in parsedJSON) {
                                listCol.push(conversion.conversie.deel1.eenheid1);
                                listCol.push(conversion.conversie.deel2.eenheid2);
                            }

<<<<<<< HEAD
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
=======
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
                            list.dataProvider = listCol;
                            list.listProperties.@itemRendererProperties.labelField = "text";
                            list.labelField = "text";
                            list.prompt = "Kies eenheid";
<<<<<<< HEAD
<<<<<<< HEAD
                            lists.push(list);

                            list.x = listvalue.x + listvalue.width;

                            _arrLists.push(lists);

                            trace(lists.length + "lengthe");
                            /*for each(var listitem in lists)
                            {
                                yPos += 80;
                                trace(yPos);
                                listitem.y = yPos;
                                trace("[Detail]" + listitem.y);
                                _scrollContainer.addChild(listitem);
                            }*/
                        }
=======
=======
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94

                            lists.push(list);



                            for each(var list in lists)
                            {
                                list.y = 100 +yPos;

                                trace("[Detail]" + list.y);
                                yPos += list.height + 80;
                                this.addChild(list);
                            }



                        }


<<<<<<< HEAD
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
=======
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
                    }
                }
            }
        }
        listingredient.dataProvider = _listingredient;
        listingredient.itemRendererProperties.labelField = "text";
<<<<<<< HEAD
<<<<<<< HEAD
=======

>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
=======

>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
        listvalue.dataProvider = _listvalue;
        listvalue.itemRendererProperties.labelField = "text";

        _scrollContainer.addChild(listingredient);
        _scrollContainer.addChild(listvalue);
<<<<<<< HEAD
<<<<<<< HEAD
        //dataprovider mag geen duplicaat values hebben
        trace(listvalue);
    }
    private function readStream(file:File):String
    {
=======
=======
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94


        //dataprovider mag geen duplicaat values hebben
        trace(listvalue);


    }

    private function readStream(file:File):String {
<<<<<<< HEAD
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
=======
>>>>>>> 2c487168b4257a11af337257ba58a873c72a1a94
        var readStream:FileStream = new FileStream();
        readStream.open(file, FileMode.READ);
        var string:String = readStream.readUTFBytes(readStream.bytesAvailable);
        readStream.close();
        return string;
    }
}
}