package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	public class Button extends FlxGroup
	{
		//source to the button image
		[Embed(source = "images/menu_button.png")] private var btnImg:Class;
		
		//variables to store the button image and text
		private var buttonImg:FlxSprite, buttonTxt:FlxText;
		
		public function Button(X:int, Y:int, text:String) 
		{
			//create the button image
			this.buttonImg = new FlxSprite(X, Y);
			this.buttonImg.loadGraphic(btnImg, false, false, 169, 56);
			add(this.buttonImg);
			
			//create the button text
			this.buttonTxt = new FlxText(X, Y + 15, this.buttonImg.width, text);
			this.buttonTxt.setFormat(null, 20, 0xffffffff, "center");
			add(this.buttonTxt);
		}
		
		//getters
		public function get buttonX():int { return this.buttonImg.x; }
		public function get buttonY():int { return this.buttonImg.y; }
		public function get buttonW():int { return this.buttonImg.width; }
		public function get buttonH():int { return this.buttonImg.height; }
		
	}

}