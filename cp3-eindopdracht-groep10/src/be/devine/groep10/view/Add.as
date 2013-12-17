/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 5/12/13
 * Time: 21:39
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.view
{
import be.devine.groep10.view.ui.AddInputFields;

import feathers.controls.Button;
import feathers.controls.ScrollContainer;

import feathers.controls.TextInput;
import feathers.events.FeathersEventType;

import flash.events.Event;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;

import starling.events.Event;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class Add extends Sprite
{
    private var _scrollContainer:ScrollContainer;
    private var _inputContainer:Sprite;

    private var _explicitWidth:Number = 0;
    private var _explicitHeight:Number = 0;

    private var _inputName:TextInput;
    private var _inputIngredient:AddInputFields;

    private var _helpText:TextField;

    private var _arrIngredients:Array;

    private var _moreBtn:Button;
    private var _readyBtn:Button;

    [Embed(source = "/../assets/custom/error.png")]
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

        _arrIngredients = [];

        _scrollContainer = new ScrollContainer();
        addChild( _scrollContainer );

        _inputContainer = new Sprite();
        _scrollContainer.addChild(_inputContainer);

        _inputName = new TextInput();
        _inputName.prompt = "naam recept";
        _inputName.addEventListener( starling.events.Event.CHANGE, inputChangeHandler );
        _inputContainer.addChild( _inputName );

        _helpText = new TextField( 320, 120, "Vul de nodige ingredienten toe voor 1 persoon", "BebasNeue", 18, 0xffffff);
        _helpText.hAlign = HAlign.LEFT;
        _helpText.vAlign = VAlign.TOP;
        _helpText.kerning = true;
        _helpText.y = 50;
        _inputName.addChild(_helpText);

        _inputIngredient = new AddInputFields();
        _inputIngredient.y = _inputName.y + _inputIngredient.height + 20;
        _inputIngredient.addEventListener( starling.events.Event.CHANGE, inputChangeHandler );
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

    private function inputChangeHandler(event:starling.events.Event):void
    {

    }

    private function readyButtonTriggeredHandler(event:starling.events.Event):void
    {
        //ERRORS IN ARRAY STEKEN
        _arrErrors = [];

        if(_inputName.text != "")
        {
            errors = false;

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

        if(_inputIngredient.inputIngredient.text != "")
        {
            errors = false;

            if(_error2 != null)
            {
                _inputIngredient.inputIngredient.removeChild(_error2);
            }
        }
        else
        {
            errors = true;

            _error2.y =  _inputIngredient.inputIngredient.height/2 - _error2.height/2;
            _inputIngredient.inputIngredient.addChild(_error2);

            _arrErrors.push(_error2);
        }

        if(_inputIngredient.inputAmount.text != "")
        {
            errors = false;

            if(_error3 != null)
            {
                _inputIngredient.inputAmount.removeChild(_error3);
            }
        }
        else
        {
            errors = true;

            _error3.y =  _inputIngredient.inputAmount.height/2 - _error3.height/2;
            _inputIngredient.inputAmount.addChild(_error3);

            _arrErrors.push(_error3);
        }

        if(_inputIngredient.unit.selectedIndex != -1)
        {
            errors = false;

            if(_error4 != null)
            {
                _inputIngredient.unit.removeChild(_error4);
            }
        }
        else
        {
            errors = true;

            _error4.y =  _inputIngredient.inputAmount.height/2 - _error3.height/2;
            _inputIngredient.unit.addChild(_error4);

            _arrErrors.push(_error4);
        }

        if(errors == false)
        {
            trace("alles juist");

            //value doorsturen naar json
            /*var recipeName:String = _inputName.text;

            for each( var input:AddInputFields in _arrIngredients)
            {

                trace("[ADD]" + input.inputIngredient.text);
                trace("[ADD]" + input.inputAmount.text);
                trace("[ADD]" + input.unit.selectedItem.text);

                var ownRecipesFile:File = File.applicationStorageDirectory.resolvePath("ownRecipes.json");

                //hoe ingredient2 op een goeie manier aanspreken?
                if(!ownRecipesFile.exists)
                {
                    var writeStream:FileStream = new FileStream();
                    writeStream.open(ownRecipesFile, FileMode.WRITE);
                    writeStream.writeUTFBytes(JSON.stringify([

                        {
                            "name": recipeName,
                            "ingredients":
                            {
                                "ingredient1":
                                {
                                    "ingredientname":input.inputIngredient.text,
                                    "ingredientvalue":input.inputAmount.text,
                                    "ingredientunit":input.unit.selectedItem.text
                                }
                            },
                            "preparation":" meng alles samen tot een lekkere emulsie "

                        }

                    ]));
                    writeStream.close();
                }
            }*/
        }
    }

    private function addedToStageHandler(event:starling.events.Event):void
    {
        _scrollContainer.width = stage.stageWidth
        _scrollContainer.height = stage.stageHeight - 120;

        _inputContainer.x = stage.stageWidth/2 - _inputContainer.width/2;
    }

    public function setSize(w:Number, h:Number):void
    {
        _explicitWidth = w;
        _explicitHeight = h;

        _scrollContainer.width = _explicitWidth;
        _scrollContainer.height = _explicitHeight - 120;

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
        _inputIngredient.inputIngredient.addEventListener( starling.events.Event.CHANGE, inputChangeHandler );
        _inputIngredient.inputAmount.addEventListener( starling.events.Event.CHANGE, inputChangeHandler );
        _inputContainer.addChild(_inputIngredient);
        _arrIngredients.push(_inputIngredient);

        _inputIngredient.inputIngredient.width = _inputName.width;
        _inputIngredient.inputAmount.width = _inputName.width/2 - 10;
        _inputIngredient.unit.width = _inputIngredient.inputAmount.width;
        _inputIngredient.unit.x = _inputIngredient.inputAmount.x + _inputIngredient.inputAmount.width + 20;

        var yPos:uint = 0;
        for each(var ingredients:AddInputFields in _arrIngredients)
        {
            ingredients.y = (_inputName.y + _inputIngredient.height/2 + 27) + yPos;

            yPos += ingredients.height + 20;
        }

        _moreBtn.y += _inputIngredient.height + 20;
        _readyBtn.y = _moreBtn.y + _readyBtn.height + 10;
    }
}
}