/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 5/12/13
 * Time: 21:39
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.view.pages
{
import be.devine.groep10.factory.RecipesVOFactory;
import be.devine.groep10.factory.TextFieldFactory;
import be.devine.groep10.model.AppModel;
import be.devine.groep10.view.ui.AddInputFields;

import feathers.controls.Button;
import feathers.controls.ScrollContainer;

import feathers.controls.TextInput;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import starling.display.Image;

import starling.display.Sprite;

import starling.events.Event;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class Add extends Sprite
{
    private var _appModel:AppModel;

    private var _scrollContainer:ScrollContainer;
    private var _inputContainer:Sprite;

    private var _explicitWidth:Number = 0;
    private var _explicitHeight:Number = 0;

    private var _inputName:TextInput;
    private var _inputIngredient:AddInputFields;

    private var _helpText:TextFieldFactory;

    private var _arrIngredients:Array;

    private var _moreBtn:Button;
    private var _readyBtn:Button;

    public var recipes:Array;

    [Embed(source="/../assets/custom/error.png")]
    private static const ErrorClass:Class;
    private var _error1:Image;
    private var _error2:Image;
    private var _error3:Image;
    private var _error4:Image;

    private var _arrErrors:Array;

    private var errors:Boolean;

    public function Add()
    {
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);

        _appModel = AppModel.getInstance();

        _arrIngredients = [];

        _scrollContainer = new ScrollContainer();
        addChild( _scrollContainer );

        _inputContainer = new Sprite();
        _scrollContainer.addChild(_inputContainer);

        _inputName = new TextInput();
        _inputName.prompt = "naam recept";
        _inputContainer.addChild( _inputName );

        _helpText = new TextFieldFactory( 320, 120, "Vul de nodige ingredienten toe voor 1 persoon", "BebasNeue", 18, 0xffffff);
        _helpText.y = 60;
        _inputName.addChild(_helpText);

        _inputIngredient = new AddInputFields();
        _inputIngredient.y = _inputName.y + _inputIngredient.height + 40;
        _inputContainer.addChild(_inputIngredient);
        _arrIngredients.push(_inputIngredient);

        _moreBtn = new Button();
        _moreBtn.label = "+ extra ingredient";
        _moreBtn.y = _inputContainer.height + _moreBtn.height + 80;
        _inputContainer.addChild( _moreBtn );
        _moreBtn.addEventListener( starling.events.Event.TRIGGERED, moreButtonTriggeredHandler );

        _readyBtn = new Button();
        _readyBtn.nameList.add( Button.READY_BUTTON );
        _readyBtn.label = "klaar!";
        _readyBtn.y = _moreBtn.y + _moreBtn.height + _readyBtn.height + 60;
        _inputContainer.addChild( _readyBtn );
        _readyBtn.addEventListener( starling.events.Event.TRIGGERED, readyButtonTriggeredHandler );

        errors = false;
        _error1 = Image.fromBitmap(new ErrorClass());
        _error2 = Image.fromBitmap(new ErrorClass());
        _error3 = Image.fromBitmap(new ErrorClass());
        _error4 = Image.fromBitmap(new ErrorClass());
    }

    private function readyButtonTriggeredHandler(event:starling.events.Event):void
    {
        if(!isError())
        {
            //value doorsturen naar json
            var recipeName:String = _inputName.text;
            var str:String = new String();
            var ingredientFile:File = File.applicationStorageDirectory.resolvePath("ownRecipes.json");

            if(!ingredientFile.exists)
            {
                str = '[{ "name":"'+recipeName+'","ingredients": { ';
            }
            else
            {
                var oldStr:String = readStream(ingredientFile);
                oldStr = oldStr.substring(1,oldStr.length-1);
                oldStr = oldStr.replace(/\\/gi,'');
                str = '[' + oldStr + ',{';
                //str = '[{';
                str = str + '"name":"'+recipeName+'","ingredients": {';
            }

            //String voor filestream.write aanmaken
            var ingNr:int = 1;
            var length:int = _arrIngredients.length;
            for each( var input:AddInputFields in _arrIngredients)
            {
                str = str + '"ingredient'+ ingNr +'": {"ingredientname":"' + input.inputIngredient.text + '", "ingredientvalue":"' + input.inputAmount.text + '", "ingredientunit":"' + input.unit.selectedItem + '"}';
                if(ingNr != length){
                    str = str + ',';
                }
                ingNr++;
            }
            str = str + '} } ]';

            writeStream(ingredientFile,str);

            var readStr:String = readStream(ingredientFile);
            var parsedJSON:Array = JSON.parse(readStr) as Array;
            var recipes:Array = [];
            for each(var recipe:Object in parsedJSON)
            {
                recipes.push(RecipesVOFactory.createRecipesVOFromObject(recipe));
            }
            _appModel.ownRecipes = recipes;
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }

    private function readStream(file:File):String
    {
        var readStream:FileStream = new FileStream();
        readStream.open(file, FileMode.READ);
        var string:String = readStream.readUTFBytes(readStream.bytesAvailable);
        readStream.close();
        return string;
    }

    private function writeStream(file:File,str:String)
    {
        var writeStream:FileStream = new FileStream();
        writeStream.open(file, FileMode.WRITE);
        writeStream.writeUTFBytes(str);
        writeStream.close();
    }

    private function isError():Boolean
    {
        //ERRORS IN ARRAY STEKEN
        _arrErrors = [];
        errors = false;

        if(_inputName.text != "")
        {
            if(_error1 != null)
            {
                _inputName.removeChild(_error1);
            }
        }
        else
        {
            errors = true;

            _error1.y = _inputName.height/2 - _error1.height/2;
            _inputName.addChild(_error1);

            _arrErrors.push(_error1);
        }
        for each( var input:AddInputFields in _arrIngredients)
        {
            if(input.inputIngredient.text != "")
            {
                if(_error2 != null)
                {
                    input.inputIngredient.removeChild(_error2);
                }
            }
            else
            {
                errors = true;

                _error2.y =  input.inputIngredient.height/2 - _error2.height/2;
                input.inputIngredient.addChild(_error2);

                _arrErrors.push(_error2);
            }

            if(input.inputAmount.text != "")
            {
                if(_error3 != null)
                {
                    input.inputAmount.removeChild(_error3);
                }
            }
            else
            {
                errors = true;

                _error3.y =  input.inputAmount.height/2 - _error3.height/2;
                input.inputAmount.addChild(_error3);

                _arrErrors.push(_error3);
            }

            if(input.unit.selectedIndex != -1)
            {
                if(_error4 != null)
                {
                    input.unit.removeChild(_error4);
                }
            }
            else
            {
                errors = true;

                _error4.y =  input.inputAmount.height/2 - _error3.height/2;
                input.unit.addChild(_error4);

                _arrErrors.push(_error4);
            }
        }


        return errors;
    }

    private function addedToStageHandler(event:starling.events.Event):void
    {
        _inputContainer.x = stage.stageWidth/2 - _inputContainer.width/2;
    }

    public function setSize(w:Number, h:Number):void
    {
        _explicitWidth = w;
        _explicitHeight = h;

        _scrollContainer.width = _explicitWidth;
        _scrollContainer.height = _explicitHeight - 150;

        _inputName.width = _explicitWidth - 140;

        for each(var ingInput:AddInputFields in _arrIngredients)
        {
            ingInput.inputIngredient.width = _explicitWidth - 140;
            ingInput.inputAmount.width = _explicitWidth/2 - 80;
            ingInput.unit.width = ingInput.inputAmount.width;
            ingInput.unit.x = ingInput.inputAmount.x + ingInput.inputAmount.width + 20;
        }

        _moreBtn.width = _inputName.width;
        _readyBtn.width = _inputName.width;

        _error1.x = _error2.x = _inputName.x + _inputName.width - _error1.width - 10;
        _error3.x = _inputIngredient.inputAmount.x + _inputIngredient.inputAmount.width - _error3.width - 10;
        _error4.x = _inputIngredient.unit.x - 10;
    }

    private function moreButtonTriggeredHandler(event:starling.events.Event):void
    {
        _inputIngredient = new AddInputFields();
        _inputContainer.addChild(_inputIngredient);
        _arrIngredients.push(_inputIngredient);

        _inputIngredient.inputIngredient.width = _inputName.width;
        _inputIngredient.inputAmount.width = _inputName.width/2 - 10;
        _inputIngredient.unit.width = _inputIngredient.inputAmount.width;
        _inputIngredient.unit.x = _inputIngredient.inputAmount.x + _inputIngredient.inputAmount.width + 20;

        var yPos:uint = 0;
        for each(var ingredients:AddInputFields in _arrIngredients)
        {
            ingredients.y = (_inputName.y + _inputIngredient.height/2 + 40) + yPos;

            yPos += ingredients.height + 20;
        }

        _moreBtn.y += _inputIngredient.height + 20;
        _readyBtn.y = _moreBtn.y + _readyBtn.height + 10;
    }
}
}