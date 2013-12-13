/**
 * Created with IntelliJ IDEA.
 * User: cavia
 * Date: 12/10/13
 * Time: 2:50 PM
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.view {
import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.List;
import feathers.data.ListCollection;
import feathers.layout.VerticalLayout;

import starling.display.Sprite;

public class Detail extends Sprite{

    private var container:Sprite;
    private var _header:Header;
    private var _explicitWidth:Number = 480;

    public function Detail(){

        container =  new Sprite();
        addChild(container);

        var list:List = new List();
        list.width = 360;
        list.height = 500;


        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
        layout.gap = 30;
        layout.paddingTop = layout.paddingRight = layout.paddingBottom = layout.paddingLeft = 10;
        list.layout = layout;
        list.itemRendererProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
        list.itemRendererProperties.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
        list.itemRendererProperties.iconPosition = Button.ICON_POSITION_TOP;
        list.itemRendererProperties.gap = 10;
        list.x = Math.round((_explicitWidth - list.width) * .5);
        list.y = 300;


        this.addChild( list );

        var recipesList:ListCollection = new ListCollection(
                [
                    { text: "wortels of wa"  },
                    { text: "cavias"  },
                    { text: "vier is ook lekker"},
                    { text: "wortels of wa"  },
                    { text: "cavias"  },
                    { text: "vier is ook lekker"},
                    { text: "wortels of wa"  },
                    { text: "cavias"  },
                    { text: "vier is ook lekker"},
                    { text: "ik ben nie lekker"}
                ]);
        list.dataProvider = recipesList;
        list.itemRendererProperties.labelField = "text";

        _header = new Header();
        _header.title="ik ben een gerecht"
        _header.y=150;
        addChild(_header);




    }
}
}
