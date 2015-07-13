package com.newgonzo.web.css.rules
{
	import com.newgonzo.web.css.ICSSDocument;
	import com.newgonzo.web.css.ICSSDocumentNode;
	
	import org.w3c.css.sac.ISACMediaList;
	import org.w3c.dom.css.CSSRuleTypes;
	import org.w3c.dom.css.ICSSImportRule;
	import org.w3c.dom.css.ICSSStyleSheet;
	import org.w3c.dom.stylesheets.IMediaList;
	
	public class ImportRule extends CSSRule implements ICSSImportRule
	{
		protected var importUri:String;
		protected var mediaList:IMediaList;
		
		protected var importedStyleSheet:ICSSStyleSheet;
		
		public function ImportRule(parentStyleSheet:ICSSStyleSheet, uri:String, media:ISACMediaList = null)
		{
			super(parentStyleSheet);
			
			importUri = uri;
			mediaList = media as IMediaList;
			
			if(parentStyleSheet is ICSSDocumentNode)
			{
				// TODO: FIXME: There's probably a better way to do this
				var document:ICSSDocument = (parentStyleSheet as ICSSDocumentNode).document;
				importedStyleSheet = document.context.factory.createStyleSheet(document, mediaList, this);
			}
		}
		
		override public function get type():uint
		{
			return CSSRuleTypes.IMPORT_RULE;
		}
		
		public function get href():String
		{
			return importUri;
		}
		
		public function get media():IMediaList
		{
			return mediaList;
		}
		
		public function get styleSheet():ICSSStyleSheet
		{
			return importedStyleSheet;
		}
		
		override public function get cssText():String
		{
			var css:String = "@import url(\"" + importUri + "\")";
			
			if(mediaList && mediaList.length)
			{
				css += " " + (mediaList as Array).join(", ");
			}
			
			return css + ";";
		}
	}
}