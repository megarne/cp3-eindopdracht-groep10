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

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import starling.display.Sprite;

import starling.events.Event;
import starling.text.TextField;

public class Add extends Sprite
{
    private var _scrollContainer:ScrollContainer;
    private var _inputContainer:Sprite;

    private var _explicitWidth:Number = 0;
    private var _explicitHeight:Number = 0;

    private var _inputName:TextInput;

    private var _inputIngredient:AddInputFields;

    private var _inputPreparation:TextInput;

    private var _arrIngredients:Array;

    private var _moreBtn:Button;

    private var _addBTn:Button;

    private var inputError1:TextField;
    private var inputError2:TextField;
    private var inputError3:TextField;
    private var _noErrors:Array;

    public function Add()
    {
        _arrIngredients = [];

        /*_scrollContainer = new ScrollContainer();
        _scrollContainer.width = 230;
        _scrollContainer.height = 600;
        this.addChild( _scrollContainer );*/

        _inputContainer = new Sprite();
        addChild(_inputContainer);

        _inputName = new TextInput();
        _inputName.text = "Naam recept";
        _inputName.height = 60;
        //_inputName.textEditorProperties.fontsize(35);
        _inputName.selectRange( 0, _inputName.text.length );
        _inputName.addEventListener( FeathersEventType.FOCUS_IN, inputFocusInHandler );
        _inputName.addEventListener( starling.events.Event.CHANGE, inputChangeHandler );
        _inputContainer.addChild( _inputName );

        _inputIngredient = new AddInputFields();
        _inputIngredient.y = _inputName.y + _inputIngredient.height + 40;
        _inputIngredient.addEventListener( starling.events.Event.CHANGE, inputChangeHandler );
        _inputContainer.addChild(_inputIngredient);
        _arrIngredients.push(_inputIngredient);

        _moreBtn = new Button();
        _moreBtn.label = "+ extra ingredient";
        _moreBtn.y = _inputContainer.height + _moreBtn.height + 60;
        _inputContainer.addChild( _moreBtn );
        _moreBtn.addEventListener( starling.events.Event.TRIGGERED, buttonTriggeredHandler );
        _inputContainer.addChild( _moreBtn );

        _addBTn = new Button();
        _addBTn.label = "recept klaar";
        _addBTn.y = _moreBtn.y + _addBTn.height + 60;
        _addBTn.addEventListener( starling.events.Event.TRIGGERED, AddRecipeHandler );
        _inputContainer.addChild( _addBTn );

    }

    public function setSize(w:Number, h:Number):void
    {
        _explicitWidth = w;
        _explicitHeight = h;
        //_inputContainer.x = Math.round((_explicitWidth - _inputContainer.width) * .5);

        /*_inputContainer.width = _explicitWidth;
        _inputContainer.height = _explicitHeight;*/

        _inputName.width = _explicitWidth - 140;

        _moreBtn.width = _inputName.width;
        _addBTn.width = _inputName.width;

        _inputIngredient.inputIngredient.width = _explicitWidth - 140, _explicitHeight;
        _inputIngredient.inputAmount.width = _explicitWidth/2 - 100, _explicitHeight;

        _inputIngredient.unit.x = _inputName.x + _inputName.width - _inputIngredient.unit.width;
    }

    private function inputFocusInHandler(event:starling.events.Event):void
    {
        var inputFocusIn:TextInput = event.currentTarget as TextInput;
        inputFocusIn.text = "";
        inputFocusIn.textEditorProperties.color = 0x00c5a9;
    }

    private function buttonTriggeredHandler(event:starling.events.Event):void
    {
        _inputIngredient = new AddInputFields();
        _inputIngredient.inputIngredient.addEventListener( starling.events.Event.CHANGE, inputChangeHandler );
        _inputIngredient.inputAmount.addEventListener( starling.events.Event.CHANGE, inputChangeHandler );
        _inputContainer.addChild(_inputIngredient);
        _arrIngredients.push(_inputIngredient);

        var yPos:uint = 0;
        for each(var ingredients:AddInputFields in _arrIngredients)
        {
            ingredients.y = _inputIngredient.y = _inputName.y + _inputIngredient.height + 40 + yPos;

            yPos += ingredients.height + 10;
        }

        _moreBtn.y += _inputIngredient.height + 60;
        _addBTn.y = _moreBtn.y + _addBTn.height + 20;
    }

    private function AddRecipeHandler(event:starling.events.Event):void
    {
        checkIfInputIsEmpty();
    }

    private function checkIfInputIsEmpty():void
    {
        _noErrors = [];

        if(_inputName.text == "" || _inputName.text == "Naam recept" )
        {
            inputError1 = new TextField(100, 20, "Vul een naam in", "BebasNeue", 16, 0xe49f98);
            inputError1.x = _inputIngredient.x + _inputIngredient.width + inputError1.width;
            inputError1.y = _inputName.height/2 - inputError1.height/2;
            addChild(inputError1);
        }
        else
        {
            _noErrors.push(_inputName.text);
        }

        for each( var input:AddInputFields in _arrIngredients)
        {
            if(input.inputIngredient.text == "" || input.inputIngredient.text == "Naam Ingredient" )
            {
                inputError2 = new TextField(100, 50, "Vul een ingredient in", "BebasNeue", 14, 0xe49f98);
                inputError2.x = _inputIngredient.x + _inputIngredient.width + inputError2.width;
                inputError2.y = _inputIngredient.y;
                addChild(inputError2);
            }
            else
            {
                _noErrors.push(input.inputIngredient.text);
            }

            if(input.inputAmount.text == "" || input.inputAmount.text == "Hoeveelheid" )
            {
                inputError3 = new TextField(100, 50, "Kies een hoeveelheid", "BebasNeue", 14, 0xe49f98);
                inputError3.x = _inputIngredient.x + _inputIngredient.width + inputError3.width;
                inputError3.y = _inputIngredient.y + _inputIngredient.height/2;
                addChild(inputError3);
            }
            else
            {
                _noErrors.push(input.inputAmount.text);
            }
        }

        if(_noErrors.length >= 3)
        {
            removeChild(inputError1);
            removeChild(inputError2);
            removeChild(inputError3);
            removeChild(_scrollContainer);

            //hier alle input in json steken en doorsturen naar recepten-pagina
            //trace("hier alle input in json steken en doorsturen naar recepten-pagina");


            //trace(_inputName.text);

            var recipeName:String = _inputName.text;

             for each( var input:AddInputFields in _arrIngredients)
             {

             trace("[ADD]" + input.inputIngredient.text);
             trace("[ADD]" + input.inputAmount.text);
             trace("[ADD]" + input.unit.selectedItem.text);

                 var ownRecipesFile:File = File.applicationStorageDirectory.resolvePath("ownRecipes.json");


                 //hoe ingredient2 op een goeie manier aanspreken?
                 //nog geen preparation veld voorzien
                 if(!ownRecipesFile.exists){
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


             }
        }
    }

    private function inputChangeHandler(event:starling.events.Event):void
    {
        if(inputError1 != null)
        {
            if(_inputName.text != null)
            {
                inputError1.visible = false;
            }
            else
            {
                inputError1.visible = true;
            }
        }

        if(inputError2 != null)
        {
            if(_inputIngredient.inputIngredient.text != "")
            {
                inputError2.visible = false;
            }
            else
            {
                inputError2.visible = true;
            }
        }

        if(inputError3 != null)
        {
            if(_inputIngredient.inputAmount.text != "")
            {
                inputError3.visible = false;
            }
            else
            {
                inputError3.visible = true;
            }
        }

    }
}
}