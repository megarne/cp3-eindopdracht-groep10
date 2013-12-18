/**
 * Created with IntelliJ IDEA.
 * User: cavia
 * Date: 12/10/13
 * Time: 2:50 PM
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.view.pages
{
import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.List;
import feathers.data.ListCollection;
import feathers.layout.VerticalLayout;

import starling.display.Sprite;

public class Detail extends Sprite{

    private var container:Sprite;
    private var _explicitWidth:Number = 480;

    public function Detail(){

        container =  new Sprite();
        addChild(container);

        var listingredient:List = new List();
        listingredient.width = 360;
        listingredient.height = 500;


        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
        layout.gap = 30;
        layout.paddingTop = layout.paddingRight = layout.paddingBottom = layout.paddingLeft = 10;
        listingredient.layout = layout;
        listingredient.itemRendererProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
        listingredient.itemRendererProperties.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
        listingredient.itemRendererProperties.iconPosition = Button.ICON_POSITION_TOP;
        listingredient.itemRendererProperties.gap = 10;
        listingredient.x = Math.round((_explicitWidth - listingredient.width) * .5);
        listingredient.y = 100;


        container.addChild( listingredient );

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
        listingredient.dataProvider = recipesList;
        listingredient.itemRendererProperties.labelField = "text";






    }
}
}
