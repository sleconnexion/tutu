package com.zoe.screens
{
	import com.noomiz.objects.FBUserFactory;
	import com.noomiz.objects.Partie;
	import com.zoe.objects.Partie;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.JPEGEncoderOptions;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.LocationChangeEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.StageWebView;
	import flash.media.Video;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.skins.StandardIcons;
	import feathers.themes.SopranoMobileTheme;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.animation.Juggler;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;
	
	[Event(name="testscreen",type="starling.events.Event")]

	public class HomeScreen extends Screen
	{
		public static const HOMEJEU_SCREEN:String = "homejeuscreen";
		public static const MONALBUM_SCREEN:String = "monalbumscreen";
		public static const ECHANGER_SCREEN:String = "echangerscreen";
		public static const LOT_SCREEN:String = "lotscreen";
		public static const SETTINGS_SCREEN:String = "settingsscreen";


		public var partie:com.zoe.objects.Partie;
		public var video:Video;
		public function HomeScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("homescreen initialize");
//			trace(stage.stageWidth+" "+stage.stageHeight+" "+ stage.fullScreenWidth+" "+stage.fullScreenHeight);

			var q:Quad=new Quad(100,20,Color.RED);
			addChild(q);
			q.addEventListener(TouchEvent.TOUCH,onTouch);
				
			var q1:Quad=new Quad(100,20,Color.BLUE);
			addChild(q1);
			q1.x=120;
			q1.addEventListener(TouchEvent.TOUCH,onTouch1);				
			
		}
		
		
		private function savePicToServer(bmpData:BitmapData):void
		{

			
//			var jpgEncoder:JPGEncoder = new JPGEncoder(85);
			var jpgStream:ByteArray= bmpData.encode(new Rectangle(0,0,320,480),new JPEGEncoderOptions());
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener (flash.events.Event.COMPLETE, loaddone);			

			var header:URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
//			var header2:URLRequestHeader = new URLRequestHeader("Content-type", "application/x-www-form-urlencoded");
			
			var request:URLRequest = new URLRequest("http://www9.noomiz.com/projet/upload/fn/x1");
			request.requestHeaders.push(header);
//		request.requestHeaders.push(header2);
			request.method = URLRequestMethod.POST;
		
			var variables:URLVariables = new URLVariables();
			variables.name = "imgName";
			variables.uploadedfile="toto.jpg";
			variables.type = ".jpg";
			variables.image = jpgStream;
			
		//	request.data = variables;
						
			request.data = jpgStream;
			trace("on envoie");
			loader.load(request);
			trace("envoyé");
		}
		public function loaddone(event:flash.events.Event):void {
			trace("done");
			var loader:URLLoader = URLLoader(event.target);			
			trace(loader.data);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			
			
			var touch:Touch= e.getTouch(stage, TouchPhase.BEGAN);
			if (touch == null) return;
			trace("click");			
			var bitmapData: BitmapData= new BitmapData(320, 480);
			bitmapData.draw(video);

			savePicToServer(bitmapData);
//			var imgBitmap:Bitmap=new Bitmap(bitmapData);
//			Starling.current.nativeOverlay.addChild(imgBitmap);
//			addChild(imgBitmap);
			
		return;			
			var timer:Timer= new Timer(15, 30);
			timer.addEventListener(TimerEvent.TIMER, blah1);
			timer.start();

//			partie.carto.viewPort=new Rectangle(30,30,200,200);
		}
		private function onTouch1(e:TouchEvent):void
		{
			var touch:Touch= e.getTouch(stage, TouchPhase.BEGAN);
			if (touch == null) return;
			trace("click");			
			var timer:Timer= new Timer(15, 30);
			timer.addEventListener(TimerEvent.TIMER, blah);
			timer.start();
		}
		
		
		// questions loaded
		override protected function draw():void
		{
			trace("draw home");
			setTimeout(afficher,200);
			
			
		}
		private function afficher():void{
			video= new Video(320, 480);
			var camara:Camera = Camera.getCamera();
			camara.setMode(320, 480, 30);
			video.attachCamera(camara);
			video.x=0;
			video.y=30;
			Starling.current.nativeOverlay.addChild(video);
			//camara.
			//addChild(video);
//			partie.carto.viewPort=new Rectangle(20,0,320,480);
			
		}
		private function blah(e:TimerEvent):void{
			
			
			
			trace("Times Fired: " + e.currentTarget.currentCount);			
			var dep=partie.carto.viewPort.left;
			partie.carto.viewPort=new Rectangle(dep+ 10,0,320,480);
		}
		private function blah1(e:TimerEvent):void{
			trace("Times Fired: " + e.currentTarget.currentCount);
			var dep=partie.carto.viewPort.left;
			partie.carto.viewPort=new Rectangle(dep-10,0,320,480);
		}
		private function onError(e):void{
			trace("erreur");
			trace (e);
		}
			}
}