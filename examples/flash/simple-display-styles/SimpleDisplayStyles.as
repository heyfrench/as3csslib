package
{
	import flash.display.Sprite;
	
	import com.newgonzo.web.css.CSS;
	import com.newgonzo.web.css.CSSComputedStyle;
	import com.newgonzo.web.css.CSSContext;
	import com.newgonzo.web.css.views.DisplayCSSView;
	
	
	public class SimpleDisplayStyles extends Sprite
	{
		public function SimpleDisplayStyles()
		{
			var context:CSSContext = new CSSContext(new DisplayCSSView());
			var css:CSS = new CSS("Sprite { color: #F00;}", context);
			
			var sprite:Sprite = new Sprite();
			var style:CSSComputedStyle = css.style(sprite);
			
			
			trace("css: \n" + css);
			trace("css.toCSSString(): \n" + css.toCSSString());
			
			trace("sprite style: \n" + style);
			trace("sprite style.toCSSString(): \n" + style.toCSSString());
		}
	}
}