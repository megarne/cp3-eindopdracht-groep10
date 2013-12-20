/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 6/12/13
 * Time: 10:44
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.view.ui {
import feathers.controls.PickerList;
import feathers.controls.TextInput;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;

import flash.filesystem.File;
import flash.filesystem.FileMode;

import flash.filesystem.FileStream;

import flash.text.SoftKeyboardType;

import starling.display.Sprite;
import starling.events.Event;

public class AddInputFields extends Sprite {
    private var _inputContainer:Sprite;

    private var _inputIngredient:TextInput;
    private var _inputAmount:TextInput;
    private var _unit:PickerList;

    private var _explicitWidth:Number = 0;
    private var _explicitHeight:Number = 0;

    public function AddInputFields() {
        _inputContainer = new starling.display.Sprite();
        addChild(_inputContainer);

        _inputIngredient = new TextInput();
        _inputIngredient.prompt = "naam ingredient";
        //_inputIngredient.width = 320;
        _inputContainer.addChild(_inputIngredient);

        _inputAmount = new TextInput();
        _inputAmount.prompt = "hoeveelheid";
        _inputAmount.restrict = "0-9";
        _inputAmount.y = _inputIngredient.y + (_inputAmount.prompt.length) + 50;
        _inputContainer.addChild(_inputAmount);

        _unit = new PickerList();
        _inputContainer.addChild(_unit);

        var conversionFile:File = File.applicationStorageDirectory.resolvePath("conversions.json");

        if (!conversionFile.exists) {

            //file bestaat niet
            //basis unitlist gebruiken
            var unitList:ListCollection = new ListCollection(
                    [
                        //eenheden uit json halen! want er komen eenheden bij
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
            _unit.dataProvider = unitList;
            _unit.listProperties.@itemRendererProperties.labelField = "text";
            _unit.labelField = "text";
            _unit.prompt = "Kies eenheid";
            _unit.selectedIndex = -1;
            _unit.y = _inputAmount.y;

            //



        } else {

            var readStr:String = readStream(conversionFile);
            var parsedJSON:Array = JSON.parse(readStr) as Array;
            trace("[ADDINPUTFIELDS]" + parsedJSON);
            var conversions:Array = [];


                unitList = new ListCollection([
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

                for each(var conversion:Object in parsedJSON) {
                {
                    unitList.push(conversion.conversie.deel1.eenheid1);
                    unitList.push(conversion.conversie.deel2.eenheid2);
                }

                //recipes.push(RecipesVOFactory.createRecipesVOFromObject(recipe));
            }


            _unit.dataProvider = unitList;
            _unit.listProperties.@itemRendererProperties.labelField = "text";
            _unit.labelField = "text";
            _unit.prompt = "Kies eenheid";
            _unit.selectedIndex = -1;
            _unit.y = _inputAmount.y;

        }

    }

    private function readStream(file:File):String {
        var readStream:FileStream = new FileStream();
        readStream.open(file, FileMode.READ);
        var string:String = readStream.readUTFBytes(readStream.bytesAvailable);
        readStream.close();
        return string;
    }


    public function setSize(w:Number, h:Number):void {
        _explicitWidth = w;
        _explicitHeight = h;

        _inputIngredient.width = _explicitWidth - 140;
        _inputAmount.width = _explicitWidth / 2 - 80;
        _unit.width = _inputAmount.width;
        _unit.x = _inputAmount.x + _inputAmount.width + 20;
    }

    public function get inputIngredient():TextInput {
        return _inputIngredient;
    }

    public function set inputIngredient(value:TextInput):void {
        _inputIngredient = value;
    }

    public function get inputAmount():TextInput {
        return _inputAmount;
    }

    public function set inputAmount(value:TextInput):void {
        _inputAmount = value;
    }

    public function get unit():PickerList {
        return _unit;
    }

    public function set unit(value:PickerList):void {
        _unit = value;
    }
}
}
