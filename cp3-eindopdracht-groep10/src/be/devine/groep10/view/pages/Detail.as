package be.devine.groep10.view.pages
{
import be.devine.groep10.model.AppModel;
import be.devine.groep10.vo.RecipesVO;
import feathers.controls.Button;
import feathers.controls.Header;
import feathers.controls.List;
import feathers.controls.PickerList;
import feathers.controls.ScrollContainer;
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
    private var _scrollContainer:ScrollContainer;
    public function Detail(){
<<<<<<< HEAD
        _scrollContainer = new ScrollContainer();
        _scrollContainer.width = 360;
        // _scrollContainer.x = Math.round((_explicitWidth - _scrollContainer.width) * .5);
        _scrollContainer.height = 700;
        _scrollContainer.y = 100;
        addChild( _scrollContainer );
=======

        container =  new Sprite();
        addChild(container);

        _appModel = AppModel.getInstance();

        var listingredient:List = new List();
        listingredient.width = 360;
        listingredient.height = 670;

>>>>>>> 07cf26d7b2dcc1ba05157e327824196fc7876068
        var layout:VerticalLayout = new VerticalLayout();
        layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
        layout.gap = 30;
        layout.paddingTop = layout.paddingRight = layout.paddingBottom = layout.paddingLeft = 10;
        var listingredient:List = new List();
        listingredient.layout = layout;
        listingredient.itemRendererProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
        listingredient.itemRendererProperties.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
        listingredient.itemRendererProperties.iconPosition = Button.ICON_POSITION_TOP;
        listingredient.itemRendererProperties.gap = 10;
        var layin:VerticalLayout = new VerticalLayout();
        layin.gap = 30;
        layin.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
        layin.paddingTop = layin.paddingRight = layin.paddingBottom = layin.paddingLeft = 10;
        var listvalue:List = new List();
        listvalue.layout = layin;
        listvalue.itemRendererProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
        listvalue.itemRendererProperties.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
        listvalue.itemRendererProperties.iconPosition = Button.ICON_POSITION_TOP;
        listvalue.itemRendererProperties.gap = 10;
        listingredient.x = Math.round((_explicitWidth - listingredient.width) * .5);
<<<<<<< HEAD
        //listingredient.y = 100;
        _appModel = AppModel.getInstance();
        _scrollContainer.addChild(listingredient);
        //als listvalue add dan crash
        //_scrollContainer.addChild(listvalue);
        trace("[DETAIL]" + listvalue.dataProvider);
=======
        listingredient.y = 100;

        container.addChild( listingredient );

>>>>>>> 07cf26d7b2dcc1ba05157e327824196fc7876068
        _listingredient = new ListCollection();
        _listunit = new ListCollection();
        _listvalue = new ListCollection();
        /* container =  new Sprite();
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
         var layin:VerticalLayout = new VerticalLayout();
         layin.gap = 30;
         layin.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
         layin.paddingTop = layin.paddingRight = layin.paddingBottom = layin.paddingLeft = 10;
         var listvalue:List = new List();
         listvalue.width = 200;
         listvalue.height = 470;
         listvalue.layout = layin;
         listvalue.itemRendererProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
         listvalue.itemRendererProperties.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
         listvalue.itemRendererProperties.iconPosition = Button.ICON_POSITION_TOP;
         listvalue.itemRendererProperties.gap = 10;
         listvalue.x = Math.round((_explicitWidth - listvalue.width) * .5);
         listvalue.y = 100;
         _listingredient = new ListCollection();
         _listunit = new ListCollection();
         _listvalue = new ListCollection();
         container.addChild( listingredient );
         container.addChild( listvalue );     */
        for each(var recipe:Object in _appModel.recipes)
        {
<<<<<<< HEAD
            if(recipe.name == _appModel.currentRecipe){
               // trace(recipe.ingredientname);
                for each(var ingredient:Object in recipe.ingredients){
=======
            if(recipe.name == _appModel.currentRecipe)
            {
                trace(recipe.ingredientname);

                for each(var ingredient:Object in recipe.ingredients)
                {
>>>>>>> 07cf26d7b2dcc1ba05157e327824196fc7876068
                    _listingredient.push(ingredient.ingredientname);
                    _listunit.push(ingredient.ingredientunit);
                    if(ingredient.ingredientvalue != null){
                        _listvalue.push(ingredient.ingredientvalue);
                        //trace("[Detail] [pusher]" + _listvalue);
                    }
                }
            }
        }
        listingredient.dataProvider = _listingredient;
        listingredient.itemRendererProperties.labelField = "text";
<<<<<<< HEAD
        listvalue.dataProvider = _listvalue;
        listvalue.itemRendererProperties.labelField = "text";
        /* listingredient.dataProvider = _listingredient;
         listvalue.dataProvider = _listvalue;
         listunit.dataProvider = _listunit;
         listvalue.itemRendererProperties.labelField = "text";
         listingredient.itemRendererProperties.labelField = "text";
         listvalue.itemToLabel(_listvalue);         */
=======
>>>>>>> 07cf26d7b2dcc1ba05157e327824196fc7876068
    }
}
}
