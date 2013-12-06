/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 3/12/13
 * Time: 13:50
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.view
{
import be.devine.groep10.view.utils.Converter;

import feathers.controls.PickerList;

import feathers.controls.TextInput;
import feathers.data.ListCollection;

import feathers.text.StageTextField;

import flash.display.Bitmap;
import flash.events.Event;

import starling.display.Button;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;

public class Recipes extends Sprite
    {

        var graden:Number;
        var txtField:TextInput;

        var resultField:TextField;
        var converted:String;
        public function Recipes()
        {
            addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);

        }


    private function addedToStageHandler(event:starling.events.Event):void
    {


        txtField=new TextInput();
        txtField.text="28";
        txtField.restrict = "0-9";
        txtField.addEventListener(starling.events.Event.CHANGE, inputChangeHandler);
        addChild(txtField);


        resultField=new TextField(100,200,"resultaat", "Futura",16, 0xFFFFFF,false);
        addChild(resultField);
        resultField.x = 10;
        resultField.y = 100;


        var list:PickerList = new PickerList();
        addChild( list );

        trace(Converter)
        var functionList:ListCollection = new ListCollection(
                [
                    { text: "functie1" },
                    { text: "functie2" },
                    { text: "functie3"},
                    { text: "functie4"}
                ]);
        list.dataProvider = functionList;
        list.listProperties.@itemRendererProperties.labelField = "text";
        list.labelField = "text";

        list.prompt = "Select an Item";
        list.selectedIndex = -1;

    }

    private function inputChangeHandler():void {

       // trace(txtField.text);
        graden = Number(txtField.text);
        //trace(graden);
        Converter.celsiusToFahrenheit(graden);
       // trace(  graden + " graden in Fahrenheit= " + Converter.celsiusToFahrenheit(graden))

        converted =  String(Converter.celsiusToFahrenheit(graden));

        resultField.text=converted;

        //trace(Converter.celsiusToFahrenheit(graden));
    }
}
}
