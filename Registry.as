package  
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Waveon Foxdale
	 */
	public class Registry 
	{
		//declare variable for the player's bullets
		public static var Pbullets:FlxGroup;
		
		public function Registry() 
		{
		}
		
		public static function destroy():void
		{
			//set the Registry objects to null so they're destroyed properly
			Pbullets = null;
		}
	}
}