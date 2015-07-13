package selectors.tests
{
	import com.newgonzo.web.css.CSS;
	import com.newgonzo.web.css.CSSComputedStyle;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	
	public class EscapedSelectorTest
	{
		[Test(description="Tests escaped class selector")]
		public function testEscapedClassSelector():void 
		{
			var css:CSS;
			var style:CSSComputedStyle;
			
			css = new CSS("\.notaclass{color: #000}");
			style = css.style(<xml class="isnotaclass"/>);
			assertThat(style.length, equalTo(0));
			
			css = new CSS(".isaclass{color: #000}");
			style = css.style(<xml class="isaclass"/>);
			assertThat(style.length, equalTo(1));
		}
		
		[Test(description="Tests escaped ID selector")]
		public function testEscapedIDSelector():void 
		{
			var css:CSS;
			var style:CSSComputedStyle;
			
			css = new CSS("#isanid{color: #000}");
			style = css.style(<xml id="isanid"/>);
			assertThat(style.length, equalTo(1));
			
			css = new CSS("\#notanid{color: #000}");
			style = css.style(<xml id="notanid"/>);
			assertThat(style.length, equalTo(0));
		}
	}
}