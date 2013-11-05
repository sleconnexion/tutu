package com.zoe.screens
{
	import com.zoe.composants.Popupneterror;
	import com.zoe.objects.FBUserFactory;
	import com.zoe.objects.Partie;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import flash.net.dns.AAAARecord;
	
	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.PageIndicator;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.controls.ToggleSwitch;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	import feathers.themes.ZoeMobileTheme;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.Color;
	
	[Event(name="messsagescreen",type="starling.events.Event")]

	public class FichecoScreen extends Screen
	{

		private var _backButton:Button;
		private var _iconmsg:Image;
		private var _labelico:Label;

		private var _labnom:Label;
		private var _labadresse:Label;
		private var _btnmsg:Button;
		private var _btntel:Button;
		private var _imgcateg1:Image;
		private var _imgcateg2:Image;
		private var _labcateg:Label;
		private var _spritefid:Sprite;
		private var _labhoraire:Label;
		private var _labdesc:Label;
		private var _labdesctitre:Label;
		private var _btnsuivre:Button;
		private var _tgnotif:ToggleSwitch;

		private var _scrollvertical:ScrollContainer;
		public var partie:com.zoe.objects.Partie;
		
		private var containertof:ScrollContainer;
		private var pg:PageIndicator;
		private var leshop:Object;
		public function FichecoScreen()
		{
			super();	
		}
		
		override protected function initialize():void
		{
			trace("ficheco initialize");
			var q:Quad=new Quad(stage.width,stage.height,0x111111,false);
//			q.alpha=0.7;
			addChild(q);
			this._backButton = new Button();
			this._backButton.label = "retour";
			_backButton.nameList.add(ZoeMobileTheme.BOUTON_BACK);
			this._backButton.addEventListener(starling.events.Event.TRIGGERED, backButton_triggeredHandler);
			this.backButtonHandler = this.onBackButton;			
			addChild(_backButton);
			// zone du milieu
/*			_iconmsg=new Image(Root.assets.getTexture("pictomessage"));
//			addChild(_iconmsg);
			_labelico=new Label();
			_labelico.nameList.add(ZoeMobileTheme.LABEL_ICO);
//			_labelico.text=" ";
//			addChild(_labelico);
*/			
			_scrollvertical=new ScrollContainer();
			var ly:VerticalLayout=new VerticalLayout();
			ly.horizontalAlign=VerticalLayout.HORIZONTAL_ALIGN_LEFT;
			ly.gap=10;
			ly.paddingLeft=10;
			_scrollvertical.layout=ly;
			_scrollvertical.horizontalScrollPolicy=Scroller.SCROLL_BAR_DISPLAY_MODE_NONE;
			addChild(_scrollvertical);
			
			
			// pr les photos
			var layout:TiledRowsLayout= new TiledRowsLayout();			
			layout.gap = 5;
			containertof= new ScrollContainer();
			var qb:Quad=new Quad(10,10,Color.WHITE);
			containertof.backgroundSkin=qb;
			containertof.layout = layout;			
			_scrollvertical.addChild(containertof);			
			
			layout.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_LEFT;
			layout.verticalAlign = TiledRowsLayout.VERTICAL_ALIGN_TOP;
			layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
			layout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
			layout.paging = TiledRowsLayout.PAGING_HORIZONTAL;
			
			containertof.scrollerProperties.snapToPages = true;
			containertof.addEventListener(starling.events.Event.SCROLL, list_scrollHandler);
			
			pg=new PageIndicator();
			pg.gap = 4;
			pg.paddingTop = 4;
			pg.horizontalAlign = PageIndicator.HORIZONTAL_ALIGN_CENTER;
			pg.verticalAlign = PageIndicator.VERTICAL_ALIGN_MIDDLE;
			pg.addEventListener(starling.events.Event.CHANGE, pageIndicator_changeHandler);

			_scrollvertical.addChild(pg);
			
			recupinfos();
		}
		
		override protected function draw():void
		{
			trace("draw ficheco");
			_backButton.x=5;
			_backButton.y=5;
			
/*			_iconmsg.x=100;
			_iconmsg.y=10;	
			_labelico.x=_iconmsg.x+30;
			_labelico.y=10;
			_labelico.width=200;
	*/		
			_scrollvertical.y=40;
			_scrollvertical.height=this.actualHeight-40;
			_scrollvertical.width=this.actualWidth;

			containertof.width=280;
			containertof.height=140;
//			pg.y=150;
			pg.width=300;//this.actualWidth;
//			_labelnom.y=160;
//			_labeladresse.y=530;

		}
		protected function list_scrollHandler(event:starling.events.Event):void
		{
			pg.selectedIndex = containertof.horizontalPageIndex;
		}
		
		protected function pageIndicator_changeHandler(event:starling.events.Event):void
		{
			containertof.scrollToPageIndex(pg.selectedIndex, 0, containertof.pageThrowDuration);
		}

		private function recupinfos():void{
			var xloaderq:URLLoader= new URLLoader();
			xloaderq.addEventListener(flash.events.Event.COMPLETE, xmlinfosLoaded);
			xloaderq.addEventListener(IOErrorEvent.IO_ERROR, onstartError);
			var zurl:URLRequest=new URLRequest(FBUserFactory.getUser().prefix+"/jsoninfoshop");
			zurl.method = URLRequestMethod.POST;
			var zdata:URLVariables=new URLVariables();
			zdata.iduser=FBUserFactory.getUser().user.IDUSER;
			trace("IDSHOP EN DUR 1 !:"+partie.idshop);
			zdata.idshop=15352;//partie.idshop;	
			zurl.data=zdata;
			xloaderq.load (zurl);
		}
		private function onstartError(e):void{
			trace("ficheco onstarterror");
			var unepopupneterror:Popupneterror=new Popupneterror(1);
			unepopupneterror.setsize(Starling.current.nativeStage.fullScreenWidth,Starling.current.nativeStage.fullScreenHeight);
			addChild(unepopupneterror);			
			//			lancer();
		}

		private function xmlinfosLoaded(event:flash.events.Event):void {
			var loader:URLLoader = URLLoader(event.target);
			var zret:Object =JSON.parse(loader.data);
			if(zret.ok==1){
				trace("xmlinfosLoaded ok");			
				if(zret.shop){
					leshop=zret.shop;
					if(zret.pics){
						var i:uint=0;
						for(var key:String in zret.pics) {
							i+=1;
							var imgloader:ImageLoader=new ImageLoader();
							trace("photo=>"+zret.pics[key].UID);
							imgloader.source="https://bucketzoe.s3.amazonaws.com/shoppic/"+zret.pics[key].UID;
							imgloader.height=140;	
							containertof.addChild(imgloader);
						}
						pg.pageCount=i;
					} else {
						containertof.addChild(new Image(Root.assets.getTexture("avatarpic")));
						/*
						//mettre une photovide
						var imgloadervide:ImageLoader=new ImageLoader();
						imgloadervide.source="https://bucketzoe.s3.amazonaws.com/avatar/images.jpg";
						containertof.addChild(imgloader);
						imgloader.height=140;
	//					pg.removeFromParent();
						*/
					}
					_scrollvertical.addChild(creerfichebig());
//					if(zret.shop.PRGFID){
						_scrollvertical.addChild(creerspritefid());
//					} 
					
					_scrollvertical.addChild(creerspriteaction());					

				} else {
					trace("Pb technique todo");
				}
			}
		}
		private function creerfichebig():Sprite {
			trace("fichebig sur "+leshop.NOMSHOP+ " "+leshop.TYPESHOP);
			var sp:Sprite=new Sprite();
			sp.width=300;
			sp.height=200;
			var bgt:Scale9Textures=new Scale9Textures(Root.assets.getTexture("fondblanc"),new Rectangle(0,15,300,5));
			var uneimg:Scale9Image=new Scale9Image(bgt);
			sp.addChild(uneimg);
			uneimg.height=200;
			uneimg.width=300;
			
			var scp:ScrollContainer=new ScrollContainer();
			scp.width=300;
			scp.horizontalScrollPolicy=Scroller.SCROLL_BAR_DISPLAY_MODE_NONE;
			sp.addChild(scp);
			scp.paddingLeft=10;
			var lyprincipal:VerticalLayout=new VerticalLayout();
			scp.layout=lyprincipal;
			
			// zone haute
			var sch:ScrollContainer=new ScrollContainer();
			sch.width=300;
			var lyh:HorizontalLayout=new HorizontalLayout();
			sch.layout=lyh;
			scp.addChild(sch);
			
			// zone de gauche
			var sczonegauche:ScrollContainer=new ScrollContainer();
			
			var lygv:VerticalLayout=new VerticalLayout();
			sczonegauche.layout=lygv;
			sczonegauche.horizontalScrollPolicy=Scroller.SCROLL_BAR_DISPLAY_MODE_NONE;
			sczonegauche.width=190;
			sczonegauche.paddingTop=25;
			sch.addChild(sczonegauche);
			
			// on affiche en conséquence
			//nom			
			_labnom=new Label();
			_labnom.nameList.add(ZoeMobileTheme.FICHECONOM);			
			_labnom.width=190;
			_labnom.text=leshop.NOMSHOP;			
			sczonegauche.addChild(_labnom);
			//categorie
			var scrimg:ScrollContainer=new ScrollContainer();
			scrimg.width=100;
			
			var hli:HorizontalLayout=new HorizontalLayout();
			scrimg.layout=hli;			
			sczonegauche.addChild(scrimg);
			
			_imgcateg1=new Image(Root.assets.getTexture(""+leshop.TYPECOMMERCE+"_solo"));
			scrimg.addChild(_imgcateg1);
			if(leshop.TYPECOMMERCE2>0){
				_imgcateg2=new Image(Root.assets.getTexture("favori"));
				scrimg.addChild(_imgcateg2);
			}
			// label cat
			_labcateg=new Label();
			_labcateg.nameList.add(ZoeMobileTheme.FICHECOLABTYPE);
			_labcateg.text=leshop.TYPECOMMERCELIB;
			_labcateg.width=190;
			sczonegauche.addChild(_labcateg);
			//adresse
			_labadresse=new Label();
			_labadresse.nameList.add(ZoeMobileTheme.FICHECOADRESSE);
			_labadresse.text=leshop.ADRESSESHOP;
			_labadresse.height=40;
			_labadresse.width=190;
			sczonegauche.addChild(_labadresse);
			//horaire
			var scrh:ScrollContainer=new ScrollContainer();
			scrh.horizontalScrollPolicy=Scroller.SCROLL_BAR_DISPLAY_MODE_NONE;
			scrh.width=190;
			var hlh:HorizontalLayout=new HorizontalLayout();
			scrh.layout=hlh;
			sczonegauche.addChild(scrh);
			
			var imghoraire:Image=new Image(Root.assets.getTexture("horloge"));
			scrh.addChild(imghoraire);
			
			_labhoraire=new Label();
			_labhoraire.nameList.add(ZoeMobileTheme.FICHECOHORAIRE);
			_labhoraire.width=190;
			_labhoraire.text=leshop.HORAIRE;
			scrh.addChild(_labhoraire);
			//enquelquesmots
			_labdesctitre=new Label();
			_labdesctitre.nameList.add(ZoeMobileTheme.FICHECODESCTITRE);
			_labdesctitre.width=100;
			_labdesctitre.text="En quelques mots";
			scp.addChild(_labdesctitre);
			
			_labdesc=new Label();
			_labdesc.nameList.add(ZoeMobileTheme.FICHECODESC);
			_labdesc.width=190;
			_labdesc.text=leshop.DESCRIPTION;
			scp.addChild(_labdesc);
						
			//zone de droite			
			var sczonedroite:ScrollContainer=new ScrollContainer();
			var lygd:VerticalLayout=new VerticalLayout();
			sczonedroite.layout=lygd;
			//			sczonedroite.width=80;
			sczonedroite.paddingTop=0;
			sch.addChild(sczonedroite);
			// on affiche
			
			var schh:ScrollContainer=new ScrollContainer();
			var lhh:HorizontalLayout=new HorizontalLayout();
			schh.layout=lhh;
			lhh.horizontalAlign=HorizontalLayout.HORIZONTAL_ALIGN_RIGHT;
			schh.width=95;
			_btnmsg=new Button();
			_btnmsg.nameList.add(ZoeMobileTheme.FICHECOBTNMSG);
			_btnmsg.label="XX";
			//schh.addChild(new Quad(20,1,Color.WHITE));
			schh.addChild(_btnmsg);
			sczonedroite.addChild(schh);
			
			
			_btntel=new Button();
			_btntel.nameList.add(ZoeMobileTheme.FICHECOBTNTEL);
			_btntel.label=leshop.TELEPHONE;
			sczonedroite.addChild(new Quad(1,20,Color.WHITE));
			sczonedroite.addChild(_btntel);
			
			return sp;
		}		
		private function creerspritefid():Sprite{
			var sp:Sprite=new Sprite();
			var q:Quad=new Quad(300,38,Color.WHITE);
			sp.addChild(q);
			
			var imgcf:Image=new Image(Root.assets.getTexture("cartefid"));
			imgcf.x=10;
			imgcf.y=8;
			sp.addChild(imgcf);
			
			var labcf:Label=new Label();
			labcf.nameList.add(ZoeMobileTheme.FICHECOCARTEFID);
			labcf.width=130;
			labcf.text="Carte de fidélité";
			sp.addChild(labcf);
			labcf.x=30;
			labcf.y=10;
			
			var labvcf:Label=new Label();
			labvcf.nameList.add(ZoeMobileTheme.FICHECOVOIRCARTEFID);
			labvcf.width=130;
			labvcf.text="Voir la carte de fidélité";
			sp.addChild(labvcf);
			labvcf.x=180;
			labvcf.y=12;
			
			var imgchevron:Image=new Image(Root.assets.getTexture("chevronmessage"));
			imgchevron.x=275;
			imgchevron.y=10;
			sp.addChild(imgchevron);
			
			return sp;			
		}
		private function creerspriteaction():Sprite{
			var sp:Sprite=new Sprite();
			var q:Quad=new Quad(300,60,Color.WHITE);
			sp.addChild(q);
			
			if(leshop.IDSHOP){
				// on le suit deja
				var btnnosuivre:Button=new Button();
				btnnosuivre.nameList.add(ZoeMobileTheme.FICHECOBTNNOSUIVRE);
				btnnosuivre.label="Ne plus suivre";
				btnnosuivre.x=10;
				btnnosuivre.y=20;
				sp.addChild(btnnosuivre);
			} else {
				// pas encore suivi on propose
				var btnsuivre:Button=new Button();
				btnsuivre.nameList.add(ZoeMobileTheme.FICHECOBTNSUIVRE);
				btnsuivre.label="Suivre";
				btnsuivre.x=10;
				btnsuivre.y=20;
				sp.addChild(btnsuivre);
			}
						
			var labalerte:Label=new Label();
			labalerte.nameList.add(ZoeMobileTheme.FICHECORECEVOIRALERTE);
			labalerte.width=130;
			labalerte.text="Recevoir des alertes";
			
			sp.addChild(labalerte);
			labalerte.x=210;
			labalerte.y=5;
						
			_tgnotif=new ToggleSwitch();
			_tgnotif.x=220;
			_tgnotif.y=20;
			if(leshop.NOTIF){
				_tgnotif.isSelected=true;
			} else {
				_tgnotif.isSelected=false;				
			}
			sp.addChild(_tgnotif);
			
			
			return sp;			
		}
				
		private function clickmsg(event:starling.events.Event):void
		{
			// 
			trace("clickmsg")
			navigateToURL(new URLRequest("tel:"+"0102030405"));
			
//			this.dispatchEventWith("messagescreen");
		}

		private function onBackButton():void
		{
			trace("bacckbutton");
			if(Root.partie.fromscreen==Root.MESCOMERCANTS_SCREEN){
				this.dispatchEventWith(Root.MESCOMERCANTS_SCREEN);
			} else {
				this.dispatchEventWith("complete");
			}
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