package be.devine.groep10.view.pages {
import be.devine.groep10.factory.RecipesVOFactory;
import be.devine.groep10.model.AppModel;
import be.devine.groep10.view.ui.AddInputFields;

import feathers.controls.Button;

import feathers.controls.List;
import feathers.controls.ScrollContainer;
import feathers.controls.TextInput;
import feathers.data.ListCollection;
import feathers.layout.VerticalLayout;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

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
    private var _eenheid1:TextInput;
    private var _eenheid2:TextInput;
    private var _arrConversies:Array;
    private var _readyBtn:Button;

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
        _waarde1.y = _inputConversie.height + 50;
        _waarde1.x = 10;
        //_waarde1.addEventListener( starling.events.Event.CHANGE, inputChangeHandler );
        _inputContainer.addChild(_waarde1);
        //_arrConversies.push(_inputConversie);


        _waarde2 = new TextInput();
        _waarde2.prompt = "waarde 2"
        _waarde2.y = _waarde1.y + _waarde2.height + 50;
        _waarde2.x = 10;
        //_waarde1.addEventListener( starling.events.Event.CHANGE, inputChangeHandler );
        _inputContainer.addChild(_waarde2);
        //_arrConversies.push(_inputConversie);

        _eenheid1 = new TextInput();
        _eenheid1.prompt = "eenheid 1"
        _eenheid1.y = _inputConversie.height + 50;
        _eenheid1.x = 200;
        //_waarde1.addEventListener( starling.events.Event.CHANGE, inputChangeHandler );
        _inputContainer.addChild(_eenheid1);
        //_arrConversies.push(_inputConversie);


        _eenheid2 = new TextInput();
        _eenheid2.prompt = "eenheid 2"
        _eenheid2.y = _eenheid1.y + _eenheid2.height + 50;
        _eenheid2.x = 200;

        //_waarde1.addEventListener( starling.events.Event.CHANGE, inputChangeHandler );
        _inputContainer.addChild(_eenheid2);


        addChild(_inputContainer);


        _readyBtn = new Button();
        _readyBtn.nameList.add(Button.READY_BUTTON);
        _readyBtn.label = "klaar!";
        _readyBtn.y = _eenheid2.y + 50;
        _inputContainer.addChild(_readyBtn);
        _readyBtn.addEventListener(starling.events.Event.TRIGGERED, readyButtonTriggeredHandler);
    }

    private function readyButtonTriggeredHandler(event:starling.events.Event):void {

        var naam:String  = _inputConversie.text;
        trace(naam);

        var str:String = new String();
        var conversionFile:File = File.applicationStorageDirectory.resolvePath("conversions.json");

        if(!conversionFile.exists)
        {
            //file bestaat niet
            str = '[{ "name":"'+naam+'","conversie": { ';
        }
        else
        {
            var conversieStr:String = readStream(conversionFile);
            //toevoegen aan bestaande file

            conversieStr = conversieStr.substring(1,conversieStr.length-1);
            conversieStr = conversieStr.replace(/\\/gi,'');
            str = '[' + conversieStr + ',{';
            //str = '[{';
            str = str + '"name":"'+naam+'","conversie": {';

        }

        var conversionNr:int = 1;
        var length:int = _arrConversies.length;
        for each( var conversie in _arrConversies)
        {

            str = str + '"deel1": { "waarde1": "' + _waarde1.text + '", "eenheid 1":"' + _eenheid1.text + '"},"deel2":{ "waarde 2":"' + _waarde2.text + '", "eenheid 2":"' + _eenheid2.text +'"}';
            if(conversionNr != length){
                str = str + ',';
            }
            conversionNr++;
        }
        str = str + '} } ]';
        writeStream(conversionFile,str);

        var readStr:String = readStream(conversionFile);
        var parsedJSON:Array = JSON.parse(readStr) as Array;
        var conversions:Array = [];
        for each(var conversion:Object in parsedJSON)
        {
            trace("[conversion] dingen")
           // conversions.push(ConversionVOFactory.createConversionVOFromObject(conversion));

            //recipes.push(RecipesVOFactory.createRecipesVOFromObject(recipe));
        }
        _appModel.conversies = conversions;
        dispatchEvent(new Event(Event.COMPLETE));


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

    private function inputChangeHandler(event:starling.events.Event):void {

    }

    private function addedToStageHandler(event:starling.events.Event):void {
        _conversionList.x = stage.stageWidth / 2 - _conversionList.width / 2;

        _inputContainer.x = stage.stageWidth / 2 - _inputContainer.width / 2;

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


        // _inputConversie.width = _explicitWidth - 140;
        _waarde1.width = _explicitWidth / 2 - 80;
        _waarde2.width = _waarde1.width;


//        _recipeList.setSize(_explicitWidth - 120, _explicitHeight - 120);
//        _ownRecipesList.setSize(_explicitWidth - 120, _explicitHeight - 120);
    }
}
}