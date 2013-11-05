package com.zoe.screens
{
	import com.zoe.composants.Cartomenu;
	import com.zoe.composants.Filtremenu;
	import com.zoe.composants.Positionmarker;
	import com.zoe.composants.Rcloader;
	import com.zoe.objects.FBUserFactory;
	import com.zoe.objects.Partie;
	
	import flash.display.BitmapData;
	import flash.events.ErrorEvent;
	import flash.events.GeolocationEvent;
	import flash.events.LocationChangeEvent;
	import flash.events.StatusEvent;
	import flash.geom.Rectangle;
	import flash.sensors.Geolocation;
	import flash.utils.setTimeout;
	
	import feathers.controls.Screen;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.utils.Color;
	
	[Event(name="fichecoscreen",type="starling.events.Event")]
	[Event(name="mesmessagesscreen",type="starling.events.Event")]

	public class HomeScreen extends Screen
	{
		public var partie:com.zoe.objects.Partie;
		
		private var menug:Cartomenu;
		private var menud:Filtremenu;
		private var zz:Image;
		private var sp:starling.display.Sprite;
		private var geo:Geolocation;
		private var rcl:Rcloader;
		public function HomeScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("homescreen initialize=> type data"+Root.partie.typedata);
			trace("Starling.current.nativeStage.fullScreenWidth: "+Starling.current.nativeStage.fullScreenWidth+" Starling.current.nativeStage.fullScreenHeight: "+Starling.current.nativeStage.fullScreenHeight);
			menug=new Cartomenu();
			menug.pivotX=155;
			menug.pivotY=140;
			menug.x=20;
			menug.y=420;
			menug.scaleX=0;
			menug.scaleY=0;
			addChild(menug);
//tt			menug.addEventListener(TouchEvent.TOUCH,onTouchmenug);
			
			menud=new Filtremenu();
			menud.pivotX=155;
			menud.pivotY=140;
			menud.x=300;
			menud.y=420;
			menud.scaleX=0;
			menud.scaleY=0;
			addChild(menud);
//tt			menud.addEventListener(TouchEvent.TOUCH,onTouchmenud);
			
/*			if (Geolocation.isSupported) { 
				geo = new Geolocation(); 
				if (!geo.muted) { 
					geo.addEventListener(GeolocationEvent.UPDATE, geoUpdateHandler); 
				} 
				geo.addEventListener(StatusEvent.STATUS, geoStatusHandler);
			} else { 
				trace( "Geolocation not supported"); 
			}
*/
			//			zz=new Image();
			sp=new starling.display.Sprite();
			addChild(sp);
			
/*			var q:Quad=new Quad(200,200,Color.YELLOW);
			addChild(q);
			q.x=50;
			q.y=50;
*/			
		//	Starling.juggler.delayCall(function():void { xxx(); }, 3.0);
			
			rcl=new Rcloader();
			addChild(rcl);
			//Starling.juggler.delayCall(function():void { yyy(zimgs); }, 3.0);
//			Starling.juggler.delayCall(function():void { tt(); }, 0.5);

			addEventListener("closemenug",fermermenug);
			addEventListener("closemenud",fermermenud);	
			addEventListener("closemenudok",fermermenudok);
			// on prend la main pr la suite		
			partie.carto.addEventListener(LocationChangeEvent.LOCATION_CHANGING,handleLocationChanging);
			partie.carto.addEventListener(ErrorEvent.ERROR,pbcarto);

			/*
			var q:Quad=new Quad(200,200, Color.BLUE);
			addChild(q);
			
			
			var q1:Quad=new Quad(200,200, Color.WHITE);
			addChild(q1);
			var q2:Quad=new Quad(200,200, Color.BLUE);
			addChild(q2);
			var q3:Quad=new Quad(200,200, Color.WHITE);
			addChild(q3);
			var q4:Quad=new Quad(200,200, Color.BLUE);
			addChild(q4);
			
			q1.y=200;
			q2.y=400;
			q3.y=600;
			q4.y=800;
*/			
		}
		private function pbcarto(eve:ErrorEvent):void{
			trace("Root UN PB DE protool CARTE ??"+eve.text+" "+partie.carto.location+" "+eve.formatToString("String"));			
		}

		override protected function draw():void
		{
//			trace("draw home=> actualWidth: "+this.actualWidth+" stage.width: "+stage.width+" this.actualHeight: "+this.actualHeight+" stage.height: "+stage.height);
			//t rcl.setsize(this.actualWidth,this.actualHeight);
			// oju pas selon contexte
			switch (partie.typenav){
				case 0:
					setTimeout(Root.ouvrircarto,10);
					break;
				case 1:
					ouvrirmenu();	
					break;
				case 2:
					ouvrirfiltre();
					break;
				default:
					break;
			}
		}
		
		private function fermermenug():void{
			var tweenf:Tween=new Tween(menug,0.2,Transitions.LINEAR);
			tweenf.scaleTo(0);
			tweenf.moveTo(0,420);
			Starling.juggler.add(tweenf);
			tweenf.onComplete=Root.ouvrircarto;			
		}

		private function fermermenud():void{
			var tweenf:Tween=new Tween(menud,0.2,Transitions.LINEAR);
			tweenf.scaleTo(0);
			tweenf.moveTo(320,420);
			Starling.juggler.add(tweenf);
			tweenf.onComplete=Root.ouvrircarto;
			
			//partie.carto.viewPort=new Rectangle(-320,0,320,480);
		}
		private function fermermenudok():void{
			// on affiche le loader cette fois ...
			rcl.start();
			var tweenf:Tween=new Tween(menud,0.2,Transitions.LINEAR);
			tweenf.scaleTo(0);
			tweenf.moveTo(320,420);
			Starling.juggler.add(tweenf);
//			tweenf.onComplete=ouvrircarto;
	//XX?		partie.carto.addEventListener( LocationChangeEvent.LOCATION_CHANGE,handleLocationChange);
			// on recharge la page en js ?
						
//			partie.carto.loadURL(FBUserFactory.getUser().prefix+"/carto/iduser/"+FBUserFactory.getUser().user.IDUSER+"/rnd/"+Math.random());
			
			partie.carto.loadURL("javascript:asmajfiltre();");
			
			//partie.carto.viewPort=new Rectangle(-320,0,320,480);
		}
		private function handleLocationChange( event:LocationChangeEvent ):void
		{
			partie.carto.removeEventListener(LocationChangeEvent.LOCATION_CHANGE,handleLocationChange);
			trace("handleLocationChange fini ?=>"+event.location);
			rcl.stop();
			Root.ouvrircarto();
		}

		private function handleLocationChanging(event:LocationChangeEvent):void
		{
			// desactiver.. c est lahome qui prendra la main
			trace("Home handleLocationChanging=>"+event.location);
			event.preventDefault();			
			//			var data:Object = JSON.decode( event.location );
			//			trace( "Width: " + data.width + ", Height: " + data.height );
			//http://www9.noomiz.com/appelfiche/id/1331
			//om/appelfiche/id/1331
			trace(FBUserFactory.getUser().prefix);
			trace(FBUserFactory.getUser().prefix.length);
			//			var zaction:String=event.location.slice(FBUserFactory.getUser().prefix.length+1);
			switch (event.location){
				case 'rcmsg://cartook':
					// affichage de la carto et aussi de home pour préparer la suite
					rcl.stop();
					partie.typenav=0;
					var oldw:Number=partie.carto.viewPort.width;
					var oldy:Number=partie.carto.viewPort.y;
					var oldh:Number=partie.carto.viewPort.height;
					
					trace("retablir=>oldw"+oldw +" "+oldy+" "+oldh);
					partie.carto.viewPort=new Rectangle(0,oldy,oldw,oldh);
					//Starling.current.viewPort;					
					break;				
				case 'rcmsg://retfiltre':
					// affichage de la carto et aussi de home pour préparer la suite
					rcl.stop();
					partie.typenav=0;
					var oldwf:Number=partie.carto.viewPort.width;
					var oldyf:Number=partie.carto.viewPort.y;
					var oldhf:Number=partie.carto.viewPort.height;
					
					trace("retablir=>oldw"+oldwf +" "+oldyf+" "+oldhf);
					partie.carto.viewPort=new Rectangle(0,oldyf,oldwf,oldhf);
					//Starling.current.viewPort;					
					break;				
				case 'rcmsg://appelmsg':
					// affichage de la carto et aussi de home pour préparer la suite
					// on prend une photo et on bascule
					var result:BitmapData = new BitmapData(partie.carto.viewPort.width, partie.carto.viewPort.height, false);
					partie.carto.drawViewPortToBitmapData(result);
					var tx:Texture=Texture.fromBitmapData(result);
					var uneimage:Image=new Image(tx);			
					sp.addChild(uneimage);
					//			uneimage.y=30;
					//			uneimage.x=0;
					var oldwm:Number=partie.carto.viewPort.width;
					var oldym:Number=partie.carto.viewPort.y;
					var oldhm:Number=partie.carto.viewPort.height;
					
					partie.carto.viewPort=new Rectangle(-oldwm,oldym,oldwm,oldhm);
					
					partie.fromscreen="root";
					this.dispatchEventWith(Root.MESMESSAGES_SCREEN);
					//					partie.carto.viewPort=Starling.current.viewPort;					
					break;				
				case 'rcmsg://appelmenu':
					trace("HOME APPEL MENU");
					// on ouvre le menu, se fait par la home en fait ? à mettre ds le native stage ? à voir....
					ouvrirmenu();					
					//ouvrirmenu();
					break;
				case 'rcmsg://appelfiltre':
					trace("HOME APPEL filtre");
					// on ouvre le menu, se fait par la home en fait ?
					ouvrirfiltre();					
					//ouvrirmenu();					
					break;
				default:
					//					partie.carto.viewPort=new Rectangle(-partie.carto.viewPort.width,30,partie.carto.viewPort.width,partie.carto.viewPort.height);
					//					partie.idshop=zaction;
					//					this._navigator.showScreen(FICHECO_SCREEN);
			}
		}		
				
		public function ouvrirmenu():void{			
			var result:BitmapData = new BitmapData(partie.carto.viewPort.width, partie.carto.viewPort.height, true);
			partie.carto.drawViewPortToBitmapData(result);
			var tx:Texture=Texture.fromBitmapData(result,false,false,Starling.contentScaleFactor);
			var uneimage:Image=new Image(tx);			
			sp.addChild(uneimage);
//			uneimage.y=30;
//			uneimage.x=0;
			var oldx:Number=partie.carto.viewPort.x;
			var oldy:Number=partie.carto.viewPort.y;
			var oldw:Number=partie.carto.viewPort.width;
			var oldh:Number=partie.carto.viewPort.height;
			trace("oldx:"+oldx+" "+oldy+" "+oldw+" "+oldh);
			partie.carto.viewPort=new Rectangle(-oldw,oldy,oldw,oldh);
			//return;
			menug.parent.setChildIndex(menug,10);		
			var tweenf:Tween=new Tween(menug,1.8,Transitions.EASE_OUT_ELASTIC);
			tweenf.scaleTo(1);
			tweenf.moveTo(160,195);
			Starling.juggler.add(tweenf);	
		}

		public function ouvrirfiltre():void{
			var result:BitmapData = new BitmapData(partie.carto.viewPort.width,partie.carto.viewPort.height, false);
			partie.carto.drawViewPortToBitmapData(result);
			//
			var tx:Texture=Texture.fromBitmapData(result,false,false,Starling.contentScaleFactor);
			var uneimage:Image=new Image(tx);
			sp.addChild(uneimage);
			var oldx:Number=partie.carto.viewPort.x;
			var oldy:Number=partie.carto.viewPort.y;
			var oldw:Number=partie.carto.viewPort.width;
			var oldh:Number=partie.carto.viewPort.height;

			partie.carto.viewPort=new Rectangle(-oldw,oldy,oldw,oldh);
			//return;
			menud.parent.setChildIndex(menud,10);
			var tweenf:Tween=new Tween(menud,1.8,Transitions.EASE_OUT_ELASTIC);
			tweenf.scaleTo(1);
			tweenf.moveTo(160,150);
			Starling.juggler.add(tweenf);			
		}
		
		private function onError(e):void{
			trace("erreur");
			trace (e);
		}
		private function geoUpdateHandler(event:GeolocationEvent):void 
		{ 
			trace("latitude : " + event.latitude.toString()); 
			trace("longitude : " + event.longitude.toString());
		} 		
		private function geoStatusHandler(event:StatusEvent):void 
		{ 
			if (geo.muted)
				geo.removeEventListener(GeolocationEvent.UPDATE, geoUpdateHandler);
			else
				geo.addEventListener(GeolocationEvent.UPDATE, geoStatusHandler);
		}
	}
}