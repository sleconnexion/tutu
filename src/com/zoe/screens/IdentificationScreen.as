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
	[Event(name="sidentifierscreen",type="starling.events.Event")]
	
	public class IdentificationScreen extends Screen
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
		private var _email:TextInput;

		private var _laberrorpseudo:Label;
		private var _laberrormdp:Label;
		private var _laberrormail:Label;

		
		
		public function IdentificationScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("Identification initialize");
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
			labhaut.text="Pour utiliser cette fonctionnalité, vous devez créer un compte RueCentrale";
			_container.addChild(labhaut);
			labhaut.width=240;
			
			var qq:Quad=new Quad(240,2,Color.BLACK);
			_container.addChild(qq);
			var q2:Quad=new Quad(1,5,0xFFB600);
			_container.addChild(q2);
			
			var imgfb:Image=new Image(Root.assets.getTexture("btnfb"));
			_container.addChild(imgfb);
			
			var labfb:Label=new Label();
			labfb.nameList.add(ZoeMobileTheme.IDENTIFICATIONLABFB);
			labfb.text="RueCentrale ne poste jamais de messages sans votre autorisation";
			_container.addChild(labfb);
			labfb.width=240;

			var qq2:Quad=new Quad(240,2,Color.BLACK);
			_container.addChild(qq2);

			
			_labm=new Label();
			_labm.nameList.add(ZoeMobileTheme.IDENTIFICATIONLABM);
			_labm.text="Sinon, créez un compte avec vos coordonnées";
			_container.addChild(_labm);
			_labm.width=200;


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
			
			_laberrormail=new Label();
			_laberrormail.nameList.add(ZoeMobileTheme.IDENTIFICATIONERROR);
			_container.addChild(_laberrormail);
			_laberrormail.text=" ";
			_laberrormail.height=1;
			_laberrormail.width=200;
			_email= new TextInput();
			_email.nameList.add(ZoeMobileTheme.IDENTIFICATIONINPUT);
			_email.prompt="Adresse email (facultatif)";
			_container.addChild(_email);
			_email.width=200;
			_email.height=20;
			_email.nameList.add(ZoeMobileTheme.IDENTIFICATIONINPUT);
			
			var qq7:Quad=new Quad(1,2,0xFFB600);
			_container.addChild(qq7);
			var btncree:Button=new Button();
			btncree.nameList.add(ZoeMobileTheme.IDENTIFICATIONBTNNOIR);
			btncree.label="Créez !";
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
			hl.verticalAlign=HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
			hl.horizontalAlign=HorizontalLayout.HORIZONTAL_ALIGN_LEFT
			hl.paddingLeft=10;
			sc.layout=hl;
			var imgpic:Image=new Image(Root.assets.getTexture("profil"));
			sc.addChild(imgpic);
			var labdeja:Label=new Label();
			labdeja.nameList.add(ZoeMobileTheme.IDENTIFICATIONLABDEJA);
			labdeja.text="Déjà inscrit ?";
			labdeja.width=100;
			sc.addChild(labdeja);
			_container.addChild(sc);
			
			var btn:Button=new Button();
			btn.label="S'identifier";
			btn.nameList.add(ZoeMobileTheme.IDENTIFICATIONBTNNOIR);
			btn.width=120;
			btn.addEventListener(starling.events.Event.TRIGGERED, sidentifierButton_triggeredHandler);
			var qd:Quad=new Quad(5,1,0xFFB600);
			sc.addChild(qd);
			sc.addChild(btn);
			
						
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
			
			_container.y=20;
			_container.width=260;
			_container.x=(this.actualWidth-_container.width)/2;
			_container.height=440;
			
			
		}
		
		private function creer():void{
			trace("appel de creer");
			var xloaderq:URLLoader= new URLLoader();
			xloaderq.addEventListener(flash.events.Event.COMPLETE, xmlinfosLoaded);
			xloaderq.addEventListener(IOErrorEvent.IO_ERROR, onError);
			var zurl:URLRequest=new URLRequest(FBUserFactory.getUser().prefix+"/jsoncreer?rnd="+Math.random());
			zurl.method = URLRequestMethod.POST;
			var zdata:URLVariables=new URLVariables();
			zdata.iduser=FBUserFactory.getUser().user.IDUSER;
			zdata.email=_email.text;
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
			_laberrormail.text=" ";
			_laberrormail.height=1;
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
		//slimpay => à voir pr la solution de rib
		//allomatch
		
		private function onBackButton():void
		{
			trace("bacckbutton");
			Root.ouvrircarto();
			this.dispatchEventWith(starling.events.Event.COMPLETE);
		}
		
		private function sidentifierButton_triggeredHandler(event:starling.events.Event):void
		{
			trace("click sidetifier");
			this.dispatchEventWith("sidentifierscreen",true);
		}
		private function creerButton_triggeredHandler(event:starling.events.Event):void
		{
			trace("click");
			creer();
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