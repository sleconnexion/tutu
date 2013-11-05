package
{
	import flash.crypto.generateRandomBytes;
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.system.Security;
	import flash.utils.ByteArray;
	
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import starling.utils.formatString;
	
	[SWF(frameRate="30", backgroundColor="#000")]
	public class projetzoemobile extends Sprite
	{
		[Embed(	source="/../assets/fonts/Pacifico.ttf",
				embedAsCFF="false", fontFamily="Pacifico",
				fontName="Pacifico")]
		protected static const CPX_FONTPACIFICO:Class;
		
		[Embed(source="/../assets/fonts/Arial.ttf", embedAsCFF="false", fontFamily="Arial")]
		private static const Arial:Class;
		
		[Embed(source="/../assets/fonts/Arialbd.ttf", embedAsCFF="false", fontFamily="Arial", fontWeight="bold")]
		private static const ArialBold:Class;
		
		[Embed(source="/../assets/fonts/Arial.ttf", embedAsCFF="false", fontFamily="Arial", unicodeRange = "U+0020-U+007e")]
		private static const ArialJustLatin:Class;
		
		// Startup image for SD screens
		[Embed(source="/../system/startup.jpg")]
		private static var Background:Class;
		
		// Startup image for HD screens
		[Embed(source="/../system/startupHD.jpg")]
		private static var BackgroundHD:Class;
		
		private var mStarling:Starling;
		
		public function projetzoemobile()
		{
			// set general properties
			//			Security.allowDomain("www.youtube.com");
			try {Security.allowDomain("*");}catch (e) { };
			//			Security.allowInsecureDomain("*");
			var z:ByteArray=flash.crypto.generateRandomBytes(10);
			
			var stageWidth:int   = 320;//640;//320;//Constants.STAGE_WIDTH;
			var stageHeight:int  = 480;//960;//480;//Constants.STAGE_HEIGHT;
			var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
			
			Starling.multitouchEnabled = true;  // useful on mobile devices
			Starling.handleLostContext = !iOS;  // not necessary on iOS. Saves a lot of memory!
			
			// create a suitable viewport for the screen size
			// 
			// we develop the game in a *fixed* coordinate system of 320x480; the game might 
			// then run on a device with a different resolution; for that case, we zoom the 
			// viewPort to the optimal size for any display and load the optimal textures.
			
			var viewPort:Rectangle = RectangleUtil.fit(
				new Rectangle(0, 0, stageWidth, stageHeight), 
				new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
				ScaleMode.SHOW_ALL);
			
			var scaleFactor:int = viewPort.width < 480 ? 1 : 2; // midway between 320 and 640
			var appDir:File = File.applicationDirectory;
			var assets:AssetManager = new AssetManager(scaleFactor);
			
			assets.verbose = Capabilities.isDebugger;
			assets.enqueue(
				appDir.resolvePath(formatString("fonts/{0}x", scaleFactor)),
				appDir.resolvePath(formatString("textures/{0}x", scaleFactor))
			);
			
			// While Stage3D is initializing, the screen will be blank. To avoid any flickering, 
			// we display a startup image now and remove it below, when Starling is ready to go.
			// This is especially useful on iOS, where "Default.png" (or a variant) is displayed
			// during Startup. You can create an absolute seamless startup that way.
			// 
			// These are the only embedded graphics in this app. We can't load them from disk,
			// because that can only be done asynchronously (resulting in a short flicker).
			// 
			// Note that we cannot embed "Default.png" (or its siblings), because any embedded
			// files will vanish from the application package, and those are picked up by the OS!
			
			var background:Bitmap = scaleFactor == 1 ? new Background() : new BackgroundHD();
			Background = BackgroundHD = null; // no longer needed!
			
			background.x = viewPort.x;
			background.y = viewPort.y;
			background.width  = viewPort.width;
			background.height = viewPort.height;
			background.smoothing = true;
			addChild(background);
			
			// launch Starling
			
			
			// on check si internet dispo
			/*var XMLPath:String = "testXML.xml";			
			var icXML:XML = new XML();
			icXML.ignoreWhite = true;
			
			icXML.onLoad = function(success):Void{
			if(success){
			//User has Internet Connection
			}else{
			//No Connection
			}
			}
			
			icXML.load(XMLPath);
			*/
			
			mStarling = new Starling(Root, stage, viewPort);
			mStarling.stage.stageWidth  = stageWidth;  // <- same size on all devices! 320
			mStarling.stage.stageHeight = stageHeight; // <- same size on all devices! 480
			mStarling.simulateMultitouch  = false;
			mStarling.enableErrorChecking = Capabilities.isDebugger;
			
			mStarling.addEventListener(starling.events.Event.ROOT_CREATED, 
				function onRootCreated(event:Object, app:Root):void
				{
					mStarling.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
					removeChild(background);
					
					var bgTexture:Texture = Texture.fromBitmap(background, false, false, scaleFactor);
					app.start(bgTexture, assets);
					mStarling.start();
				});
			
			trace("stageWidth ::"+stageWidth+" stageHeight:"+stageHeight);
			trace("stage.fullScreenWidth :"+stage.fullScreenWidth+" stage.fullScreenHeight:"+stage.fullScreenHeight);
			trace("viewPort=> w:"+viewPort.width+" h:"+viewPort.height+" x:"+viewPort.x+" y:"+viewPort.y);
			trace("Starling.current.contentScaleFactor :"+Starling.current.contentScaleFactor);
			
			trace("nativestage.fullScreenWidth :"+Starling.current.nativeStage.fullScreenWidth+"nativestage.fullScreenHeight :"+Starling.current.nativeStage.fullScreenHeight);
			
			
			// When the game becomes inactive, we pause Starling; otherwise, the enter frame event
			// would report a very long 'passedTime' when the app is reactivated. 
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.ACTIVATE, function (e:*):void { mStarling.start(); });
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.DEACTIVATE, function (e:*):void { mStarling.stop(); });
		}
		
	}
}