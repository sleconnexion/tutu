package com.zoe.screens
{
	import com.zoe.composants.Uneadresse;
	import com.zoe.objects.FBUserFactory;
	import com.zoe.objects.Partie;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.TextInput;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.utils.Color;
	
	[Event(name="complete",type="starling.events.Event")]
	[Event(name="identificationokscreen",type="starling.events.Event")]

	public class IdentificationoksansmailScreen extends Screen
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
		
		private var _laberrormail:Label;
		private var _email:TextInput;		
		
		public function IdentificationoksansmailScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("Identificationok initialize");
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
			vl.paddingTop=30;
			vl.gap=10;
			addChild(_container);
						
			var imgdanger:Image=new Image(Root.assets.getTexture("danger"));
			_container.addChild(imgdanger);
			
			
			var labhaut:Label=new Label();
			labhaut.nameList.add(ZoeMobileTheme.IDENTIFICATIONLABHAUT);
			labhaut.text="Email manquant";
			_container.addChild(labhaut);
			labhaut.width=240;
			
			_labm=new Label();
			_labm.nameList.add(ZoeMobileTheme.IDENTIFICATIONLABM);
			_labm.text="Nous vous conseillons de saisir une adresse email pour que nous puissions vous renvoyer votre mot de passe si vous l'oubliez.";
			_container.addChild(_labm);
			_labm.width=220;

			_laberrormail=new Label();
			_laberrormail.nameList.add(ZoeMobileTheme.IDENTIFICATIONERROR);
			_container.addChild(_laberrormail);
			_laberrormail.text=" ";
			_laberrormail.height=1;
			_laberrormail.width=200;
			_email= new TextInput();
			_email.nameList.add(ZoeMobileTheme.IDENTIFICATIONINPUT);
			_email.prompt="Adresse email";
			_container.addChild(_email);
			_email.width=200;
			_email.height=20;
			_email.nameList.add(ZoeMobileTheme.IDENTIFICATIONINPUT);

			var btnval:Button=new Button();
			btnval.label="Valider";
			btnval.addEventListener(starling.events.Event.TRIGGERED, valButton_triggeredHandler);
			btnval.nameList.add(ZoeMobileTheme.IDENTIFICATIONBTNNOIR);
			_container.addChild(btnval);
									
			var btnno:Button=new Button();
			btnno.label="Non, je ne souhaite pas donner mon email";
			btnno.width=200;
			btnno.addEventListener(starling.events.Event.TRIGGERED, noButton_triggeredHandler);
			btnno.nameList.add(ZoeMobileTheme.IDENTIFICATIOMAILMANQUANT);
			_container.addChild(btnno);
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
			
			_container.y=70;
			_container.width=260;
			_container.x=(this.actualWidth-_container.width)/2;
			_container.height=300;			
		}
		private function valider():void{
			trace("appel de valider");
			var xloaderq:URLLoader= new URLLoader();
			xloaderq.addEventListener(flash.events.Event.COMPLETE, xmlinfosLoaded);
			xloaderq.addEventListener(IOErrorEvent.IO_ERROR, onError);
			var zurl:URLRequest=new URLRequest(FBUserFactory.getUser().prefix+"/jsonmajemail?rnd="+Math.random());
			zurl.method = URLRequestMethod.POST;
			var zdata:URLVariables=new URLVariables();
			zdata.iduser=FBUserFactory.getUser().user.IDUSER;
			zdata.email=_email.text;
			zurl.data=zdata;
			xloaderq.load (zurl);
		}
		private function xmlinfosLoaded(event:flash.events.Event):void {
			trace("Recup du post");
			var loader:URLLoader = URLLoader(event.target);
			var zret:Object =JSON.parse(loader.data);
			var autreadre:Boolean=false;
			trace("zret.ok=>"+zret.ok);
			_laberrormail.text=" ";
			_laberrormail.height=1;
			switch (zret.ok){
				case "1":
					trace("cas 1");
					// tt va bien on route vers le bon ecran
					//					this.dispatchEventWith(Root.IDENTIFICATIONOK_SCREEN);
					//					this.dispatchEventWith(Root.IDENTIFICATIONOK_SCREEN);
					if(zret.email){
						// on route vers // on route vers identification avec email ok
						FBUserFactory.getUser().user.EMAIL=zret.email;
						this.dispatchEventWith(Root.IDENTIFICATIONOK_SCREEN); 
					} else {
						// pb
						trace("pb trechnique ");
						trace("todo");
					}
					break;
				case "2":
					// erreur sur le formulaire
					if(zret.error){
						trace("zret.error");
						for(var keya:String in zret.error) {
							trace("Name: " + keya + " - Value: " + zret.error[keya]);
						}						
						
						for(var keye:String in zret.error.email) {
							trace("Name: " + keye + " - Value: " + zret.error.email[keye]);
							_laberrormail.text=zret.error.email[keye];
							_laberrormail.height=10
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
		private function valButton_triggeredHandler(event:starling.events.Event):void
		{
			trace("click");
			valider();
		}
		
		private function noButton_triggeredHandler(event:starling.events.Event):void
		{
			trace("click");
			this.dispatchEventWith(Root.IDENTIFICATIONOK_SCREEN);
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