package com.newgonzo.web.css.values.css3
{
	import com.newgonzo.web.css.values.FloatValue;
	import com.newgonzo.web.css.values.IValue;
	import com.newgonzo.web.css.values.IdentValue;
	import com.newgonzo.web.css.values.InheritValue;
	
	import flash.utils.Dictionary;
	
	import org.w3c.css.sac.ILexicalUnit;
	import org.w3c.css.sac.LexicalUnitTypes;
	import org.w3c.dom.css.CSSPrimitiveValueTypes;
	import org.w3c.dom.css.ICSSValue;
	
	public class CSS3Values
	{
		protected static const map:Dictionary = new Dictionary();
		
		// font-weight values: see http://www.w3.org/TR/css3-fonts/#font-weight0
		public static const NUMBER_100:Number = 100;
		public static const NUMBER_100_VALUE:IValue = new FloatValue(CSSPrimitiveValueTypes.CSS_NUMBER, 100);
		map[NUMBER_100] = NUMBER_100_VALUE;
		
		public static const NUMBER_200:Number = 200;
		public static const NUMBER_200_VALUE:IValue = new FloatValue(CSSPrimitiveValueTypes.CSS_NUMBER, 200);
		map[NUMBER_200] = NUMBER_200_VALUE;
		
		public static const NUMBER_300:Number = 300;
		public static const NUMBER_300_VALUE:IValue = new FloatValue(CSSPrimitiveValueTypes.CSS_NUMBER, 300);
		map[NUMBER_300] = NUMBER_300_VALUE;
		
		public static const NUMBER_400:Number = 400;
		public static const NUMBER_400_VALUE:IValue = new FloatValue(CSSPrimitiveValueTypes.CSS_NUMBER, 400);
		map[NUMBER_400] = NUMBER_400_VALUE;
		
		public static const NUMBER_500:Number = 500;
		public static const NUMBER_500_VALUE:IValue = new FloatValue(CSSPrimitiveValueTypes.CSS_NUMBER, 500);
		map[NUMBER_500] = NUMBER_500_VALUE;
		
		public static const NUMBER_600:Number = 600;
		public static const NUMBER_600_VALUE:IValue = new FloatValue(CSSPrimitiveValueTypes.CSS_NUMBER, 600);
		map[NUMBER_600] = NUMBER_600_VALUE;
		
		public static const NUMBER_700:Number = 700;
		public static const NUMBER_700_VALUE:IValue = new FloatValue(CSSPrimitiveValueTypes.CSS_NUMBER, 700);
		map[NUMBER_700] = NUMBER_700_VALUE;
		
		public static const NUMBER_800:Number = 800;
		public static const NUMBER_800_VALUE:IValue = new FloatValue(CSSPrimitiveValueTypes.CSS_NUMBER, 800);
		map[NUMBER_800] = NUMBER_800_VALUE;
		
		public static const NUMBER_900:Number = 900;
		public static const NUMBER_900_VALUE:IValue = new FloatValue(CSSPrimitiveValueTypes.CSS_NUMBER, 900);
		map[NUMBER_900] = NUMBER_900_VALUE;
		
		// Used when converting "center" to a left/percentage value
		public static const PERCENTAGE_0:Number = 0;
		public static const PERCENTAGE_0_VALUE:IValue = new FloatValue(CSSPrimitiveValueTypes.CSS_PERCENTAGE, PERCENTAGE_0);
		map[PERCENTAGE_0] = PERCENTAGE_0_VALUE;
		
		public static const PERCENTAGE_50:Number = 50;
		public static const PERCENTAGE_50_VALUE:IValue = new FloatValue(CSSPrimitiveValueTypes.CSS_PERCENTAGE, PERCENTAGE_50);
		map[PERCENTAGE_50] = PERCENTAGE_50_VALUE;
		
		public static const ALL:String = "all";
		public static const ALL_VALUE:IValue = new IdentValue(ALL);
		map[ALL] = ALL_VALUE;
		
		public static const AUTO:String = "auto";
		public static const AUTO_VALUE:IValue = new IdentValue(AUTO);
		map[AUTO] = AUTO_VALUE;
		
		public static const BIDI_OVERRIDE:String = "bidi-override";
		public static const BIDI_OVERRIDE_VALUE:IValue = new IdentValue(BIDI_OVERRIDE);
		map[BIDI_OVERRIDE] = BIDI_OVERRIDE_VALUE;
		
		public static const BLINK:String = "blink";
		public static const BLINK_VALUE:IValue = new IdentValue(BLINK);
		map[BLINK] = BLINK_VALUE;
		
		public static const BLOCK:String = "block";
		public static const BLOCK_VALUE:IValue = new IdentValue(BLOCK);
		map[BLOCK] = BLOCK_VALUE;
		
		public static const BOLD:String = "bold";
		public static const BOLD_VALUE:IValue = new IdentValue(BOLD);
		map[BOLD] = BOLD_VALUE;
		
		public static const BOLDER:String = "bolder";
		public static const BOLDER_VALUE:IValue = new IdentValue(BOLDER);
		map[BOLDER] = BOLDER_VALUE;
		
		public static const BORDER_BOX:String = "border-box";
		public static const BORDER_BOX_VALUE:IValue = new IdentValue(BORDER_BOX);
		map[BORDER_BOX] = BORDER_BOX_VALUE;
		
		public static const BOTTOM:String = "bottom";
		public static const BOTTOM_VALUE:IValue = new IdentValue(BOTTOM);
		map[BOTTOM] = BOTTOM_VALUE;
		
		public static const CAPTION:String = "caption";
		public static const CAPTION_VALUE:IValue = new IdentValue(CAPTION);
		map[CAPTION] = CAPTION_VALUE;
		
		public static const CENTER:String = "center";
		public static const CENTER_VALUE:IValue = new IdentValue(CENTER);
		map[CENTER] = CENTER_VALUE;
		
		public static const COLLAPSE:String = "collapse";
		public static const COLLAPSE_VALUE:IValue = new IdentValue(COLLAPSE);
		map[COLLAPSE] = COLLAPSE_VALUE;
		
		public static const COMPACT:String = "compact";
		public static const COMPACT_VALUE:IValue = new IdentValue(COMPACT);
		map[COMPACT] = COMPACT_VALUE;
		
		public static const CONDENSED:String = "condensed";
		public static const CONDENSED_VALUE:IValue = new IdentValue(CONDENSED);
		map[CONDENSED] = CONDENSED_VALUE;
		
		public static const CONTAIN:String = "contain";
		public static const CONTAIN_VALUE:IValue = new IdentValue(CONTAIN);
		map[CONTAIN] = CONTAIN_VALUE;
		
		public static const CONTENT_BOX:String = "content-box";
		public static const CONTENT_BOX_VALUE:IValue = new IdentValue(CONTENT_BOX);
		map[CONTENT_BOX] = CONTENT_BOX_VALUE;
		
		public static const COVER:String = "cover";
		public static const COVER_VALUE:IValue = new IdentValue(COVER);
		map[COVER] = COVER_VALUE;
		
		public static const CURRENTCOLOR:String = "currentcolor";
		public static const CURRENTCOLOR_VALUE:IValue = new IdentValue(CURRENTCOLOR);
		map[CURRENTCOLOR] = CURRENTCOLOR_VALUE;
		
		public static const CURSIVE:String = "cursive";
		public static const CURSIVE_VALUE:IValue = new IdentValue(CURSIVE);
		map[CURSIVE] = CURSIVE_VALUE;
		
		public static const DASHED:String = "dashed";
		public static const DASHED_VALUE:IValue = new IdentValue(DASHED);
		map[DASHED] = DASHED_VALUE;
		
		public static const DOUBLE:String = "double";
		public static const DOUBLE_VALUE:IValue = new IdentValue(DOUBLE);
		map[DOUBLE] = DOUBLE_VALUE;
		
		public static const DOTTED:String = "dotted";
		public static const DOTTED_VALUE:IValue = new IdentValue(DOTTED);
		map[DOTTED] = DOTTED_VALUE;
		
		public static const FANTASY:String = "fantasy";
		public static const FANTASY_VALUE:IValue = new IdentValue(FANTASY);
		map[FANTASY] = FANTASY_VALUE;
		
		public static const FIXED:String = "fixed";
		public static const FIXED_VALUE:IValue = new IdentValue(FIXED);
		map[FIXED] = FIXED_VALUE;
		
		public static const GROOVE:String = "groove";
		public static const GROOVE_VALUE:IValue = new IdentValue(GROOVE);
		map[GROOVE] = GROOVE_VALUE;
		
		public static const HIDDEN:String = "hidden";
		public static const HIDDEN_VALUE:IValue = new IdentValue(HIDDEN);
		map[HIDDEN] = HIDDEN_VALUE;
		
		public static const ICON:String = "icon";
		public static const ICON_VALUE:IValue = new IdentValue(ICON);
		map[ICON] = ICON_VALUE;
		
		public static const INHERIT:String = "inherit";
		public static const INHERIT_VALUE:IValue = new InheritValue();
		map[INHERIT] = INHERIT_VALUE;
		
		public static const INSET:String = "inset";
		public static const INSET_VALUE:IValue = new IdentValue(INSET);
		map[INSET] = INSET_VALUE;
		
		public static const ITALIC:String = "italic";
		public static const ITALIC_VALUE:IValue = new IdentValue(ITALIC);
		map[ITALIC] = ITALIC_VALUE;
		
		public static const LARGE:String = "large";
		public static const LARGE_VALUE:IValue = new IdentValue(LARGE);
		map[LARGE] = LARGE_VALUE;
		
		public static const LARGER:String = "larger";
		public static const LARGER_VALUE:IValue = new IdentValue(LARGER);
		map[LARGER] = LARGER_VALUE;
		
		public static const LEFT:String = "left";
		public static const LEFT_VALUE:IValue = new IdentValue(LEFT);
		map[LEFT] = LEFT_VALUE;
		
		public static const LIGHTER:String = "lighter";
		public static const LIGHTER_VALUE:IValue = new IdentValue(LIGHTER);
		map[LIGHTER] = LIGHTER_VALUE;
		
		public static const LOCAL:String = "local";
		public static const LOCAL_VALUE:IValue = new IdentValue(LOCAL);
		map[LOCAL] = LOCAL_VALUE;
		
		public static const MEDIUM:String = "medium";
		public static const MEDIUM_VALUE:IValue = new IdentValue(MEDIUM);
		map[MEDIUM] = MEDIUM_VALUE;
		
		public static const MENU:String = "menu";
		public static const MENU_VALUE:IValue = new IdentValue(MENU);
		map[MENU] = MENU_VALUE;
		
		public static const MESSAGE_BOX:String = "message-box";
		public static const MESSAGE_BOX_VALUE:IValue = new IdentValue(MESSAGE_BOX);
		map[MESSAGE_BOX] = MESSAGE_BOX_VALUE;
		
		public static const MONOSPACE:String = "monospace";
		public static const MONOSPACE_VALUE:IValue = new IdentValue(MONOSPACE);
		map[MONOSPACE] = MONOSPACE_VALUE;
		
		public static const NONE:String = "none";
		public static const NONE_VALUE:IValue = new IdentValue(NONE);
		map[NONE] = NONE_VALUE;
		
		public static const NO_REPEAT:String = "no-repeat";
		public static const NO_REPEAT_VALUE:IValue = new IdentValue(NO_REPEAT);
		map[NO_REPEAT] = NO_REPEAT_VALUE;
		
		public static const NORMAL:String = "normal";
		public static const NORMAL_VALUE:IValue = new IdentValue(NORMAL);
		map[NORMAL] = NORMAL_VALUE;
		
		public static const OBLIQUE:String = "oblique";
		public static const OBLIQUE_VALUE:IValue = new IdentValue(OBLIQUE);
		map[OBLIQUE] = OBLIQUE_VALUE;
		
		public static const OUTSET:String = "outset";
		public static const OUTSET_VALUE:IValue = new IdentValue(OUTSET);
		map[OUTSET] = OUTSET_VALUE;
		
		public static const PADDING_BOX:String = "padding-box";
		public static const PADDING_BOX_VALUE:IValue = new IdentValue(PADDING_BOX);
		map[PADDING_BOX] = PADDING_BOX_VALUE;
		
		public static const REPEAT:String = "repeat";
		public static const REPEAT_VALUE:IValue = new IdentValue(REPEAT);
		map[REPEAT] = REPEAT_VALUE;
		
		public static const REPEAT_X:String = "repeat-x";
		public static const REPEAT_X_VALUE:IValue = new IdentValue(REPEAT_X);
		map[REPEAT_X] = REPEAT_X_VALUE;
		
		public static const REPEAT_Y:String = "repeat-y";
		public static const REPEAT_Y_VALUE:IValue = new IdentValue(REPEAT_Y);
		map[REPEAT_Y] = REPEAT_Y_VALUE;
		
		public static const RIDGE:String = "ridge";
		public static const RIDGE_VALUE:IValue = new IdentValue(RIDGE);
		map[RIDGE] = RIDGE_VALUE;
		
		public static const RIGHT:String = "right";
		public static const RIGHT_VALUE:IValue = new IdentValue(RIGHT);
		map[RIGHT] = RIGHT_VALUE;
		
		public static const ROUND:String = "round";
		public static const ROUND_VALUE:IValue = new IdentValue(ROUND);
		map[ROUND] = ROUND_VALUE;
		
		public static const SANS_SERIF:String = "sans-serif";
		public static const SANS_SERIF_VALUE:IValue = new IdentValue(SANS_SERIF);
		map[SANS_SERIF] = SANS_SERIF_VALUE;
		
		public static const SCROLL:String = "scroll";
		public static const SCROLL_VALUE:IValue = new IdentValue(SCROLL);
		map[SCROLL] = SCROLL_VALUE;
		
		public static const SERIF:String = "serif";
		public static const SERIF_VALUE:IValue = new IdentValue(SERIF);
		map[SERIF] = SERIF_VALUE;
		
		public static const SMALL:String = "small";
		public static const SMALL_VALUE:IValue = new IdentValue(SMALL);
		map[SMALL] = SMALL_VALUE;
		
		public static const SMALLER:String = "smaller";
		public static const SMALLER_VALUE:IValue = new IdentValue(SMALLER);
		map[SMALLER] = SMALLER_VALUE;
		
		public static const SMALL_CAPS:String = "small-caps";
		public static const SMALL_CAPS_VALUE:IValue = new IdentValue(SMALL_CAPS);
		map[SMALL_CAPS] = SMALL_CAPS_VALUE;
		
		public static const SMALL_CAPTION:String = "small-caption";
		public static const SMALL_CAPTION_VALUE:IValue = new IdentValue(SMALL_CAPTION);
		map[SMALL_CAPTION] = SMALL_CAPTION_VALUE;
		
		public static const SOLID:String = "solid";
		public static const SOLID_VALUE:IValue = new IdentValue(SOLID);
		map[SOLID] = SOLID_VALUE;
		
		public static const SPACE:String = "space";
		public static const SPACE_VALUE:IValue = new IdentValue(SPACE);
		map[SPACE] = SPACE_VALUE;
		
		public static const STATUS_BAR:String = "status-bar";
		public static const STATUS_BAR_VALUE:IValue = new IdentValue(STATUS_BAR);
		map[STATUS_BAR] = STATUS_BAR_VALUE;
		
		public static const THICK:String = "thick";
		public static const THICK_VALUE:IValue = new IdentValue(THICK);
		map[THICK] = THICK_VALUE;
		
		public static const THIN:String = "thin";
		public static const THIN_VALUE:IValue = new IdentValue(THIN);
		map[THIN] = THIN_VALUE;
		
		public static const TOP:String = "top";
		public static const TOP_VALUE:IValue = new IdentValue(TOP);
		map[TOP] = TOP_VALUE;
		
		public static const TRANSPARENT:String = "transparent";
		public static const TRANSPARENT_VALUE:IValue = new IdentValue(TRANSPARENT);
		map[TRANSPARENT] = TRANSPARENT_VALUE;
		
		public static const VISIBLE:String = "visible";
		public static const VISIBLE_VALUE:IValue = new IdentValue(VISIBLE);
		map[VISIBLE] = VISIBLE_VALUE;
		
		public static const X_LARGE:String = "x-large";
		public static const X_LARGE_VALUE:IValue = new IdentValue(X_LARGE);
		map[X_LARGE] = X_LARGE_VALUE;
		
		public static const X_SMALL:String = "x-small";
		public static const X_SMALL_VALUE:IValue = new IdentValue(X_SMALL);
		map[X_SMALL] = X_SMALL_VALUE;
		
		public static const XX_LARGE:String = "xx-large";
		public static const XX_LARGE_VALUE:IValue = new IdentValue(XX_LARGE);
		map[XX_LARGE] = XX_LARGE_VALUE;

		public static const XX_SMALL:String = "xx-small";
		public static const XX_SMALL_VALUE:IValue = new IdentValue(XX_SMALL);
		map[XX_SMALL] = XX_SMALL_VALUE;
		
		public static const ZERO:Number = 0;
		public static const ZERO_VALUE:IValue = new FloatValue(CSSPrimitiveValueTypes.CSS_NUMBER, 0);
		map[ZERO] = ZERO_VALUE;
		
		public static function getIdentifier(ident:String):ICSSValue
		{
			return map[ident] as ICSSValue;
		}
	}
}