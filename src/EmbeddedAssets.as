package
{
	public class EmbeddedAssets
	{
		[Embed(source="resources/spritesheet.xml", mimeType="application/octet-stream")]
		public static const spritesheetXML:Class;
		
		[Embed(source="resources/spritesheet.png")]
		public static const spritesheet:Class;
		
		public function EmbeddedAssets()
		{
		}
	}
}