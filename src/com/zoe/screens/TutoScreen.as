package com.zoe.screens
{
	import com.zoe.objects.FBUserFactory;
	import com.zoe.objects.Partie;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.Color;
	
	[Event(name="complete",type="starling.events.Event")]

	public class TutoScreen extends Screen
	{
		public var partie:com.zoe.objects.Partie;
		private var _backButton:Button;
		private var _lamap:Image;
		private var _lelogo:Image;
		private var _lavion:Image;
		private var _lombre:Image;
		private var _label1:Label;
		private var _label2:Label;
		private var _label3:Label;
		private var _label4:Label;
		private var _label5:Label;
		private var _btngo:Button;
				
		private var _title:Image;
		private var _text:Label;
		private var _loader:Loader;
		
		public function TutoScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("tutoscreeninitialize");
			var q:Quad=new Quad(stage.width,stage.height,Color.BLACK);
			addChild(q);
			this._backButton = new Button();
			this._backButton.label = "retour";
			_backButton.nameList.add(ZoeMobileTheme.BOUTON_BACK);
			this._backButton.addEventListener(starling.events.Event.TRIGGERED, backButton_triggeredHandler);
			this.backButtonHandler = this.onBackButton;			
			addChild(_backButton);
			
			// map
			_lamap=new Image(Root.assets.getTexture("map"));
			_lelogo=new Image(Root.assets.getTexture("logohome"));
			_lavion=new Image(Root.assets.getTexture("avion"));
			_lombre=new Image(Root.assets.getTexture("ombre"));
			_lombre.pivotX=_lombre.width/2;
			_lombre.pivotY=_lombre.height/2;
			_label1=new Label();
			_label1.text="\nDécouvrez en 2 minutes comment RueCentrale va vous faire faire pleins d'économies !";
			_label1.nameList.add(ZoeMobileTheme.TUTOLABEL);
			_label1.width=300;
			_btngo=new Button();
			_btngo.nameList.add(ZoeMobileTheme.TUTOBTNORANGE);
			_btngo.label="let's go !";
			_btngo.addEventListener(starling.events.Event.TRIGGERED, backButton_triggeredHandler);

			addChild(_lamap);
			addChild(_lombre);
			addChild(_lelogo);
			addChild(_lavion);
			addChild(_label1);
			addChild(_btngo);
			
			Starling.juggler.delayCall(startanim, 0.5);
//			trace(stage.stageWidth+" "+stage.stageHeight+" "+ stage.fullScreenWidth+" "+stage.fullScreenHeight);

			
/*			// This will hold the API player instance once it is initialized.
			var player:Object;
			
			_loader= new Loader();
			_loader.contentLoaderInfo.addEventListener(flash.events.Event.INIT, onLoaderInit);
			_loader.load(new URLRequest("http://www.youtube.com/apiplayer?version=3"));
*/			

//			return;
//			navigateToURL(new URLRequest(com.zoe.objects.FBUserFactory.getUser().prefix+"/tuto"));
			return;
			var myWebView:StageWebView= new StageWebView();
			myWebView.stage = Starling.current.nativeStage;
			//			myWebView.viewPort = new Rectangle(0,80,Starling.current.nativeStage.stageWidth,Starling.current.nativeStage.stageHeight-80);
			myWebView.viewPort = new Rectangle(0,80,Starling.current.nativeStage.stageWidth-20,Starling.current.nativeStage.stageHeight-100);
//			myWebView.loadURL(FBUserFactory.getUser().prefix+ "/ebuzzmob/idback/"+partie.idback);
		//	myWebView.loadURL("http://www.youtube.com/watch?v=bRgR3LsF_ow");// "http://www.youtube.com/embed/bRgR3LsF_ow");
//			myWebView.loadString("<iframe width='320' height='240' src='http://www.youtube.com/embed/qfhDqIVUpSg' frameborder='0' allowfullscreen></iframe>");
			myWebView.loadURL(com.zoe.objects.FBUserFactory.getUser().prefix+"/tuto");
			
		}
		private function startanim():void{
			var ju:Tween=new Tween(_lelogo,0.7,Transitions.EASE_OUT_BOUNCE);
			ju.moveTo(_lelogo.x,50);
			
			var juombre:Tween=new Tween(_lombre,0.7,Transitions.EASE_OUT_BOUNCE);
			juombre.scaleTo(1);
			
			var juav:Tween=new Tween(_lavion,0.7,Transitions.EASE_OUT_BOUNCE);
			juav.moveTo((this.actualWidth-_lavion.width)/2,320);

			var jula:Tween=new Tween(_label1,0.7,Transitions.EASE_OUT_BOUNCE);
			jula.moveTo((this.actualWidth-_label1.width)/2,180);

			var jubt:Tween=new Tween(_btngo,0.7,Transitions.EASE_OUT_BOUNCE);
			jubt.moveTo(220,420);

			ju.nextTween=jula;
			jula.nextTween=juav;
			juav.nextTween=jubt;
			
			Starling.juggler.add(ju);
			Starling.juggler.add(juombre);

		}
		
		private function onTouch(e:TouchEvent):void
		{			
			var touch:Touch= e.getTouch(stage, TouchPhase.BEGAN);
			if (touch == null) return;
			trace("click");			
		}
		private function onTouch1(e:TouchEvent):void
		{
			var touch:Touch= e.getTouch(stage, TouchPhase.BEGAN);
			if (touch == null) return;
			trace("click");	
		}
				
		override protected function draw():void
		{
			trace("draw message");
			_backButton.x=5;
			_backButton.y=5;
			
			_lamap.x=(this.actualWidth-_lamap.width)/2;
			_lamap.y=100;
			_lelogo.x=(this.actualWidth-_lelogo.width)/2;
			_lelogo.y=-120;//50;
			_lombre.x=_lelogo.x+_lombre.width/2+70;
			
			_lombre.scaleX=0;
			_lombre.scaleY=0;
			_lombre.y=155+_lombre.height/2;
			_label1.x=320;//(this.actualWidth-_label1.width)/2;
			_label1.y=180;
//			_label1.scaleX=_label1.scaleY=0;
			_lavion.x=-200;//(this.actualWidth-_lavion.width)/2;
			_lavion.y=320;//480;//320;

			
/*			addChild(_label2);
			addChild(_label3);
			addChild(_label4);
			addChild(_label5);
			
*/			
			_btngo.y=420;
			_btngo.x=320;
		}
		
		private function onBackButton():void
		{
			this.dispatchEventWith("complete");
		}
		
		private function backButton_triggeredHandler(event:starling.events.Event):void
		{
			this.onBackButton();
		}
		
		
		
		private function onLoaderInit(event:flash.events.Event):void {
			//_loader.stage=Starling.current.nativeStage;
			Starling.current.nativeOverlay.addChild(_loader);
			_loader.x=20;
			_loader.y=20;
			_loader.content.addEventListener("onReady", onPlayerReady);
			_loader.content.addEventListener("onError", onPlayerError);
			_loader.content.addEventListener("onStateChange", onPlayerStateChange);
			_loader.content.addEventListener("onPlaybackQualityChange", 
				onVideoPlaybackQualityChange);
		}
		
		private function onPlayerReady(event:flash.events.Event):void {
			// Event.data contains the event parameter, which is the Player API ID 
			trace("player ready:", Object(event).data);
			
			// Once this event has been dispatched by the player, we can use
			// cueVideoById, loadVideoById, cueVideoByUrl and loadVideoByUrl
			// to load a particular YouTube video.
			var player = _loader.content;
			var loaderContext:LoaderContext = new LoaderContext(false,new ApplicationDomain());
			//			LoaderContext(false, new ApplicationDomain())
			player.cueVideoById("qfhDqIVUpSg",0);
			//player.loadVideoByUrl("http://www.youtube.com/watch?v=bRgR3LsF_ow",loaderContext);
			// Set appropriate player dimensions for your application
			player.setSize(320, 360);
		}
		
		private function onPlayerError(event:flash.events.Event):void {
			// Event.data contains the event parameter, which is the error code
			trace("player error:", Object(event).data);
		}
		
		private function onPlayerStateChange(event:flash.events.Event):void {
			// Event.data contains the event parameter, which is the new player state
			trace("player state:", Object(event).data);
		}
		
		private function onVideoPlaybackQualityChange(event:flash.events.Event):void {
			// Event.data contains the event parameter, which is the new video quality
			trace("video quality:", Object(event).data);
		}		
		
		
		
		
	}
}