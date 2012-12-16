package 
{
	import org.flixel.FlxGame;
	
	//Set the background color and dimension of the screen
	[SWF(width = "800", height = "600", backgroundColor = "#000000")]
	
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	public class Main extends FlxGame 
	{
		
		public function Main():void 
		{
			//Set the size of the map and go to the Playstate
			super(800, 600, Title, 1, 60, 30, true);
		}
	}
}