/**
 * Created with IntelliJ IDEA.
 * User: cavia
 * Date: 12/10/13
 * Time: 2:50 PM
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.view.pages
{
import be.devine.groep10.model.AppModel;
import be.devine.groep10.vo.RecipesVO;

import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.List;
import feathers.data.ListCollection;
import feathers.layout.VerticalLayout;

import starling.display.Sprite;

public class Detail extends Sprite{
    private var _appModel:AppModel;

    private var container:Sprite;
    private var _explicitWidth:Number = 480;
    private var _listingredient:ListCollection;
    private var _listvalue:ListCollection;
    private var _listunit:ListCollection;

    public function Detail(){

        container =  new Sprite();
        addChild(container);

        _appModel = AppModel.getInstance();

        var listingredient:List = new List();
        listingredient.width = 360;
        listingredient.height = 670;


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


        _listingredient = new ListCollection();
        _listunit = new ListCollection();
        _listvalue = new ListCollection();

        for each(var recipe:Object in _appModel.recipes)
        {


            if(recipe.name == _appModel.currentRecipe){
                trace(recipe.ingredientname);

                for each(var ingredient:Object in recipe.ingredients){

                    _listingredient.push(ingredient.ingredientname);
                    _listunit.push(ingredient.ingredientunit);
                    _listvalue.push(ingredient.ingredientvalue);
                }
            }



        }
        listingredient.dataProvider = _listingredient;



        listingredient.itemRendererProperties.labelField = "text";






    }
}
}
