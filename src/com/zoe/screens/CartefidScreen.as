package com.zoe.screens
{
	import com.zoe.composants.Homercloader;
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
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.utils.Color;
	
	[Event(name="complete",type="starling.events.Event")]
	[Event(name="validercartefidscreen",type="starling.events.Event")]
	
	public class CartefidScreen extends Screen
	{

		private var _backButton:Button;
		private var _iconmsg:Image;
		private var _labelico:Label;
		
		private var _labelcgu:Label;
		public var partie:com.zoe.objects.Partie;
		private var _containerblanc:ScrollContainer;

		private var rcl:Homercloader;
		private var _labelmsg:Label;

		private var _bigscroll:ScrollContainer;
		public function CartefidScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("cartefid initialize");
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
			_labelico.text="Carte de fidélité";
//			addChild(_labelico);
			
			_bigscroll=new ScrollContainer();
			_bigscroll.verticalScrollPolicy=ScrollContainer.SCROLL_POLICY_ON;
			addChild(_bigscroll);
			
			_containerblanc=new ScrollContainer();
			var unetex:Scale3Textures=new Scale3Textures(Root.assets.getTexture("fondblancprofil"),34,2,Scale3Textures.DIRECTION_VERTICAL);
			_containerblanc.backgroundSkin=new Scale3Image(unetex);
			_containerblanc.height=300;
			
			//leptitfond.addChild(new Image(Root.assets.getTexture("fondblancprofil")));
			var lab:Label=new Label();
			lab.nameList.add(ZoeMobileTheme.CARTEFIDVOIR);
			lab.text="Carte de fidélité";
			_containerblanc.addChild(lab);
			var icofid:Image=new Image(Root.assets.getTexture("cartefid"));
			_containerblanc.addChild(icofid);
			icofid.x=200;
			icofid.y=5;
			lab.x=100;
			lab.y=5;
			
/*			var qq:Quad=new Quad(240,400,Color.WHITE);
			_containerblanc.addChild(qq);
			qq.y=30;
			qq.x=leptitfond.x;
*/			
			var nomshop:Label=new Label();
			nomshop.nameList.add(ZoeMobileTheme.ACTULABELNOMSHOP);
			nomshop.text=partie.nomshop;
			nomshop.x=10;
			nomshop.width=220;
			nomshop.y=35;
			_containerblanc.addChild(nomshop);

			_labelcgu=new Label();
			_labelcgu.nameList.add(ZoeMobileTheme.CARTEFIDCGU);
			_labelcgu.text="Veuillez patienter...";
			_labelcgu.x=10;
			_labelcgu.width=220;
			_labelcgu.y=55;
			_containerblanc.addChild(_labelcgu);

			
			// loader et recuperation
			rcl=new Homercloader();
			addChild(rcl);	
			rcl.start();
			_labelmsg=new Label();
			_labelmsg.nameList.add(ZoeMobileTheme.ROOT_LABPRG);
			addChild(_labelmsg);
			_labelmsg.text="Récupération de la \n liste de vos cartes de fidélité";
			
//			_container.visible=false;
			_bigscroll.addChild(_containerblanc);
			recupmestampons();
		
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
			
			_bigscroll.y=40;
			_bigscroll.height=440;
			
			_containerblanc.width=242;
			_containerblanc.x=(this.actualWidth-_containerblanc.width)/2;
			_containerblanc.height=420;

			rcl.x=this.actualWidth/2;
			rcl.y=220;
			_labelmsg.width=this.actualWidth;
			_labelmsg.y=rcl.y+60;

		}
		
		private function recupmestampons():void{
			trace("appel de recupmestampons");
			var xloaderq:URLLoader= new URLLoader();
			xloaderq.addEventListener(flash.events.Event.COMPLETE, xmlinfosLoaded);
			xloaderq.addEventListener(IOErrorEvent.IO_ERROR, onError);
			var zurl:URLRequest=new URLRequest(FBUserFactory.getUser().prefix+"/jsonrecuptampons?rnd="+Math.random());
			zurl.method = URLRequestMethod.POST;
			var zdata:URLVariables=new URLVariables();
			zdata.iduser=FBUserFactory.getUser().user.IDUSER;
			zdata.idshop=Root.partie.idshop;
			zurl.data=zdata;
			xloaderq.load (zurl);
		}
		private function xmlinfosLoaded(event:flash.events.Event):void {
			trace("Recup du post");
			var loader:URLLoader = URLLoader(event.target);
			var zret:Object =JSON.parse(loader.data);
			trace("zret.ok=>"+zret.ok);
			
			if(zret.ok==1){
				trace("xmlinfosLoaded ok");
				// on affiche en conséquence
				// parcours des msg
				rcl.stop();
				_labelmsg.text="";
				// creation du container
//				scrollc.backgroundSkin=new Te				
				// afichage des x tampons
				if(zret.shop){
					// maj des cgu
					_labelcgu.text=zret.shop.CGUFID;						
					
				} else {
					rcl.stop();
					_labelmsg.text="Nous sommes désolé, \nune erreur technique est survenue";
				}
				// ajout des tampons
				var _container:ScrollContainer=new ScrollContainer();
				_container.backgroundSkin=new Scale9Image(new Scale9Textures(Root.assets.getTexture("fondorangeprofil"),new Rectangle(20,20,50,20)));
				
				var imglogo:Image=new Image(Root.assets.getTexture("logocartefid"));
				var labpresenter:Label=new Label();
				labpresenter.nameList.add(ZoeMobileTheme.CARTEFIDPRESENTER);
				labpresenter.text="Présentez votre mobile au commerçant \npour qu'il valide votre achat";
				labpresenter.x=10;
				labpresenter.width=280;
				labpresenter.y=50;
				
				var conttampon:ScrollContainer=new ScrollContainer();

				_container.addChild(imglogo);
				_container.addChild(labpresenter);
				_bigscroll.addChild(_container);
				_container.y=130;
				_container.width=304;
				imglogo.x=(_container.width-imglogo.width)/2;
				imglogo.y=10;
				//_container.height=200;
				_container.x=_containerblanc.x-34;
				conttampon.y=80;
				conttampon.width=300;
				
				if(zret.tampons){
					
					var hl:TiledRowsLayout=new TiledRowsLayout();
					conttampon.layout=hl;
					hl.paddingLeft=10;
					hl.paddingRight=10;
//					hl.horizontalAlign=TiledRowsLayout.HORIZONTAL_ALIGN_CENTER;
					hl.paddingTop=10;
					hl.paddingBottom=40;
					hl.gap=10;
					_container.addChild(conttampon);
					for(var i:int=0;i<zret.tampons.length;i++){
						trace("ajout du tampon "+i);
						if(zret.tampons[i].IDTBLUSERCARTEFIDTAMPON>0){
							var tpn:Button=new Button();
							tpn.nameList.add(ZoeMobileTheme.CARTEFIDTPNOK);
							tpn.label=zret.tampons[i].DATETAMPON;
							tpn.width=70;
							tpn.height=71;
							
							conttampon.addChild(tpn);
						} else {
							var tpnko:Button=new Button();
							tpnko.width=70;
							tpnko.height=71;
							tpnko.nameList.add(ZoeMobileTheme.CARTEFIDTPNKO);
							tpnko.label="Cliquez ici pour valider";
							conttampon.addChild(tpnko);
							tpnko.addEventListener(starling.events.Event.TRIGGERED,btntpn_triggered);
						}
						
					}
				}			
			}	
		}
		private function onBackButton():void
		{
			trace("bacckbutton");
			this.dispatchEventWith(starling.events.Event.COMPLETE);
		}		
		private function btntpn_triggered(event:starling.events.Event):void
		{
			trace("click tampon");
			this.dispatchEventWith(Root.VALIDERCARTEFID_SCREEN);
			
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