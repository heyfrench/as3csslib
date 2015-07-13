package
{
	import flash.display.Sprite;
	
	import com.newgonzo.web.css.CSS;
	import com.newgonzo.web.css.CSSComputedStyle;
	import com.newgonzo.web.css.CSS3Context;
	
	
	public class SimpleXMLStyles extends Sprite
	{
		public function SimpleXMLStyles()
		{
			var source:String = <css>
			<![CDATA[
			
			xml { 
				color: rgb(30, 30, 30);
			} 
			
			child {
				color: hsl(120, 50%, 50%);
			}
			
			[id] {
				color: #FFF;	
			}
			
			xml > * {
				padding: 10px 30px 10px;
			}
			
			xml * {
				margin: 10px;
			}
			
			#test-id {
				border: 1px solid rgba(120, 120, 120, 50%);
			}
			
			.test-class {
				font: 20px/1em bold Arial, Comic Sans, sans-serif;
			}
			
			child:hover {
				color: #F00;
			}
			
			]]>
			</css>.text().toString();
			
			
			var css:CSS = new CSS(source, new CSS3Context());
			var xml:XML = 
				<xml>
					<child>
						<grandchild class="test-class"/>
					</child>
					<sibling id="test-id"/>
				</xml>;
			
			
				
			var style:CSSComputedStyle;
			
			
			trace("css: \n" + css);
			trace("css.toCSSString(): \n" + css.toCSSString());
			
			
			style = css.style(xml);
			
			trace("xml style: \n" + style);
			trace("xml style.toCSSString(): \n" + style.toCSSString());
			
			
			style = css.style(xml.child);
			
			trace("xml.child style: \n" + style);
			trace("xml.child style.toCSSString(): \n" + style.toCSSString());
			
			
			style = css.style(xml.sibling);
			
			trace("xml.sibling style: \n" + style);
			trace("xml.sibling style.toCSSString(): \n" + style.toCSSString());
			
			
			style = css.style(xml.child.grandchild);
			
			trace("xml.child.grandchild style: \n" + style);
			trace("xml.child.grandchild style.toCSSString(): \n" + style.toCSSString());
		}
	}
}