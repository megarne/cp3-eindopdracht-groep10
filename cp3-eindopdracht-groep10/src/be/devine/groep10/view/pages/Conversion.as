package be.devine.groep10.view.pages {
import be.devine.groep10.model.AppModel;
import be.devine.groep10.view.ui.AddInputFields;

import feathers.controls.Button;

import feathers.controls.List;
import feathers.controls.ScrollContainer;
import feathers.controls.TextInput;
import feathers.data.ListCollection;
import feathers.layout.VerticalLayout;

import starling.display.Sprite;
import starling.events.Event;

public class Conversion extends Sprite {
    private var _appModel:AppModel;

    private var _conversionList:List;
    private var _listCollection:ListCollection;

    private var _inputContainer:Sprite;
    private var _inputConversie:TextInput;

    private var _waarde1:TextInput;
    private var _waarde2:TextInput;
    private var _arrConversies:Array;

    private var _explicitWidth:Number = 0;
    private var _explicitHeight:Number = 0;

    public function Conversion() {
        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);

        _appModel = AppModel.getInstance();

        _conversionList = new List();
        _arrConversies = [];


        if (_appModel.currentPage == "conversie toevoegen") {
            _conversionList.itemRendererProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
            _conversionList.addEventListener(starling.events.Event.CHANGE, listChangeHandler);
            _conversionList.itemRendererProperties.labelField = "title";
            addChild(_conversionList);
        }

        _inputContainer = new Sprite();

        _inputConversie = new TextInput();
        _inputConversie.prompt = "naam conversie";
        _inputConversie.addEventListener(starling.events.Event.CHANGE, inputChangeHandler);
        _inputContainer.addChild(_inputConversie);

        _arrConversies.push(_inputConversie);

        _waarde1 = new TextInput();
        _waarde1.prompt = "waarde 1"
        _waarde1.y = 10;
        //_waarde1.addEventListener( starling.events.Event.CHANGE, inputChangeHandler );
        _inputContainer.addChild(_waarde1);
        //_arrConversies.push(_inputConversie);


        _waarde2 = new TextInput();
        _waarde2.prompt = "waarde 2"
        _waarde2.y = _waarde1.height + _waarde2.height;
        //_waarde1.addEventListener( starling.events.Event.CHANGE, inputChangeHandler );
        _inputContainer.addChild(_waarde2);
        //_arrConversies.push(_inputConversie);


        addChild(_inputContainer);


        display();
    }

    private function inputChangeHandler(event:starling.events.Event):void {

    }

    private function addedToStageHandler(event:starling.events.Event):void {
        _conversionList.x = stage.stageWidth / 2 - _conversionList.width / 2;

    }


    private function listChangeHandler(event:starling.events.Event):void {
        if (_appModel.currentPage == "conversie toevoegen") {


        }

    }

    private function display():void {
        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
        layout.gap = 30;
        layout.paddingTop = layout.paddingRight = layout.paddingBottom = layout.paddingLeft = 10;

        if (_appModel.currentPage == "conversie toevoegen") {
            _listCollection = new ListCollection();

            for each(var conversie:Object in _appModel.conversies) {
                _listCollection.push(conversie.name);
            }
            _conversionList.dataProvider = _listCollection;


            _conversionList.layout = layout;
        }


    }

    public function setSize(w:Number, h:Number):void {
        _explicitWidth = w;
        _explicitHeight = h;

        _inputConversie.width = _explicitWidth - 140;
        _waarde1.width = _explicitWidth / 2 - 80;
        _waarde2.width = _waarde1.width;
        _waarde2.x = _waarde1.x + _waarde1.width + 20;


//        _recipeList.setSize(_explicitWidth - 120, _explicitHeight - 120);
//        _ownRecipesList.setSize(_explicitWidth - 120, _explicitHeight - 120);
    }
}
}