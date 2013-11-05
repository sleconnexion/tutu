package
{
	
	import com.zoe.composants.Homercloader;
	import com.zoe.composants.Popupneterror;
	import com.zoe.composants.Positionmarker;
	import com.zoe.objects.FBUserFactory;
	import com.zoe.objects.Partie;
	import com.zoe.screens.CartebloqueeScreen;
	import com.zoe.screens.CartefidScreen;
	import com.zoe.screens.ChercheadresseScreen;
	import com.zoe.screens.FichecoScreen;
	import com.zoe.screens.FichecosabonnerScreen;
	import com.zoe.screens.FichecosedesabonnerScreen;
	import com.zoe.screens.HomeScreen;
	import com.zoe.screens.IdentificationScreen;
	import com.zoe.screens.IdentificationokScreen;
	import com.zoe.screens.IdentificationoksansmailScreen;
	import com.zoe.screens.InscriptionScreen;
	import com.zoe.screens.MesadressesScreen;
	import com.zoe.screens.MescartefidsScreen;
	import com.zoe.screens.MescommercantsScreen;
	import com.zoe.screens.MesmessagesScreen;
	import com.zoe.screens.SaisiradresseScreen;
	import com.zoe.screens.SidentifierScreen;
	import com.zoe.screens.TestScreen;
	import com.zoe.screens.TutoScreen;
	import com.zoe.screens.ValidercartefidScreen;
	
	import flash.data.EncryptedLocalStore;
	import flash.display.BitmapData;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.LocationChangeEvent;
	import flash.geom.Rectangle;
	import flash.media.CameraRoll;
	import flash.media.StageWebView;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.events.FeathersEventType;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	import starling.utils.Color;
	
	import utils.ProgressBar;
	
	/** The Root class is the topmost display object in your game. It loads all the assets
	 *  and displays a progress bar while this is happening. Later, it is responsible for
	 *  switching between game and menu. For this, it listens to "START_GAME" and "GAME_OVER"
	 *  events fired by the Menu and Game classes. Keep this class rather lightweight: it 
	 *  controls the high level behaviour of your game. */
	public class Root extends Sprite
	{
		private static var sAssets:AssetManager;
		private var version:uint;
		private var mActiveScene:Sprite;
		public static var partie:Partie;
		private static var sp:Sprite;
		
		
		//protected var theme:OMDesktopTheme;
		protected var button:Button;
		private var _navigator:ScreenNavigator;
		private var _transitionManager:ScreenSlidingStackTransitionManager;
		//		private var _snd:ScreenTrans=new ScreenTrans();
		protected var theme:ZoeMobileTheme;
		
		public static const HOME_SCREEN:String = "homescreen";
		public static const TUTO_SCREEN:String = "tutoscreen";
		public static const TEST_SCREEN:String = "testscreen";
		public static const FICHECO_SCREEN:String = "fichecoscreen";
		public static const CARTEFID_SCREEN:String = "cartefidscreen";
		public static const VALIDERCARTEFID_SCREEN:String = "validercartefidscreen";
		public static const CARTEBLOQUEE_SCREEN:String = "cartebloqueescreen";
		public static const FICHECOSABONNER_SCREEN:String = "fichecosabonnerscreen";
		public static const FICHECOSEDESABONNER_SCREEN:String = "fichecosedesabonnerscreen";
		public static const MESMESSAGES_SCREEN:String = "mesmessagesscreen";
		public static const MESCOMERCANTS_SCREEN:String = "mescommercantsscreen";
		public static const MESCARTEFIDS_SCREEN:String = "mescartefidsscreen";
		public static const MESADRESSES_SCREEN:String = "mesadressesscreen";
		public static const SAISIRADRESSE_SCREEN:String = "saisiradressescreen";
		public static const CHERCHEADRESSE_SCREEN:String = "chercheadressescreen";
		public static const INSCRIPTION_SCREEN:String = "inscriptionscreen";
		public static const IDENTIFICATION_SCREEN:String = "identificationscreen";
		public static const IDENTIFICATIONOK_SCREEN:String = "identificationokscreen";
		public static const IDENTIFICATIONOKSANSMAIL_SCREEN:String = "identificationoksansmailscreen";
		public static const SIDENTIFIER_SCREEN:String = "sidentifierscreen";
		
		private var _labelmsg:Label;
		private var hrc:Homercloader;
		
		public function Root()
		{
			this.version=1;
			//            addEventListener(Menu.START_GAME, onStartGame);
			//           addEventListener(Game.GAME_OVER,  onGameOver);
			
			// not more to do here -- Startup will call "start" immediately.
		}
		
		public function start(background:Texture, assets:AssetManager):void
		{
			trace("Root.start");
			// the asset manager is saved as a static variable; this allows us to easily access
			// all the assets from everywhere by simply calling "Root.assets"
			sAssets = assets;
			
			// The background is passed into this method for two reasons:
			// 
			// 1) we need it right away, otherwise we have an empty frame
			// 2) the Startup class can decide on the right image, depending on the device.
			var lebg:Image=new Image(background);
			addChild(lebg);
			//			lebg.y=-20;
			//			addChild(new Image(background));
			
			//			var q:Quad=new Quad(100,100,Color.FUCHSIA);
			//			addChild(q);
			
			trace("xxx=>contentScaleFactor:"+Starling.contentScaleFactor);
			// premiere etape check si reseau .. on ping le serveur pr recuperer la version active
			this.theme = new ZoeMobileTheme (this.stage);
			
			var labversion:Label=new Label();
			labversion.nameList.add(ZoeMobileTheme.ROOT_LABVERSION);
			labversion.width=100;
			labversion.x=background.width-labversion.width-20;
			labversion.y=0.88*background.height;
			labversion.text="Version "+this.version;
			addChild(labversion);
			
			var labcopyright:Label=new Label();
			labcopyright.nameList.add(ZoeMobileTheme.ROOT_COPYRIGHT);
			labcopyright.y=0.88*background.height;
			labcopyright.width=200;
			labcopyright.text="© RueCentrale - 2013";
			labcopyright.x=(background.width-labcopyright.width)/2;
			addChild(labcopyright);
			
			var progressBar:ProgressBar = new ProgressBar(175, 20);
			progressBar.x = (background.width  - progressBar.width)  / 2;
			progressBar.y = (background.height - progressBar.height) / 2;
			progressBar.y = background.height * 0.85;
			addChild(progressBar);
			
			hrc=new Homercloader();
			//			var hrc:Rcloader=new Rcloader();
			addChild(hrc);
			hrc.x=(background.width)/2;;
			hrc.y=320;
			hrc.start();
			
			_labelmsg=new Label();
			_labelmsg.nameList.add(ZoeMobileTheme.ROOT_LABPRG);
			_labelmsg.width=background.width;
			_labelmsg.y=hrc.y+hrc.height/2+20;
			addChild(_labelmsg);
			
			sp=new starling.display.Sprite();
			addChild(sp);
			
			assets.loadQueue(function onProgress(ratio:Number):void
			{
				
				if(ratio){
					_labelmsg.text="Chargement des textures "+Math.floor((100*ratio))+" %";
					//				progressBar.ratio = ratio;
				}
				// a progress bar should always show the 100% for a while,
				// so we show the main menu only after a short delay. 				
				if (ratio == 1)
					Starling.juggler.delayCall(function():void
					{
						progressBar.removeFromParent(true);
						///  showScene(Menu);
						//lct facebook ss passer par le mennu qui est notre home
						//						FacebookMobile.init("227511337398976",loginHandler);						
						//						hrc.removeFromParent(true);
						demarrer();
					}, 0.15);
			});
			
		}
		private function demarrer():void{
			_labelmsg.text="Vérification de la connexion Internet";
			var xloaderq:URLLoader= new URLLoader();
			xloaderq.addEventListener(flash.events.Event.COMPLETE, xmlstartLoaded);
			var zurl:URLRequest=new URLRequest(FBUserFactory.getUser().prefix+"/jsonstart");
			zurl.method = URLRequestMethod.POST;
			var zdata:URLVariables=new URLVariables();
			zdata.version=this.version;
			var storedValue:ByteArray = EncryptedLocalStore.getItem("cookieiduser");
			if(storedValue && storedValue.length>0){
				// on a deja eu un user
				zdata.iduser=storedValue.readUTFBytes(storedValue.length);
				trace("check avec iduser:"+zdata.iduser);
			}
			zurl.data=zdata;
			xloaderq.addEventListener(IOErrorEvent.IO_ERROR, onstartError);
			xloaderq.load (zurl);
		}
		
		private function xmlstartLoaded(event:flash.events.Event):void {
			var loader:URLLoader = URLLoader(event.target);
			var zret:Object =JSON.parse(loader.data);
			if(zret.ok==1 && zret.user.IDUSER){
				_labelmsg.text="Connexion Internet ok";
				trace("xmlstartLoaded ok=>"+zret.user.IDUSER);
				var str:String= zret.user.IDUSER;
				var bytes:ByteArray= new ByteArray();
				bytes.writeUTFBytes(str);
				EncryptedLocalStore.setItem("cookieiduser", bytes);
				FBUserFactory.getUser().user=zret.user;
				// direction ecran d accueil apres charegement
				lancer();
			} else {
				trace("xmlstartLoaded ko");
				//removeChildAt(0);
				// on met le bon fond
				//			addChild(new Image(Root.assets.getTexture("background")));
				// mauvaise version à priori
				var l:Label=new Label();
				l.x=20;
				l.y=20;
				if(zret.error){
					l.text=zret.error;
				} else {
					l.text="Une erreur technique est survenue.";
				}
				addChild(l);
			}
		}
		
		private function lancer():void{
			// constitution des ecrans
			//removeChildAt(0);
			// on met le bon fond
			
			//var qua:Quad=new Quad(320,480,Color.GREEN);
			//addChild(qua);
			
			//addChild(new Image(Root.assets.getTexture("background")));
			_labelmsg.text="Chargement des écrans";
			
			this._navigator = new ScreenNavigator();
			this.addChild(this._navigator);
			partie=new Partie();
			
			//			this._navigator.addEventListener(FeathersEventType.TRANSITION_COMPLETE, owner_transitionCompleteHandler );
			this._navigator.addEventListener(FeathersEventType.TRANSITION_START, owner_transitionCompleteHandler );
			this._navigator.addScreen(TUTO_SCREEN,new ScreenNavigatorItem(TutoScreen,
				{
					complete:HOME_SCREEN
				},
				{partie:partie}));
			
			this._navigator.addScreen(HOME_SCREEN,new ScreenNavigatorItem(HomeScreen,
				{
					testscreen:TEST_SCREEN,
					tutoscreen:TUTO_SCREEN,
					fichecoscreen:FICHECO_SCREEN,
					mesmessagesscreen:MESMESSAGES_SCREEN,
					mescommercantsscreen:MESCOMERCANTS_SCREEN,
					mescartefidsscreen:MESCARTEFIDS_SCREEN,
					mesadressesscreen:MESADRESSES_SCREEN,
					chercheadressescreen:CHERCHEADRESSE_SCREEN,
					identificationscreen:IDENTIFICATION_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(TEST_SCREEN,new ScreenNavigatorItem(TestScreen,
				{
					complete:HOME_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(FICHECO_SCREEN,new ScreenNavigatorItem(FichecoScreen,
				{
					complete:HOME_SCREEN,
					fichecosabonnerscreen:FICHECOSABONNER_SCREEN,
					fichecosedesabonnerscreen:FICHECOSEDESABONNER_SCREEN,					
					mesmessagesscreen:MESMESSAGES_SCREEN,
					mescommercantsscreen:MESCOMERCANTS_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(FICHECOSABONNER_SCREEN,new ScreenNavigatorItem(FichecosabonnerScreen,
				{
					complete:HOME_SCREEN,
					fichecoscreen:FICHECO_SCREEN,
					mescommercantsscreen:MESCOMERCANTS_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(FICHECOSEDESABONNER_SCREEN,new ScreenNavigatorItem(FichecosedesabonnerScreen,
				{
					complete:HOME_SCREEN,
					fichecoscreen:FICHECO_SCREEN,
					mescommercantsscreen:MESCOMERCANTS_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(MESMESSAGES_SCREEN,new ScreenNavigatorItem(MesmessagesScreen,
				{
					complete:HOME_SCREEN,
					fichecoscreen:FICHECO_SCREEN,
					mescommercantsscreen:MESCOMERCANTS_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(MESADRESSES_SCREEN,new ScreenNavigatorItem(MesadressesScreen,
				{
					complete:HOME_SCREEN,
					chercheadressescreen:CHERCHEADRESSE_SCREEN,
					saisiradressescreen:SAISIRADRESSE_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(CHERCHEADRESSE_SCREEN,new ScreenNavigatorItem(ChercheadresseScreen,
				{
					complete:HOME_SCREEN,
					mesadressesscreen:MESADRESSES_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(SAISIRADRESSE_SCREEN,new ScreenNavigatorItem(SaisiradresseScreen,
				{
					complete:HOME_SCREEN,
					mesadressesscreen:MESADRESSES_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(MESCOMERCANTS_SCREEN,new ScreenNavigatorItem(MescommercantsScreen,
				{
					complete:HOME_SCREEN,
					fichecoscreen:FICHECO_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(MESCARTEFIDS_SCREEN,new ScreenNavigatorItem(MescartefidsScreen,
				{
					complete:HOME_SCREEN,
					cartefidscreen:CARTEFID_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(CARTEFID_SCREEN,new ScreenNavigatorItem(CartefidScreen,
				{
					complete:MESCARTEFIDS_SCREEN,
					validercartefidscreen:VALIDERCARTEFID_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(VALIDERCARTEFID_SCREEN,new ScreenNavigatorItem(ValidercartefidScreen,
				{
					complete:CARTEFID_SCREEN,
					cartebloqueescreen:CARTEBLOQUEE_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(CARTEBLOQUEE_SCREEN,new ScreenNavigatorItem(CartebloqueeScreen,
				{
					complete:CARTEFID_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(INSCRIPTION_SCREEN,new ScreenNavigatorItem(InscriptionScreen,
				{
					complete:HOME_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(IDENTIFICATION_SCREEN,new ScreenNavigatorItem(IdentificationScreen,
				{
					complete:HOME_SCREEN,
					sidentifierscreen:SIDENTIFIER_SCREEN,
					identificationokscreen:IDENTIFICATIONOK_SCREEN,
					identificationoksansmailscreen:IDENTIFICATIONOKSANSMAIL_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(IDENTIFICATIONOK_SCREEN,new ScreenNavigatorItem(IdentificationokScreen,
				{
					complete:HOME_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(IDENTIFICATIONOKSANSMAIL_SCREEN,new ScreenNavigatorItem(IdentificationoksansmailScreen,
				{
					complete:HOME_SCREEN,
					identificationokscreen:IDENTIFICATIONOK_SCREEN
				},
				{partie:partie}));
			this._navigator.addScreen(SIDENTIFIER_SCREEN,new ScreenNavigatorItem(SidentifierScreen,
				{
					complete:HOME_SCREEN,
					identificationokscreen:IDENTIFICATIONOK_SCREEN
				},
				{partie:partie}));
			
			
			if (mActiveScene) mActiveScene.removeFromParent(true);
			
			
			//			this._navigator.showScreen(FINQUIZZ_SCREEN);			
			this._transitionManager = new ScreenSlidingStackTransitionManager(this._navigator);
			this._transitionManager.duration = 0.4;
			
			
			partie.carto=new StageWebView();
			// meme taille que le stage ?
			trace("Starling.current.stage.width "+Starling.current.stage.width + "Starling.current.stage.height:"+Starling.current.stage.height);
			trace("Starling.current.viewport.y "+Starling.current.viewPort.y+"Starling.current.viewport.width "+Starling.current.viewPort.width + "Starling.current.viewport.height:"+Starling.current.viewPort.height);
			// on prend la aille du viewport starling
			
	//ok simu et iphone		partie.carto.viewPort= Starling.current.viewPort;//new Rectangle(-Starling.current.stage.width,0,Starling.current.stage.width,Starling.current.stage.height);
			partie.carto.viewPort= Starling.current.viewPort;//new Rectangle(-Starling.current.stage.width,0,Starling.current.stage.width,Starling.current.stage.height);
//			partie.carto.viewPort= new Rectangle(50,50,600,600); //=>1/4
			//ok android ?			
//			partie.carto.viewPort=new Rectangle(-Starling.current.stage.width,0,Starling.current.stage.width,Starling.current.stage.height)
			partie.carto.stage=Starling.current.nativeStage;
			partie.carto.addEventListener(LocationChangeEvent.LOCATION_CHANGING,handleLocationChanging);
			partie.carto.addEventListener(ErrorEvent.ERROR,pbcarto);
			//			partie.carto.addEventListener( LocationChangeEvent.LOCATION_CHANGE,handleLocationChange);
	var lurl:String=FBUserFactory.getUser().prefix+"/carto/iduser/"+FBUserFactory.getUser().user.IDUSER+"/w/"+Starling.current.viewPort.width +"/h/"+Starling.current.viewPort.height +"/rnd/"+Math.random();
			_labelmsg.text="Chargement de la cartographie";
	partie.carto.loadURL(lurl);

	//this._navigator.showScreen(FICHECO_SCREEN);	
		}
		private function pbcarto(eve:ErrorEvent):void{
			partie.carto.removeEventListener(LocationChangeEvent.LOCATION_CHANGING,handleLocationChanging);
			partie.carto.removeEventListener(ErrorEvent.ERROR,pbcarto);
			trace("Root UN PB DE protool CARTE ??"+eve.text+" "+partie.carto.location+" "+eve.formatToString("String"));
			if(eve.text.indexOf('rcmsg://cartook')>0){
				// affichage de la carto et aussi de home pour préparer la suite
				ouvrircarto();
				hrc.stop();
				hrc.removeFromParent(true);
				_labelmsg.text="Pour tout problème : contact@ruecentrale.com";
				partie.typenav=-1;
				this._navigator.showScreen(HOME_SCREEN);
			} else {
				_labelmsg.text="Erreur technique (onpbcarto).";
			}
		}
		
		public static function ouvrircarto():void{
			
			trace("fscreen;"+Starling.current.nativeStage.fullScreenWidth+" h:"+Starling.current.nativeStage.fullScreenHeight);
			var oldw:Number=partie.carto.viewPort.width;
			var oldy:Number=partie.carto.viewPort.y;
			var oldh:Number=partie.carto.viewPort.height;
			partie.carto.viewPort= new Rectangle(0,oldy,oldw,oldh);
			//			sp.removeChildren();
			//Starling.current.viewPort;//   new Rectangle(0,30,partie.carto.viewPort.width,partie.carto.viewPort.height);
		}

		public static function chercheradresse():void{
			
			trace("fscreen;"+Starling.current.nativeStage.fullScreenWidth+" h:"+Starling.current.nativeStage.fullScreenHeight);
			var oldw:Number=partie.carto.viewPort.width;
			var oldy:Number=partie.carto.viewPort.y;
			var oldh:Number=partie.carto.viewPort.height;
			partie.carto.viewPort= new Rectangle(0,oldy,oldw,oldh);
			partie.carto.loadURL("javascript:chercheradr()");
			//			sp.removeChildren();
			//Starling.current.viewPort;//   new Rectangle(0,30,partie.carto.viewPort.width,partie.carto.viewPort.height);
		}
		
		private function handleLocationChanging( event:LocationChangeEvent ):void
		{
			partie.carto.removeEventListener( LocationChangeEvent.LOCATION_CHANGING,handleLocationChanging);
			partie.carto.removeEventListener(ErrorEvent.ERROR,pbcarto);
			// desactiver.. c est lahome qui prendra la main
			trace("Root handleLocationChanging=>"+event.location);
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
					ouvrircarto();
					hrc.stop();
					hrc.removeFromParent(true);
					_labelmsg.text="Pour tout problème : contact@ruecentrale.com";			
					this._navigator.showScreen(HOME_SCREEN);
					partie.typenav=-1;
					break;				
				default:
					_labelmsg.text="Erreur technique (onhandle).";
					
			}
		}		
		private function handleLocationChange( event:LocationChangeEvent ):void
		{
			trace("chgt fini ? handleLocationChange=>"+event.location);
			_labelmsg.text="Chargement de la cartogaphie ok";
			this._navigator.showScreen(HOME_SCREEN);
			//sle			partie.carto.viewPort=new Rectangle(20,0,320,480);			
			//			event.preventDefault();
			//			var data:Object = JSON.decode( event.location );
			//			trace( "Width: " + data.width + ", Height: " + data.height );
			
		}
		
		private function onstartError(e):void{
			
			//removeChildAt(0);
			// on met le bon fond
			//			addChild(new Image(Root.assets.getTexture("background")));
			
			var unepopupneterror:Popupneterror=new Popupneterror(1);
			unepopupneterror.setsize(Starling.current.nativeStage.fullScreenWidth,Starling.current.nativeStage.fullScreenHeight);
			addChild(unepopupneterror);
//ch			
//			lancer();			
		}

		
		public static function afficherbg():void{
			var result:BitmapData = new BitmapData(partie.carto.viewPort.width, partie.carto.viewPort.height, true);
			partie.carto.drawViewPortToBitmapData(result);
			var tx:Texture=Texture.fromBitmapData(result,false,false,Starling.contentScaleFactor);
			var uneimage:Image=new Image(tx);			
			sp.addChild(uneimage);
		}
		
		
		private function old(background:Texture, assets:AssetManager):void{	
			var storedValue:ByteArray = EncryptedLocalStore.getItem("cookieuser");
			if(storedValue.length>0){
				// on a deja eu un user
				
			} else {
				// premiere fois, sinon on a enregistre le user
				// il faut recuperer un user depuis le serveur
			}
			var storedValue:ByteArray = EncryptedLocalStore.getItem("cookieuserfb");
			trace(storedValue.readUTFBytes(storedValue.length)); // "Bob"
			
			
			
			var str:String = "Bob";
			var bytes:ByteArray= new ByteArray();
			bytes.writeUTFBytes(str);
			EncryptedLocalStore.setItem("firstName", bytes);
			
			var storedValue:ByteArray = EncryptedLocalStore.getItem("firstName");
			trace(storedValue.readUTFBytes(storedValue.length)); // "Bob"
			
			EncryptedLocalStore.removeItem("firstName");
			
			
			// The AssetManager contains all the raw asset data, but has not created the textures
			// yet. This takes some time (the assets might be loaded from disk or even via the
			// network), during which we display a progress indicator. 
			
			var progressBar:ProgressBar = new ProgressBar(175, 20);
			progressBar.x = (background.width  - progressBar.width)  / 2;
			progressBar.y = (background.height - progressBar.height) / 2;
			progressBar.y = background.height * 0.85;
			addChild(progressBar);
			
			assets.loadQueue(function onProgress(ratio:Number):void
			{
				trace("demarrage4"+ratio);
				if(ratio){
					progressBar.ratio = ratio;
				}
				// a progress bar should always show the 100% for a while,
				// so we show the main menu only after a short delay. 
				
				if (ratio == 1)
					Starling.juggler.delayCall(function():void
					{
						trace("demarrage4");
						
						progressBar.removeFromParent(true);
						///  showScene(Menu);
						//lct facebook ss passer par le mennu qui est notre home
						//						FacebookMobile.init("227511337398976",loginHandler);						
						demarrerzoe();
					}, 0.15);
			});
		}
		
		
		private function loginHandler(response:Object, fail:Object):void
		{   
			trace("TEST INIT FB CB");
			//			var extendedPermissions:Array = ["publish_stream","user_website","user_status","user_about_me"];
			//email,user_birthday,user_location,publish_stream
			var extendedPermissions:Array = ["email","publish_stream","user_birthday","user_location"];
			if(fail){
				trace("error");
				for (var s:String in fail.error){
					trace("key:",s,"value:",fail.error[s]);
				}
			}
			if(response)
			{
				// good the user is already connected
				// recup d elt
				trace("Connecte!");
				//			FacebookMobile.api('/me', handleUserInfo);
				/*
				var myWebView:StageWebView = new StageWebView();
				myWebView.stage = Starling.current.nativeStage;
				myWebView.viewPort = new Rectangle(0,0,Starling.current.nativeStage.stageWidth,Starling.current.nativeStage.stageHeight);
				myWebView.loadURL("http://www.noomiz.com");
				*/
			}
			else
			{
				var myWebView:StageWebView = new StageWebView();
				myWebView.stage = Starling.current.nativeStage;
				//myWebView.viewPort = new Rectangle(0,0,Starling.current.nativeStage.stageWidth,Starling.current.nativeStage.stageHeight);
				myWebView.viewPort = new Rectangle(0,0,Starling.current.nativeStage.fullScreenWidth,Starling.current.nativeStage.fullScreenHeight);
				//			FacebookMobile.login(handleLogin, Starling.current.nativeStage, extendedPermissions, myWebView);
			}
		}
		protected function handleLogin(response:Object, fail:Object):void {
			//bg.visible = false;
			trace("handlelogin");
			//		FacebookMobile.api('/me', handleUserInfo);
		}
		protected function handleUserInfo(response:Object, fail:Object):void {
			//bg.visible = false;
			trace("handleUserInfo:");
			//sleconnexion@gmail.com Samuel Leblond 1049160290 Samuel male fr_FR samuel.leblond
			//		trace(response.email+" "+response.name+" "+response.id+" "+response.first_name+" "+response.gender+" "+response.locale+" "+response.username+" "+response.birthday+" "+response.hometown.name);
			if(response.id){
				// on peut lancer le game, on a l id
				//recup par menu
				//			FBUserFactory.getUser().idfb=response.id;
				// on recupere les data et verifie si inscrit ...
				//sle todo
				
				///				demarrerjeu();
				
			}
		}
		
		private function demarrerzoe():void{
			// on check si deja inscrit => par fb ou par login.. connection en cours ou pas ...
			
		}
		
		
		private function owner_transitionCompleteHandler( event:starling.events.Event ):void
		{
			//			this._snd.play();
			//this._navigator.removeEventListener( FeathersEventType.TRANSITION_COMPLETE, owner_transitionCompleteHandler );
			
			// finish initialization here
		}
		
		
		private function showScene(screen:Class):void
		{
			if (mActiveScene) mActiveScene.removeFromParent(true);
			mActiveScene = new screen();
			addChild(mActiveScene);
		}
		
		public static function get assets():AssetManager { return sAssets; }
	}
}