package com.zoe.screens
{
	import com.zoe.objects.FBUserFactory;
	import com.zoe.objects.Partie;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.utils.Color;
	
	[Event(name="complete",type="starling.events.Event")]
	[Event(name="identificationokscreen",type="starling.events.Event")]
	[Event(name="identificationoksansmailscreen",type="starling.events.Event")]

	public class SidentifierScreen extends Screen
	{

		private var _backButton:Button;
		private var _iconmsg:Image;
		private var _labelico:Label;
		
		private var _labelnom:Label;
		private var _labeladresse:Label;
		private var _scrollvertical:ScrollContainer;
		public var partie:com.zoe.objects.Partie;
		private var _container:ScrollContainer;
		
		private var _labderniereadresse:Label;
		private var _labm:Label;
		
		private var _pseudo:TextInput;
		private var _mdp:TextInput;
		
		private var _laberrorpseudo:Label;
		private var _laberrormdp:Label;
		
		
		public function SidentifierScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("Sidentfiier initialize");
			var q:Quad=new Quad(stage.width,stage.height,Color.BLACK,true);
			q.alpha=0.7;
			addChild(q);
			this._backButton = new Button();
			this._backButton.label = "retour";
			_backButton.nameList.add(ZoeMobileTheme.BOUTON_BACK);
			this._backButton.addEventListener(starling.events.Event.TRIGGERED, backButton_triggeredHandler);
			this.backButtonHandler = this.onBackButton;			
			addChild(_backButton);

			// zone du milieu
			_iconmsg=new Image(Root.assets.getTexture("pictoadresse"));
//			addChild(_iconmsg);
			_labelico=new Label();
			_labelico.nameList.add(ZoeMobileTheme.LABEL_ICO);
			_labelico.text="S'identifier";
//			addChild(_labelico);
			
			_container=new ScrollContainer();
			_container.backgroundSkin=new Scale9Image(new Scale9Textures(Root.assets.getTexture("fondorange"),new Rectangle(70,70,40,10)));
			var vl:VerticalLayout=new VerticalLayout();
			vl.horizontalAlign=HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			_container.layout=vl;
			vl.paddingTop=20;
			vl.gap=5;
			addChild(_container);
			
			var labhaut:Label=new Label();
			labhaut.nameList.add(ZoeMobileTheme.IDENTIFICATIONLABHAUT);
			labhaut.text="S'identifier";
			_container.addChild(labhaut);
			labhaut.width=240;
						
			
			_laberrorpseudo=new Label();
			_laberrorpseudo.nameList.add(ZoeMobileTheme.IDENTIFICATIONERROR);
			_container.addChild(_laberrorpseudo);
			_laberrorpseudo.text=" ";
			_laberrorpseudo.height=1;
			_laberrorpseudo.width=200;
			_pseudo= new TextInput();
			_pseudo.nameList.add(ZoeMobileTheme.IDENTIFICATIONINPUT);
			_pseudo.prompt="Pseudo";
			_pseudo.width=200;
			_pseudo.height=20;
			_container.addChild(_pseudo);

			_laberrormdp=new Label();
			_laberrormdp.nameList.add(ZoeMobileTheme.IDENTIFICATIONERROR);
			_container.addChild(_laberrormdp);
			_laberrormdp.width=200;
			_laberrormdp.text=" ";
			_laberrormdp.height=1;
			_mdp= new TextInput();
			_mdp.nameList.add(ZoeMobileTheme.IDENTIFICATIONINPUT);
			_mdp.prompt="Mot de passe";
			_mdp.displayAsPassword=true;
			_mdp.width=200;
			_mdp.height=20;
			_container.addChild(_mdp);
			
			
			var qq7:Quad=new Quad(1,2,0xFFB600);
			_container.addChild(qq7);
			var btncree:Button=new Button();
			btncree.nameList.add(ZoeMobileTheme.IDENTIFICATIONBTNNOIR);
			btncree.label="Let's go !";
			btncree.addEventListener(starling.events.Event.TRIGGERED, creerButton_triggeredHandler);
			_container.addChild(btncree);
			var qq8:Quad=new Quad(1,2,0xFFB600);
			_container.addChild(qq8);
			
			var qq3:Quad=new Quad(240,2,Color.BLACK);
			_container.addChild(qq3);

			var qq4:Quad=new Quad(1,2,0xFFB600);
			_container.addChild(qq4);

			var sc:ScrollContainer=new ScrollContainer();
			var hl:HorizontalLayout=new HorizontalLayout();
			hl.verticalAlign=VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			hl.paddingLeft=10;
			sc.layout=hl;
			var imgpic:Image=new Image(Root.assets.getTexture("cadenas"));
			sc.addChild(imgpic);
			var labdeja:Label=new Label();
			labdeja.nameList.add(ZoeMobileTheme.IDENTIFICATIONLABDEJA);
			labdeja.text="Mot de passse oublié ? c'est ici !";
			labdeja.width=240;
			labdeja.addEventListener(starling.events.Event.TRIGGERED, mdpoublieButton_triggeredHandler);
			sc.addChild(labdeja);
			_container.addChild(sc);
		}
		override protected function draw():void
		{
			trace("draw message");
			_backButton.x=5;
			_backButton.y=5;
			
			_iconmsg.x=100;
			_iconmsg.y=10;
			
			_labelico.x=_iconmsg.x+30;
			_labelico.y=10;
			_labelico.width=200;
			
			_container.y=120;
			_container.width=260;
			_container.x=(this.actualWidth-_container.width)/2;
			_container.height=220;
						
		}
		
		private function letsgo():void{
			trace("appel de letsgo");
			var xloaderq:URLLoader= new URLLoader();
			xloaderq.addEventListener(flash.events.Event.COMPLETE, xmlinfosLoaded);
			xloaderq.addEventListener(IOErrorEvent.IO_ERROR, onError);
			var zurl:URLRequest=new URLRequest(FBUserFactory.getUser().prefix+"/sidentifier?rnd="+Math.random());
			zurl.method = URLRequestMethod.POST;
			var zdata:URLVariables=new URLVariables();
			zdata.iduser=FBUserFactory.getUser().user.IDUSER;
			zdata.pseudo=_pseudo.text;
			zdata.mdp=_mdp.text;
			zurl.data=zdata;
			xloaderq.load (zurl);
		}
		private function xmlinfosLoaded(event:flash.events.Event):void {
			trace("Recup du post");
			var loader:URLLoader = URLLoader(event.target);
			var zret:Object =JSON.parse(loader.data);
			var autreadre:Boolean=false;
			trace("zret.ok=>"+zret.ok);
			_laberrorpseudo.text=" ";
			_laberrorpseudo.height=1;
			_laberrormdp.text=" ";
			_laberrormdp.height=1;

			switch (zret.ok){
				case "1":
					trace("cas 1");
					// tt va bien on route vers le bon ecran
					//					this.dispatchEventWith(Root.IDENTIFICATIONOK_SCREEN);
//					this.dispatchEventWith(Root.IDENTIFICATIONOK_SCREEN);
					if(zret.email){
						// on route vers // on route vers identification avec email ok
						FBUserFactory.getUser().user.PSEUDO=zret.pseudo;
						this.dispatchEventWith(Root.IDENTIFICATIONOK_SCREEN);
					} else {
						if(zret.iduser){
							// on route vers identification ss email
							trace("vers ok sans email");
							FBUserFactory.getUser().user.PSEUDO=zret.pseudo;
							this.dispatchEventWith(Root.IDENTIFICATIONOKSANSMAIL_SCREEN);
							
						} else {
							// pb
							trace("pb trechnique ");
							trace("todo");
						}
					}
					break;
				case "2":
					// erreur sur le formulaire
					if(zret.error){
						trace("zret.error");
						for(var key:String in zret.error.pseudo) {
							trace("Name: " + key + " - Value: " + zret.error.pseudo[key]);
							_laberrorpseudo.text=zret.error.pseudo[key];
							_laberrorpseudo.height=10
						}
						for(var keym:String in zret.error.mdp) {
							trace("Name: " + keym + " - Value: " + zret.error.mdp[keym]);
							_laberrormdp.text=zret.error.mdp[keym];
							_laberrormdp.height=10
						}
					} else {
						trace("pb de flux");
					}
					break;
				default:
					// erreur technique afficher la popup de pb technique
					// todo
					break;
			}
		}
		private function onBackButton():void
		{
			trace("bacckbutton");
			this.dispatchEventWith(starling.events.Event.COMPLETE);
		}
		
		private function creerButton_triggeredHandler(event:starling.events.Event):void
		{
			trace("click");
			letsgo();
		}
		private function mdpoublieButton_triggeredHandler(event:starling.events.Event):void
		{
			trace("click mdpoublie TODO");
			//this.dispatchEventWith(starling.events.Event.COMPLETE);
		}
		
		private function backButton_triggeredHandler(event:starling.events.Event):void
		{
			trace("click");
			this.onBackButton();
		}

		private function onError(e):void{
			trace("erreur");
			trace (e);
		}
	}
}