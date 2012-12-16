package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	public class Background extends FlxSprite
	{
		//set the source of the background image
		[Embed(source = "images/background.png")] private var bg:Class;
		
		public function Background(Y:int) 
		{
			//place the image on the given x position
			super(0, Y);
			//load the background image
			loadGraphic(bg, false, false, 800, 600);
			
			//set the scrolling speed
			this.velocity.y = 75;
		}
		
		override public function update():void
		{
			super.update();
			
			if (this.y >= FlxG.height)
			{
				//Place it on the right side of the screen when it moves off the left side of screen
				this.y = -this.height + 5;
			}
		}
		
	}

}