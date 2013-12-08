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

import feathers.controls.TextInput;
import feathers.events.FeathersEventType;

import flash.events.Event;

import starling.display.Sprite;

import starling.events.Event;

public class Add extends Sprite
{
    private var _inputContainer:Sprite;

    private var _explicitWidth:Number = 0;
    private var _explicitHeight:Number = 0;

    private var _inputName:TextInput;

    private var _inputIngredient:AddInputFields;

    private var _arrIngredients:Array;

    private var _moreBtn:Button;

    private var _addBTn:Button;

    public function Add()
    {
        _arrIngredients = [];

        _inputContainer = new Sprite();
        addChild(_inputContainer);

        _inputName = new TextInput();
        _inputName.text = "Naam recept";
        _inputName.height = 60;
        _inputName.selectRange( 0, _inputName.text.length );
        _inputName.addEventListener( FeathersEventType.FOCUS_IN, inputFocusInHandler );
        _inputContainer.addChild( _inputName );

        _inputIngredient = new AddInputFields();
        _inputIngredient.y = _inputName.y + _inputIngredient.height + 40;
        _inputContainer.addChild(_inputIngredient);
        _arrIngredients.push(_inputIngredient);

        _moreBtn = new Button();
        _moreBtn.label = "+ extra ingredient";
        _moreBtn.y = _inputContainer.height + _moreBtn.height + 60;
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
        _inputContainer.x = Math.round((_explicitWidth - _inputContainer.width) * .5);
    }

    private function inputFocusInHandler(event:starling.events.Event):void
    {
        var inputFocusIn:TextInput = event.currentTarget as TextInput;
        inputFocusIn.text = "";
    }

    private function buttonTriggeredHandler(event:starling.events.Event):void
    {
        _inputIngredient = new AddInputFields();
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
        trace(_inputName.text);

        for each( var input:AddInputFields in _arrIngredients)
        {
            trace(input.inputIngredient.text);
            trace(input.inputAmount.text);
            trace(input.unit.selectedItem.text);
        }
    }
}
}
