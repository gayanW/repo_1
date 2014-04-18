package
{
    public class EmbeddedAssets
    {
        /** ATTENTION: Naming conventions!
         *  
         *  - Classes for embedded IMAGES should have the exact same name as the file,
         *    without extension. This is required so that references from XMLs (atlas, bitmap font)
         *    won't break.
         *    
         *  - Atlas and Font XML files can have an arbitrary name, since they are never
         *    referenced by file name.
         * 
         */
        
        // Texture Atlas
        
        [Embed(source="../assets/textures/1x/atlas.xml", mimeType="application/octet-stream")]
        public static const atlas_xml:Class;
        
        [Embed(source="../assets/textures/1x/atlas.png")]
        public static const atlas:Class;

        // Compressed textures
        
        [Embed(source = "../assets/textures/1x/compressed_texture.atf", mimeType="application/octet-stream")]
        public static const compressed_texture:Class;
        
        // Bitmap Fonts	------------------------------------------------------------------------
        
        [Embed(source="../assets/fonts/1x/desyrel.fnt", mimeType="application/octet-stream")]
        public static const desyrel_fnt:Class;
        
        [Embed(source = "../assets/fonts/1x/desyrel.png")]
        public static const desyrel:Class;
        
        // Sounds
        
        [Embed(source="../assets/audio/wing_flap.mp3")]
        public static const wing_flap:Class;
		
		// Level Data (XML)
		[Embed(source = "./maps/level_0.oel", mimeType="application/octet-stream")]
		public static const level_0:Class;
		
		// Game Entities
		[Embed(source = "../assets/textures/1x/entities/enemy.png")]
		public static const enemy:Class;
		
		[Embed(source = "../assets/textures/1x/entities/dynamic_box.png")]
		public static const dynamic_box:Class;
		
		// Map Textures
		[Embed(source = "../assets/textures/1x/map_data/sky.JPG")]
		public static const sky:Class;
		
		[Embed(source = "../assets/textures/1x/map_data/map_0.png")]
		public static const map_0:Class;
		
		[Embed(source = "../assets/textures/1x/effects/cloud_effect.png")]
		public static const cloud_effect:Class;
    }
}