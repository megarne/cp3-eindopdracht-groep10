/**
 * Created with IntelliJ IDEA.
 * User: zoevankuyk
 * Date: 19/12/13
 * Time: 15:41
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.factory
{
import starling.display.Sprite;
import starling.text.TextField;
import starling.utils.HAlign;
import starling.utils.VAlign;

public class TextFieldFactory extends Sprite
{

    public function TextFieldFactory(width:uint, height:uint, text:String, fontFamily:String, fontSize:uint, color:uint)
    {
        var textfield = new TextField(
                width, height, text, fontFamily, fontSize, color
        );

        textfield.hAlign = HAlign.LEFT;
        textfield.vAlign = VAlign.TOP;
        textfield.kerning = true;
        addChild(textfield);
    }
}
}