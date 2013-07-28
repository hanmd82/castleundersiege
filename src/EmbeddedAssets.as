package
{
	public class EmbeddedAssets
	{
		[Embed(source="resources/spritesheet.xml", mimeType="application/octet-stream")]
		public static const spritesheetXML:Class;
		
		[Embed(source="resources/spritesheet.png")]
		public static const spritesheet:Class;
		
		[Embed(source="resources/font04b03.fnt", mimeType="application/octet-stream")]
		public static const font04b03XML:Class;
		
		[Embed(source="resources/font04b03_0.png")]
		public static const font04b03_0:Class;
		
		public function EmbeddedAssets()
		{
		}
	}
}