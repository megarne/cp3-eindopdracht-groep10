/**
 * Created with IntelliJ IDEA.
 * User: laurens
 * Date: 11/12/13
 * Time: 20:24
 * To change this template use File | Settings | File Templates.
 */
package be.devine.groep10.factory
{
import be.devine.groep10.vo.RecipesVO;

public class RecipesVOFactory
{
    public static function createRecipesVOFromObject(recipe:Object):RecipesVO
    {
        var recipesVO:RecipesVO = new RecipesVO();
        recipesVO.name = recipe.name;
        recipesVO.ingredients = recipe.ingredients;
        recipesVO.value = recipe.value;
        recipesVO.unit = recipe.unit;
        return recipesVO;
    }
}
}
