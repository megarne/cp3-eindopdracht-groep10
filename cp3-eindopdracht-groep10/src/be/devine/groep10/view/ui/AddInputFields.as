/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 6/12/13
 * Time: 10:44
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.view.ui
{
import feathers.controls.PickerList;
import feathers.controls.TextInput;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;

import flash.text.SoftKeyboardType;

import starling.display.Sprite;
import starling.events.Event;

public class AddInputFields extends Sprite
    {
        private var _inputContainer:Sprite;

        private var _inputIngredient:TextInput;
        private var _inputAmount:TextInput;
        private var _unit:PickerList;

        public function AddInputFields()
        {
            _inputContainer = new starling.display.Sprite();
            addChild(_inputContainer);

            _inputIngredient = new TextInput();
            _inputIngredient.text = "Naam Ingredient";
            _inputIngredient.addEventListener( FeathersEventType.FOCUS_IN, inputFocusInHandler );
            _inputContainer.addChild( _inputIngredient );

            _inputAmount = new TextInput();
            _inputAmount.text = "Hoeveelheid";
            _inputAmount.restrict = '0-9';
            _inputAmount.width = 100;
            _inputAmount.y = _inputIngredient.y + (_inputAmount.text.length) + 40;
            _inputAmount.textEditorProperties.softKeyboardType = SoftKeyboardType.NUMBER;
            _inputAmount.addEventListener( FeathersEventType.FOCUS_IN, inputFocusInHandler );
            _inputContainer.addChild( _inputAmount );

            _unit = new PickerList();

            var unitList:ListCollection = new ListCollection(
            [
                { text: "kg"},{ text: "g"},{ text: "el"},{ text: "tl"},{ text: "l"},{ text: "ml"},{ text: "cl"},{ text: "mg"}
            ]);

            _unit.dataProvider = unitList;
            _unit.listProperties.@itemRendererProperties.labelField = "text";
            _unit.labelField = "text";
            _unit.selectedIndex = 0;
            _unit.width = _inputAmount.width;
            _unit.x = _inputContainer.width + 5;
            _unit.y = _inputAmount.y;
            _inputContainer.addChild( _unit );
        }

        private function inputFocusInHandler(event:starling.events.Event):void
        {
            var inputFocusIn:TextInput = event.currentTarget as TextInput;
            inputFocusIn.text = "";
        }
    }
}