package be.devine.groep10.view.pages
{
import be.devine.groep10.factory.TextFieldFactory;
import be.devine.groep10.model.AppModel;

import feathers.controls.Button;
import feathers.controls.TextInput;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;

public class Conversion extends Sprite
{
    private var _appModel:AppModel;

    private var _inputContainer:Sprite;

    private var _inputConversieName:TextInput;

    private var _waarde1:TextInput;
    private var _waarde2:TextInput;
    private var _eenheid1:TextInput;
    private var _eenheid2:TextInput;
    private var _arrConversies:Array;
    private var _readyBtn:Button;

    private var _explicitWidth:Number = 0;
    private var _explicitHeight:Number = 0;

    [Embed(source="/../assets/custom/error.png")]
    private static const ErrorClass:Class;
    private var _error1:Image;
    private var _error2:Image;
    private var _error3:Image;
    private var _error4:Image;
    private var _error5:Image;

    private var _arrErrors:Array;
    private var errors:Boolean;

    private var _helpText:TextFieldFactory;

    public function Conversion()
    {
        _appModel = AppModel.getInstance();

        this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);

        _arrConversies = [];
        _arrErrors = [];

        _inputContainer = new Sprite();
        addChild(_inputContainer);

        _inputConversieName = new TextInput();
        _inputConversieName.prompt = "naam conversie";
        _inputContainer.addChild( _inputConversieName );

        _waarde1 = new TextInput();

        _waarde1.prompt = "waarde 1";
        _waarde1.y = _inputConversieName.y + _waarde1.height + 80;

        _waarde1.prompt = "waarde 1"

        _waarde1.y = _inputConversieName.height + 50;

        _inputContainer.addChild(_waarde1);
        _arrConversies.push(_waarde1);

        _eenheid1 = new TextInput();
        _eenheid1.prompt = "eenheid 1"
        _eenheid1.y = _waarde1.y
        _inputContainer.addChild(_eenheid1);

        _helpText = new TextFieldFactory( 320, 120, "=", "BebasNeue", 50, 0xffffff);
        _helpText.y = _waarde1.y + 45;
        _inputContainer.addChild(_helpText);

        _waarde2 = new TextInput();
        _waarde2.prompt = "waarde 2";
        _waarde2.y = _waarde1.y + _waarde2.height + 100;
        _inputContainer.addChild(_waarde2);
        _arrConversies.push(_waarde2);

        _eenheid2 = new TextInput();
        _eenheid2.prompt = "eenheid 2"
        _eenheid2.y = _waarde2.y
        _inputContainer.addChild(_eenheid2);

        _waarde1.restrict = _waarde2.restrict = "0-9";

        _readyBtn = new Button();
        _readyBtn.nameList.add(Button.READY_BUTTON);
        _readyBtn.label = "klaar!";
        _readyBtn.y = _eenheid2.y + _eenheid2.height + _readyBtn.height + 100;
        _inputContainer.addChild(_readyBtn);
        _readyBtn.addEventListener(starling.events.Event.TRIGGERED, readyButtonTriggeredHandler);

        errors = false;
        _error1 = Image.fromBitmap(new ErrorClass());
        _error2 = Image.fromBitmap(new ErrorClass());
        _error3 = Image.fromBitmap(new ErrorClass());
        _error4 = Image.fromBitmap(new ErrorClass());
        _error5 = Image.fromBitmap(new ErrorClass());
    }

    private function readyButtonTriggeredHandler(event:starling.events.Event):void
    {
        if (!isError())
        {
            var naam:String = _inputConversieName.text;
            trace(naam);

            var str:String = new String();
            var conversionFile:File = File.applicationStorageDirectory.resolvePath("conversions.json");

            if (!conversionFile.exists)
            {
                str = '[{ "name":"' + naam + '","conversie": { ';
            }
            else
            {
                var conversieStr:String = readStream(conversionFile);

                conversieStr = conversieStr.substring(1, conversieStr.length - 1);
                conversieStr = conversieStr.replace(/\\/gi, '');
                str = '[' + conversieStr + ',{';
                //str = '[{';
                str = str + '"name":"' + naam + '","conversie": {';
            }

            var conversionNr:int = 1;
            var length:int = _arrConversies.length;
            for each(var conversie in _arrConversies)
            {

                str = str + '"deel1": { "waarde1": "' + _waarde1.text + '", "eenheid1":"' + _eenheid1.text + '"},"deel2":{ "waarde2":"' + _waarde2.text + '", "eenheid2":"' + _eenheid2.text + '"}';
                if (conversionNr != length)
                {
                    str = str + ',';
                }
                conversionNr++;
            }
            str = str + '} } ]';
            writeStream(conversionFile, str);

            var readStr:String = readStream(conversionFile);
            var parsedJSON:Array = JSON.parse(readStr) as Array;
            var conversions:Array = [];
            for each(var conversion:Object in parsedJSON)
            {
                trace("[conversion] dingen");
            }
            _appModel.conversies = conversions;
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }

    private function isError():Boolean
    {
        errors = false;

        if(_inputConversieName.text != "")
        {
            if(_error1 != null)
            {
                _inputConversieName.removeChild(_error1);
            }
        }
        else
        {
            errors = true;

            _error1.y = _inputConversieName.height/2 - _error1.height/2;
            _inputConversieName.addChild(_error1);

            _arrErrors.push(_error1);
        }

        if(_waarde1.text != "")
        {
            if(_error2 != null)
            {
                _waarde1.removeChild(_error2);
            }
        }
        else
        {
            errors = true;

            _error2.y =  _waarde1.height/2 - _error2.height/2;
            _waarde1.addChild(_error2);

            _arrErrors.push(_error2);
        }

        if(_waarde2.text != "")
        {
            if(_error3 != null)
            {
                _waarde2.removeChild(_error3);
            }
        }
        else
        {
            errors = true;

            _error3.y =  _waarde2.height/2 - _error3.height/2;
            _waarde2.addChild(_error3);

            _arrErrors.push(_error3);
        }

        if(_eenheid1.text != "")
        {
            if(_error4 != null)
            {
                _eenheid1.removeChild(_error4);
            }
        }
        else
        {
            errors = true;

            _error4.y =  _eenheid1.height/2 - _error4.height/2;
            _eenheid1.addChild(_error4);

            _arrErrors.push(_error4);
        }
        if(_eenheid2.text != "")
        {
            if(_error5 != null)
            {
                _eenheid2.removeChild(_error5);
            }
        }
        else
        {
            errors = true;

            _error5.y =  _eenheid2.height/2 - _error5.height/2;
            _eenheid2.addChild(_error5);

            _arrErrors.push(_error5);
        }
        return errors;
    }

    private function readStream(file:File):String
    {
        var readStream:FileStream = new FileStream();
        readStream.open(file, FileMode.READ);
        var string:String = readStream.readUTFBytes(readStream.bytesAvailable);
        readStream.close();
        return string;
    }

    private function writeStream(file:File, str:String)
    {
        var writeStream:FileStream = new FileStream();
        writeStream.open(file, FileMode.WRITE);
        writeStream.writeUTFBytes(str);
        writeStream.close();
    }

    private function addedToStageHandler(event:starling.events.Event):void
    {
        _inputContainer.x = stage.stageWidth/2 - _inputContainer.width/2;
    }

    public function setSize(w:Number, h:Number):void
    {
        _explicitWidth = w;
        _explicitHeight = h;

        _inputConversieName.width = _explicitWidth - 140;
        _waarde1.width = _eenheid1.width = _waarde2.width = _eenheid2.width = _inputConversieName.width/2 - 5;
        _eenheid1.x = _eenheid2.x = _inputConversieName.x + _inputConversieName.width - _eenheid1.width;

        _readyBtn.width = _inputConversieName.width;

        _error1.x = _inputConversieName.x + _inputConversieName.width - _error1.width - 10;
        _error2.x = _error4.x = _waarde1.x + _waarde1.width - _error2.width - 10;
        _error3.x = _error5.x = _waarde2.x + _waarde2.width - _error3.width - 10;
    }
}
}