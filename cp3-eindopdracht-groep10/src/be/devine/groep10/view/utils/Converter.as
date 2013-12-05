package be.devine.groep10.view.utils {
public class Converter {



    //Converter.functionNameOfWhatYouWantToConvert(NumberToConvert)
    /**WEIGHT**/
    public static function kilogramsToPounds(kilograms:Number):Number {
        return kilograms * 2.20462262;
     }

    public static function kilogramsToStone(kilograms:Number):Number {
        return kilograms * 0.157473044;
    }

    public static function poundsToKilograms(pounds:Number):Number {
        return pounds * 0.45359237;
    }

    public static function poundsToStone(pounds:Number):Number {
        return pounds * 0.0714285714;
    }

    public static function stoneToKilograms(stone:Number):Number {
        return stone * 6.35029318;
    }

    public static function gramsToOunces(grams:Number):Number {
        return grams * 0.0352739619;
    }

    public static function ouncesToGrams(ounces:Number):Number {
        return ounces * 28.3495231;
    }

    /**TEMPERATURE**/
    public static function fahrenheitToCelsius(degrees:Number):Number {
        return (degrees - 32) / 1.8;
    }

    public static function fahrenheitToKelvin(degrees:Number):Number {
        return (degrees + 459.67) / 1.8;
    }

    public static function celsiusToFahrenheit(degrees:Number):Number {
        return (degrees * 1.8) + 32;
    }

    public static function celsiusToKelvin(degrees:Number):Number {
        return degrees + 273.15;
    }

    public static function kelvinToCelsius(degrees:Number):Number {
        return degrees - 273.15;
    }

    public static function kelvinToFahrenheit(degrees:Number):Number {
        return (degrees * 1.8) - 459.67;
    }

    /**VOLUME**/
    public static function litersToGallons(liters:Number):Number {
        return liters * 0.264172052;
    }

    public static function gallonsToLiters(gallons:Number):Number {
        return gallons * 3.78541178;
    }

    public static function tablespoonToMilliliters(tablespoon:Number):Number {
        return tablespoon * 14.79;
    }

    public static function millilitersToTablespoon(millilitres:Number):Number {
        return millilitres * 0.067628;
    }

    public static function quartsToMilliliter(quarts:Number):Number{
        return quarts * 946.353;
    }

    public static function millilitersToQuarts(milliliters:Number):Number {
        return milliliters * 0.00105669;
    }
    public static function pintsToMilliliter(pints:Number):Number {
        return pints * 473.176;
    }

    public static function millilitersToPints(milliliters:Number):Number {
       return milliliters * 0.00211338;
    }
    public static function cupsToMilliter(cups:Number):Number {
       return cups*236.588;
    }

    public static function milliliterToCups(milliliters:Number):Number {
        return milliliters * 0.00422675;
    }
    public static function ozToMilliter(oz:Number):Number {
        return oz * 29.5735;
    }

    public static function milliliterToOz(milliliters:Number):Number {
        return milliliters * 0.033814;
    }

    public static function teaspoonToMillititers(teaspoon:Number):Number {
        return teaspoon * 4.92892;
    }

    public static function millilitersToTeaspoon(milliliters:Number):Number {
        return milliliters * 0.202884;
    }

}
}
